import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/constants/api_endpoint.dart';
import '../../../dashboard/domain/entity/forum_entity.dart';
import '../../../dashboard/presentation/viewmodel/forum_view_model.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch() {
    final searchTerm = _searchController.text.trim();
    if (searchTerm.isNotEmpty) {
      ref.read(forumViewModelProvider.notifier).searchPosts(searchTerm);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(forumViewModelProvider);

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(47.0),
          child: AppBar(
            title: const Text(
              "Search Posts",
              style: TextStyle(fontSize: 16),
            ),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Theme.of(context).canvasColor,
          ),
        ),
        body: Container(
          color: Theme.of(context).primaryColorDark,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[900],
                    hintText: 'Enter search term...',
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    prefixIcon: const Icon(Icons.search, color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[700]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  onChanged: (_) => _onSearch(),
                ),
              ),
              Expanded(
                child: state.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: Colors.green,
                      ))
                    : state.searchResults.isEmpty
                        ? const Center(
                            child: Text('No posts found',
                                style: TextStyle(color: Colors.white)))
                        : ListView.separated(
                            itemCount: state.searchResults.length,
                            separatorBuilder: (context, index) => const Divider(
                              height: 1,
                              color: Colors.grey,
                            ),
                            itemBuilder: (context, index) {
                              final search = state.searchResults[index];
                              return _buildPostItem(search);
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPostItem(ForumPostEntity search) {
    return Card(
      color: Theme.of(context).canvasColor,
      child: ListTile(
        leading: search.postPicture != null
            ? Image.network(
                '${ApiEndpoints.imageBaseUrl}${(search.postPicture).toString() ?? ''}',
                width: 60,
                height: 60,
              )
            : const Icon(Icons.image, color: Colors.white),
        title:
            Text(search.postTitle, style: const TextStyle(color: Colors.white)),
        subtitle: Text(search.postDescription,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white70)),
        onTap: () {
          // Navigate to another page with post details
          ref.read(forumViewModelProvider.notifier).openPostPage(search.id);
        },
      ),
    );
  }
}
