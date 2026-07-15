import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/menu_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/menu_item_card.dart';
import '../widgets/custom_search_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  List<dynamic> _searchResults = [];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    final menuProvider = context.read<MenuProvider>();
    if (query.isEmpty) {
      setState(() => _searchResults = []);
      return;
    }

    final itemResults = menuProvider.searchItems(query);
    setState(() => _searchResults = itemResults);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text('Search', style: Theme.of(context).textTheme.headlineSmall),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        child: Column(
          children: [
            CustomSearchBar(
              controller: _searchController,
              onChanged: _performSearch,
            ),
            const SizedBox(height: AppTheme.spacing24),
            if (_searchResults.isEmpty && _searchController.text.isEmpty)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_outlined,
                        size: 80,
                        color: AppTheme.textHint,
                      ),
                      const SizedBox(height: AppTheme.spacing16),
                      Text(
                        'Search for delicious food',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: AppTheme.spacing8),
                      Text(
                        'Type something to get started',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              )
            else if (_searchResults.isEmpty && _searchController.text.isNotEmpty)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_off_outlined,
                        size: 80,
                        color: AppTheme.textHint,
                      ),
                      const SizedBox(height: AppTheme.spacing16),
                      Text(
                        'No results found',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: AppTheme.spacing8),
                      Text(
                        'Try searching with different keywords',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              )
            else
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: AppTheme.spacing12,
                    mainAxisSpacing: AppTheme.spacing12,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: _searchResults.length,
                  itemBuilder: (context, index) {
                    final item = _searchResults[index];
                    return MenuItemCard(item: item);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
