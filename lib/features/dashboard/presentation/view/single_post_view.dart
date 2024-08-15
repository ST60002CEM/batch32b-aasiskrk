import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:playforge/features/dashboard/presentation/navigator/post_navigator.dart';
import 'package:playforge/features/forum/presentation/viewmodel/home_view_model.dart';
import 'package:vibration/vibration.dart';
import 'dart:io';

import '../../../../app/constants/api_endpoint.dart';
import '../../../../core/shared_prefs/user_shared_prefs.dart';
import '../../../dashboard/domain/entity/forum_entity.dart';
import '../../../dashboard/presentation/viewmodel/forum_view_model.dart';
import '../../../forum/domain/entity/post_entity.dart';
import '../../data/model/forum_api_model.dart';
import '../../domain/entity/comment_entity.dart';

class SinglePostView extends ConsumerStatefulWidget {
  final String postId;

  const SinglePostView({super.key, required this.postId});

  @override
  _SinglePostViewState createState() => _SinglePostViewState();
}

class _SinglePostViewState extends ConsumerState<SinglePostView> {
  UserSharedPrefs? userSharedPrefs;
  final TextEditingController _commentController = TextEditingController();
  bool _isCommenting = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      userSharedPrefs = ref.read(userSharedPrefsProvider);
      await _loadPostDetails(widget.postId);
    });
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  String formatDateTime(String isoDate) {
    try {
      final DateTime dateTime = DateTime.parse(isoDate);
      final DateFormat formatter = DateFormat('MMM d, yyyy • h:mm a');
      return formatter.format(dateTime);
    } catch (e) {
      return 'Invalid date';
    }
  }

  void _likePost(String postId) async {
    await ref.read(forumViewModelProvider.notifier).likePost(postId);
  }

  void _dislikePost(String postId) async {
    await ref.read(forumViewModelProvider.notifier).dislikePost(postId);
  }

  Future<void> _addComment(String postId, AddCommentEntity comment) async {
    await ref.read(forumViewModelProvider.notifier).addComment(postId, comment);
    await _loadPostDetails(postId);
  }

  Future<void> _loadPostDetails(String postId) async {
    await ref.watch(forumViewModelProvider.notifier).getPosts(widget.postId);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(forumViewModelProvider);
    final post = state.singlePost;

    if (state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.green,
        ),
      );
    }

    if (state.error != null) {
      return Center(child: Text('Error: ${state.error}'));
    }

    if (post == null) {
      return const Center(child: Text('Create a post first 🕹️🫡'));
    }

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(47.0),
          child: state.isLoading
              ? const LinearProgressIndicator()
              : state.singlePost == null
                  ? const Center(child: Text('Create a post first 🕹️🫡'))
                  : AppBar(
                      title: _CustomTooltip(
                        message: "Post Title: ${post.postTitle}",
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            post.postTitle,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Times new roman',
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ),
                      ),
                      centerTitle: true,
                      elevation: 0,
                      backgroundColor: Theme.of(context).canvasColor,
                    ),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      color: Theme.of(context).primaryColorDark,
                      child: Card(
                        margin: EdgeInsets.all(0),
                        elevation: 0,
                        color: Theme.of(context).primaryColorDark,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 7),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      post.postedUserId?.profilePicture != null
                                          ? '${ApiEndpoints.profileImageUrl}${post.postedUserId?.profilePicture}'
                                          : 'https://via.placeholder.com/800x400',
                                    ),
                                    radius: 20,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              post.postedFullname,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                                formatDateTime(post.postedTime),
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                )),
                                          ],
                                        ),
                                        Wrap(
                                          spacing: 5.0,
                                          children: post.postTags
                                              .map((tag) =>
                                                  Chip(label: Text(tag)))
                                              .toList(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Text(
                                post.postTitle,
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: 'Times new roman'),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Image.network(
                              '${ApiEndpoints.imageBaseUrl}${post.postPicture ?? 'https://via.placeholder.com/800x400'}',
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          Icons.thumb_up,
                                          size: 18,
                                        ),
                                        onPressed: () {
                                          _likePost(post.id);
                                        },
                                      ),
                                      Text('${post.postLikes}'),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.thumb_down,
                                          size: 18,
                                        ),
                                        onPressed: () {
                                          _dislikePost(post.id);
                                        },
                                      ),
                                      Text('${post.postDislikes}'),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.comment,
                                          size: 18,
                                        ),
                                        onPressed: () {},
                                      ),
                                      Text('${post.postComments.length}'),
                                      const Spacer(),
                                      Padding(
                                        padding: EdgeInsets.only(right: 10),
                                        child: Text(
                                          'Views: ${post.postViews}',
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              height: 1,
                              color: Colors.white54,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 10, top: 10),
                              child: Text(
                                "Comment Section",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Times new roman',
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(
                              height: 1,
                              color: Colors.white54,
                            ),
                            // Comment Section
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: post.postComments.length,
                                itemBuilder: (context, index) {
                                  final comment = post.postComments[index];
                                  return ListTile(
                                    title: Text(
                                      comment.userName,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(
                                      comment.comment,
                                      style: const TextStyle(
                                          color: Colors.white70),
                                    ),
                                    trailing: Text(
                                      DateFormat('MMM d, yyyy hh:mm a')
                                          .format(comment.commentedAt),
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Divider(height: 1, color: Colors.white54),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _commentController,
                          decoration: const InputDecoration(
                            hintText: 'Add a comment...',
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            setState(() {
                              _isCommenting = value.isNotEmpty;
                            });
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: _isCommenting
                            ? () async {
                                await _addComment(
                                    widget.postId,
                                    AddCommentEntity(
                                      userId: "",
                                      comment: _commentController.text,
                                      commentedAt: DateTime.now().toString(),
                                      userName: "",
                                    ));
                                _commentController.clear();
                                setState(() {
                                  _isCommenting = false;
                                });
                              }
                            : null,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomTooltip extends StatefulWidget {
  final String message;
  final Widget child;

  const _CustomTooltip({required this.message, required this.child});

  @override
  __CustomTooltipState createState() => __CustomTooltipState();
}

class __CustomTooltipState extends State<_CustomTooltip> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () async {
        if (_overlayEntry == null) {
          _overlayEntry = _createOverlayEntry();
          Overlay.of(context)?.insert(_overlayEntry!);

          // Trigger vibration
          if (await Vibration.hasVibrator() ?? false) {
            Vibration.vibrate(
                duration: 100, amplitude: 200, intensities: [100], repeat: 2);
          }
        }
      },
      onLongPressEnd: (_) {
        _overlayEntry?.remove();
        _overlayEntry = null;
      },
      child: CompositedTransformTarget(
        link: _layerLink,
        child: widget.child,
      ),
    );
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          GestureDetector(
            onTap: () {
              _overlayEntry?.remove();
              _overlayEntry = null;
            },
            child: Container(
              color: Colors.black54, // Dim the background
              child: Center(
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      widget.message,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
