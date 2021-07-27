import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  FloatingSearchBarController _searchBarController;
  static const historyLength = 5;
  List<String> _searchHistory = [];

  List<String> filteredSearchHistoy;

  String selectedTerm;

  List<String> filterSearchTerm({
    @required String filter,
  }) {
    if (filter != null && filter.isNotEmpty) {
      return _searchHistory.reversed
          .where((term) => term.startsWith(filter))
          .toList();
    } else {
      return _searchHistory.reversed.toList();
    }
  }

  void addSearchTerm(String term) {
    if (_searchHistory.contains(term)) {
      putSearchTermFirst(term);
      return;
    }
    _searchHistory.add(term);
    if (_searchHistory.length > historyLength) {
      _searchHistory.removeRange(0, _searchHistory.length - historyLength);
    }

    filteredSearchHistoy = filterSearchTerm(filter: null);
  }

  void deleteSearchTerm(String term) {
    _searchHistory.removeWhere((t) => t == term);
    filteredSearchHistoy = filterSearchTerm(filter: null);
  }

  void putSearchTermFirst(String term) {
    deleteSearchTerm(term);
    addSearchTerm(term);
  }

  @override
  void initState() {
    super.initState();
    _searchBarController = FloatingSearchBarController();
    filteredSearchHistoy = filterSearchTerm(filter: null);
  }

  @override
  void dispose() {
    _searchBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: FloatingSearchBar(
                textInputType: TextInputType.text,
                isScrollControlled: true,
                automaticallyImplyBackButton: true,
                autocorrect: true,
                controller: _searchBarController,
                body: FloatingSearchBarScrollNotifier(
                  child: SearchResultsListView(
                    searchTerm: selectedTerm,
                  ),
                ),
                transition: CircularFloatingSearchBarTransition(),
                physics: BouncingScrollPhysics(),
                title: Text(selectedTerm ?? 'Search for books...',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                    )),
                hint: 'Search for books...',
                actions: [
                  FloatingSearchBarAction.searchToClear(),
                ],
                onQueryChanged: (query) {
                  setState(() {
                    filteredSearchHistoy = filterSearchTerm(filter: query);
                  });
                },
                onSubmitted: (query) {
                  setState(() {
                    addSearchTerm(query);
                    selectedTerm = query;
                  });
                  _searchBarController.close();
                },
                builder: (context, transition) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Material(
                        color: Colors.white,
                        elevation: 4,
                        child: Builder(
                          builder: (context) {
                            if (filteredSearchHistoy.isEmpty &&
                                _searchBarController.query.isEmpty) {
                              return Container(
                                height: 56,
                                width: double.infinity,
                                alignment: Alignment.center,
                                child: Text(
                                  'Search & Explore new books',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              );
                            } else if (filteredSearchHistoy.isEmpty) {
                              return ListTile(
                                title: Text(_searchBarController.query),
                                leading: const Icon(Icons.search),
                                onTap: () {
                                  setState(() {
                                    addSearchTerm(_searchBarController.query);
                                    selectedTerm = _searchBarController.query;
                                  });
                                  _searchBarController.close();
                                },
                              );
                            } else {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: filteredSearchHistoy
                                    .map(
                                      (term) => ListTile(
                                        title: Text(
                                          term,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        leading: const Icon(Icons.history),
                                        trailing: IconButton(
                                          icon: const Icon(Icons.clear),
                                          onPressed: () {
                                            setState(() {
                                              deleteSearchTerm(term);
                                            });
                                          },
                                        ),
                                        onTap: () {
                                          setState(() {
                                            putSearchTermFirst(term);
                                            selectedTerm = term;
                                          });
                                          _searchBarController.close();
                                        },
                                      ),
                                    )
                                    .toList(),
                              );
                            }
                          },
                        )),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SearchResultsListView extends StatelessWidget {
  final String searchTerm;

  const SearchResultsListView({Key key, this.searchTerm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (searchTerm == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_rounded,
              size: 64,
              color: Colors.black38,
            ),
            Text(
              "Start your book exploration.",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black38,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      );
    }

    final fsb = FloatingSearchBar.of(context);

    return ListView(
      padding: EdgeInsets.only(
        top: fsb.widget.height + 80,
      ),
      children: List.generate(
        20,
        (index) => ListTile(
          title: Text('$searchTerm search result'),
          subtitle: Text(index.toString()),
        ),
      ),
    );
  }
}
