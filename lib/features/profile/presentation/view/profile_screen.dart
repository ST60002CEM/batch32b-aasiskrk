import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_auth/local_auth.dart';
import 'package:playforge/core/common/profile_shimmer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../app/constants/api_endpoint.dart';
import '../../domain/entity/profile_entity.dart';
import '../viewmodel/profile_viewmodel.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  File? _selectedImage;
  File? _selectedProfile;
  bool _isFingerprintEnabled = false;

  Future<void> _pickImage(Function(File?) onImagePicked) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      onImagePicked(File(pickedFile.path));
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(profileViewModelProvider.notifier).getCurrentUser();
      _loadFingerprintPreference();
    });
  }

  Future<void> _loadFingerprintPreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isFingerprintEnabled = prefs.getBool('fingerprint_enabled') ?? false;
    });
  }

  Future<void> _toggleFingerprint(bool value) async {
    final localAuth = LocalAuthentication();
    bool didAuthenticate = false;
    if (value) {
      didAuthenticate = await localAuth.authenticate(
        localizedReason: 'Please authenticate to enable fingerprint login',
        options: const AuthenticationOptions(biometricOnly: true),
      );
    }

    if (!value || didAuthenticate) {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        _isFingerprintEnabled = value;
      });
      prefs.setBool('fingerprint_enabled', value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileViewModelProvider);

    if (profileState.isLoading) {
      return ProfileShimmer();
    }

    if (profileState.error != null) {
      return Center(child: Text('Error: ${profileState.error}'));
    }

    final profile = profileState.profile;

    if (profile == null) {
      return const Center(child: Text('No profile data'));
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(47.0),
        child: AppBar(
          title: const Text(
            "Profile",
            style: TextStyle(fontSize: 16),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Theme.of(context).canvasColor,
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Theme.of(context).primaryColorDark,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showEditProfileImageDialog(context);
                            },
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                '${ApiEndpoints.profileImageUrl}${profile.profilePicture}',
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            profile.fullname ?? 'No Name',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profile.email ?? 'No Email',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.grey),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            profile.phone ?? 'No Phone Number',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.grey),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            profile.address ?? 'No Address',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 35,
                      child: ElevatedButton(
                        onPressed: () {
                          _showEditUserDetailsDialog(context, profile);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[800],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 50,
                          ),
                        ),
                        child: const Text('Edit Profile'),
                      ),
                    ),
                    SizedBox(
                      height: 35,
                      child: ElevatedButton(
                        onPressed: () {
                          _showDeleteConfirmationDialog(context, profile.id!);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[800],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 37,
                          ),
                        ),
                        child: const Text('Delete Account'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Enable Fingerprint Authentication'),
                    Switch(
                      value: _isFingerprintEnabled,
                      onChanged: (value) {
                        _toggleFingerprint(value);
                      },
                    ),
                  ],
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () {
                    _showLogoutConfirmationDialog(context, ref);
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text('Logout'),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 20,
                    ),
                    backgroundColor: Colors.grey.shade200,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// Exi
// sting dialogs and helper methods should be placed here...

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
                    backgroundColor: Theme.of(context).canvasColor,
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

  void _showEditUserDetailsDialog(BuildContext context, ProfileEntity profile) {
    final nameController = TextEditingController(text: profile.fullname);
    final phoneController = TextEditingController(text: profile.phone);
    final addressController = TextEditingController(text: profile.address);
    final emailController = TextEditingController(text: profile.email);
    final passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit User Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
              ),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: addressController,
                decoration: const InputDecoration(labelText: 'Address'),
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child:
                  const Text('Cancel', style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () {
                final updatedProfile = profile.copyWith(
                  fullname: nameController.text,
                  phone: phoneController.text,
                  address: addressController.text,
                  email: emailController.text,
                );
                ref
                    .read(profileViewModelProvider.notifier)
                    .updateUser(updatedProfile);
                Navigator.of(context).pop();
              },
              child: const Text('Update Profile'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, String userId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Account'),
          content: const Text(
              'Are you sure you want to delete your account? This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child:
                  const Text('Cancel', style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () {
                ref.read(profileViewModelProvider.notifier).deleteUser(userId);
                Navigator.of(context).pop();
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
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
                Navigator.of(context).pop();
              },
              child:
                  const Text('Cancel', style: TextStyle(color: Colors.black)),
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
}
