import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/constants/api_endpoint.dart';
import '../../../../core/shared_prefs/user_shared_prefs.dart';
import '../viewmodel/profile_viewmodel.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
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
          backgroundColor: BottomAppBarTheme.of(context).color,
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Theme.of(context).canvasColor,
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
}
