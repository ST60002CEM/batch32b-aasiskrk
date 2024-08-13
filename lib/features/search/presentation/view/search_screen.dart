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
            backgroundColor: BottomAppBarTheme.of(context).color,
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Enter search term...',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: _onSearch,
                  ),
                ),
                onSubmitted: (_) => _onSearch(),
              ),
            ),
            Expanded(
              child: state.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : state.searchResults.isEmpty
                      ? const Center(child: Text('No posts found'))
                      : ListView.builder(
                          itemCount: state.searchResults.length,
                          itemBuilder: (context, index) {
                            final search = state.searchResults[index];
                            return _buildPostItem(search);
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPostItem(ForumPostEntity search) {
    return Card(
      child: ListTile(
        leading: search.postPicture != null
            ? Image.network(
                '${ApiEndpoints.imageBaseUrl}${(search.postPicture).toString() ?? ''}')
            : const Icon(Icons.image),
        title: Text(search.postTitle),
        subtitle: Text(search.postDescription),
        onTap: () {
          // Navigate to post details screen
        },
      ),
    );
  }
}
