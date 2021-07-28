import 'package:accord/models/book.dart';
import 'package:accord/screens/widgets/book_display_format.dart';
import 'package:accord/viewModel/book_view_model.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator_view/loading_indicator_view.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  FloatingSearchBarController _searchBarController;
  SharedPreferences pref;
  List<String> _searchHistory = [];
  static const historyLength = 5;

  List<String> filteredSearchHistoy;

  String selectedTerm;

  // get search history from local storage.
  Future<List<String>> getSearchHistory() async {
    pref = await SharedPreferences.getInstance();
    return pref.getStringList('searchHistory');
  }

  // filters and displays only relevant histories.
  // if no relevant history available, shows the same texts.
  // also reverse the list to show last added item at top.
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

  // adds the search-term that user just used to both variable & local storage
  // and updates filterSearchTerm to trigger reverse effect.
  Future<void> addSearchTerm(String term) async {
    pref = await SharedPreferences.getInstance();

    if (_searchHistory.contains(term)) {
      putSearchTermFirst(term);
      return;
    }
    // limits the length of search history to 5.
    // removes item at 0 index.
    if (_searchHistory.length == historyLength) {
      _searchHistory.removeAt(0);
    }

    _searchHistory.add(term);
    // updates in local storage.
    pref.setStringList('searchHistory', _searchHistory);

    // triggers filter after adding
    filteredSearchHistoy = filterSearchTerm(filter: null);
  }

  Future<void> deleteSearchTerm(String term) async {
    pref = await SharedPreferences.getInstance();

    // removes the item that matches with the term displayed in history.
    _searchHistory.removeWhere((t) => t == term);

    // updating the removed item in local storage as well.
    pref.setStringList('searchHistory', _searchHistory);

    // triggers filter after deleting.
    filteredSearchHistoy = filterSearchTerm(filter: null);
  }

  // if users search the term, already being displayed in history,
  // that term will be moved to last in the actual list.
  // but with reverse effect this will be displayed at top for users.
  void putSearchTermFirst(String term) {
    deleteSearchTerm(term);
    addSearchTerm(term);
  }

  @override
  void initState() {
    super.initState();
    // initializing search-history & filtered-search-history (reversed).
    getSearchHistory().then((historyList) => setState(() {
          _searchHistory = historyList ?? [];
          filteredSearchHistoy = historyList.reversed.toList();
        }));
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
        padding: EdgeInsets.all(2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: FloatingSearchBar(
                textInputType: TextInputType.text,
                isScrollControlled: true,
                clearQueryOnClose: true,
                closeOnBackdropTap: true,
                automaticallyImplyBackButton: true,
                autocorrect: true,
                backgroundColor: Colors.grey.shade200,
                backdropColor: Colors.black26,
                shadowColor: Colors.blue,
                controller: _searchBarController,
                body: FloatingSearchBarScrollNotifier(
                    // reseting the search_screen when user
                    //clicks on the search bar
                    child: _searchBarController.isClosed
                        ? SearchResultsListView(
                            searchTerm: selectedTerm,
                          )
                        : SearchResultsListView(
                            searchTerm: null,
                          )),
                transition: CircularFloatingSearchBarTransition(),
                physics: BouncingScrollPhysics(),
                title: Text(selectedTerm ?? 'Search for books...',
                    style: TextStyle(
                      color: Colors.black87,
                    )),
                hint: 'Search for books...',
                actions: [
                  FloatingSearchBarAction.searchToClear(),
                ],
                onQueryChanged: (query) {
                  setState(() {
                    // triggers filter with each change in search bar.
                    filteredSearchHistoy = filterSearchTerm(filter: query);
                  });
                },
                onSubmitted: (query) {
                  setState(() {
                    // doing nothing if the search-term is empty.
                    if (_searchBarController.query.isNotEmpty) {
                      addSearchTerm(query);
                      selectedTerm = query;
                    }
                  });
                  _searchBarController.close();
                },
                builder: (context, transition) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Material(
                        color: Colors.grey.shade100,
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
    final fsb = FloatingSearchBar.of(context);

    // displaying holders when search bar is empty or null
    if (searchTerm == null || searchTerm.isEmpty) {
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

    // search result container
    return Container(
      padding: EdgeInsets.only(top: fsb.widget.height * 1.5, left: 2, right: 2),
      child: FutureBuilder(
          future: BookViewModel().fetchSearchedBooks(searchTerm),
          builder: (context, searchSnap) {
            if (searchSnap.hasData) {
              // notifying users that there is no books available
              // related to the term they just searched.
              if (searchSnap.data.result.length == 0) {
                return Container(
                  padding: EdgeInsets.only(
                    top: fsb.widget.height * 1.5,
                    left: 5,
                    right: 2,
                  ),
                  child: Text(
                    "Sorry, we couldn't find any books containing words, $searchTerm.",
                    style: TextStyle(
                      color: Colors.black38,
                      fontSize: 18,
                      letterSpacing: -1,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                );
              } else {
                // the above future returns the response containing a List<Book>
                // here,converting that List<Book> into Map<String, List<Book>>
                // in order to categorize books according to their category.
                Map<String, List<Book>> categorizedBooks = categorizeBooks(
                    searchSnap.data.result, (book) => book.category);

                return ListView.builder(
                    itemCount: categorizedBooks.length,
                    itemBuilder: (BuildContext context, int index) {
                      // keys: categoryID as key in map
                      String categoryTitle =
                          categorizedBooks.keys.elementAt(index);
                      // values: List<Book>
                      List<Book> books =
                          categorizedBooks.values.elementAt(index);
                      return Container(
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.bottomLeft,
                              margin: EdgeInsets.only(left: 5),
                              child: Text(
                                categoryTitle,
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 22.5,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            CustomScrollView(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              primary: false,
                              slivers: <Widget>[
                                SliverGrid.count(
                                  crossAxisCount: 2,
                                  childAspectRatio:
                                      MediaQuery.of(context).size.width /
                                          (MediaQuery.of(context).size.height),
                                  children:
                                      List.generate(books.length, (index) {
                                    Book book = books[index];
                                    return BookDisplayFormat(
                                      book: book,
                                      index: index,
                                    );
                                  }),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      );
                    });
              }
            }
            // displaying progress while searching takes place.
            return Center(
              child: BallClipRotateMultipleIndicator(
                maxRadius: 50,
                minRadius: 30,
                dashCircleRadius: 15,
                color: Colors.black26,
              ),
            );
          }),
    );
  }
}

// mapping: categorizing books according to their category.
// takes a List<Book> & categoryID (key) as inputs.
// arranges books with same categoryID as a whole list (List<Book>)
// denoted by its corresponding key (categoryID).
// return Map<String, List<Book>>.
Map<String, List<Book>> categorizeBooks<Book, String>(
    List<Book> books, String Function(Book) key) {
  var mapBooks = <String, List<Book>>{};
  for (Book book in books) {
    (mapBooks[key(book)] ??= []).add(book);
  }
  return mapBooks;
}
