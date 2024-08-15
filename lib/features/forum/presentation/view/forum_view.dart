import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:playforge/features/forum/presentation/viewmodel/home_view_model.dart';
import 'package:playforge/features/profile/presentation/state/profile_state.dart';
import 'package:playforge/features/profile/presentation/viewmodel/profile_viewmodel.dart';
import '../../../auth/presentation/viewmodel/auth_view_model.dart';
import '../../../dashboard/domain/entity/forum_entity.dart';
import '../../../dashboard/presentation/state/forum_state.dart';
import '../../../dashboard/presentation/viewmodel/forum_view_model.dart';
import '../../domain/entity/post_entity.dart';

class ForumView extends ConsumerStatefulWidget {
  const ForumView({super.key});

  @override
  ConsumerState<ForumView> createState() => _ForumViewState();
}

class _ForumViewState extends ConsumerState<ForumView> {
  final _formKey = GlobalKey<FormState>();
  File? _image;
  final _postTitleController = TextEditingController();
  final _postDescriptionController = TextEditingController();
  final _tagsController = TextEditingController();

  @override
  void dispose() {
    _postTitleController.dispose();
    _postDescriptionController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image != null) {
        setState(() {
          _image = File(image.path);
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.request().isDenied) {
      await Permission.camera.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    // final currentUser = ref.watch(profileViewModelProvider);
    final forumViewModel = ref.read(forumViewModelProvider.notifier);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Create a post"),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Theme.of(context).canvasColor,
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                color: Theme.of(context).primaryColorDark,
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  backgroundColor:
                                      Theme.of(context).canvasColor,
                                  context: context,
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    ),
                                  ),
                                  builder: (context) => Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        ElevatedButton.icon(
                                          onPressed: () async {
                                            await _checkCameraPermission();
                                            _pickImage(ImageSource.camera);
                                            Navigator.pop(context);
                                          },
                                          icon: const Icon(Icons.camera),
                                          label: const Text('Camera'),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        ElevatedButton.icon(
                                          onPressed: () {
                                            _pickImage(ImageSource.gallery);
                                            Navigator.pop(context);
                                          },
                                          icon: const Icon(Icons.image),
                                          label: const Text('Gallery'),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              child: _image != null
                                  ? Image.file(
                                      _image!,
                                      height: 200,
                                      width: 200,
                                      fit: BoxFit.cover,
                                    )
                                  : Container(
                                      height: 200,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Icon(
                                        Icons.add_a_photo,
                                        color: Colors.grey,
                                        size: 50,
                                      ),
                                    ),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              key: const ValueKey('post_title'),
                              enableSuggestions: true,
                              textCapitalization: TextCapitalization.characters,
                              controller: _postTitleController,
                              decoration: InputDecoration(
                                labelText: 'Post Title',
                                labelStyle: const TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.green),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a post title';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              key: const ValueKey('post_description'),
                              controller: _postDescriptionController,
                              maxLines: 3,
                              decoration: InputDecoration(
                                labelText: 'Post Description',
                                labelStyle: const TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.green),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a post description';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              key: ValueKey('tags'),
                              controller: _tagsController,
                              decoration: InputDecoration(
                                labelText: 'Tags (comma separated)',
                                labelStyle: const TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.green),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some tags';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    ref
                                        .read(homeViewModelProvider.notifier)
                                        .addPost1(
                                          PostEntity(
                                            postPicture: _image,
                                            postTitle:
                                                _postTitleController.text,
                                            postDescription:
                                                _postDescriptionController.text,
                                            postTags:
                                                _tagsController.text.split(','),
                                            postLikes: 0,
                                            postDislikes: 0,
                                            postViews: 0,
                                            postedTime:
                                                DateTime.now().toString(),
                                            postedUserId: "",
                                            postedFullname: "",
                                            postComments: [],
                                            id: '',
                                          ),
                                          _image,
                                        );
                                    forumViewModel.resetState();

                                    Navigator.pop(context);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text('Create Post'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
