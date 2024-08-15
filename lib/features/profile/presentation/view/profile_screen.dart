import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../app/constants/api_endpoint.dart';
import '../../../../core/shared_prefs/user_shared_prefs.dart';
import '../viewmodel/profile_viewmodel.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  File? _selectedImage;
  File? _selectedProfile;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(profileViewModelProvider.notifier).getCurrentUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileViewModelProvider);

    if (profileState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (profileState.error != null) {
      return Center(child: Text('Error: ${profileState.error}'));
    }

    final profile = profileState.profile;

    if (profile == null) {
      return const Center(child: Text('No profile data'));
    }

    print('Profile Entity: ${profileState.profile}');

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(47.0),
        child: AppBar(
          title: const Text('Profile', style: TextStyle(fontSize: 16)),
          centerTitle: true,
          backgroundColor: Theme.of(context).canvasColor,
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Theme.of(context).primaryColorDark,
          child: profileState.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          '${ApiEndpoints.profileImageUrl}${profile.profilePicture}',
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: IconButton(
                          icon: const Icon(Icons.camera, color: Colors.white),
                          onPressed: () => _showEditProfileImageDialog(context),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        profile.fullname ?? 'No Name',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        profile.email ?? 'No Email',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        profile.phone.toString() ?? 'No Phone Number',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        profile.address ?? 'No Address',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: () {
                          // Handle update profile
                        },
                        icon: const Icon(Icons.edit),
                        label: const Text('Update Profile'),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () {
                          // Handle delete account
                        },
                        icon: const Icon(Icons.delete),
                        label: const Text('Delete Account'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          minimumSize: const Size(double.infinity, 50),
                        ),
                      ),
                      const Spacer(),
                      TextButton.icon(
                        onPressed: () {
                          // Handle logout
                          _showLogoutConfirmationDialog(context, ref);
                        },
                        icon: const Icon(Icons.logout),
                        label: const Text('Logout'),
                        style: TextButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  void _showEditProfileImageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            Future<void> pickImage() async {
              final pickedFile =
                  await ImagePicker().pickImage(source: ImageSource.gallery);
              if (pickedFile != null) {
                setState(() {
                  _selectedProfile = File(pickedFile.path);
                });
              }
            }

            return AlertDialog(
              title: const Text('Edit Profile Image'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: pickImage,
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      shadowColor: Colors.blueAccent,
                      backgroundColor: Colors.blueAccent,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text('Choose Image',
                        style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(height: 8),
                  if (_selectedProfile != null)
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: FileImage(_selectedProfile!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    elevation: 10,
                    shadowColor: Colors.redAccent,
                    backgroundColor: Colors.red,
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Handleling profile image update
                    ref
                        .read(profileViewModelProvider.notifier)
                        .updateProfile(_selectedProfile);
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    elevation: 10,
                    shadowColor: Colors.black,
                    backgroundColor: Colors.green,
                  ),
                  child: const Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

void _showLogoutConfirmationDialog(BuildContext context, WidgetRef ref) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Logout Confirmation'),
        content: const Text('Are you sure you want to logout?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Dismiss the dialog
            },
            child: const Text('Cancel', style: TextStyle(color: Colors.black)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              ref.read(profileViewModelProvider.notifier).openLoginPage();
            },
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      );
    },
  );
}
