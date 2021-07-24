import 'package:accord/screens/home/categories_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class SearchField extends StatefulWidget {
  const SearchField({Key key}) : super(key: key);

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  static const historyLength = 5;
  List<String> _searchHistory = [
    'fuchsia',
    'flutter',
    'widget',
    'resocoder',
    'new item'
  ];

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

  FloatingSearchBarController controller;

  @override
  void initState() {
    super.initState();
    controller = FloatingSearchBarController();
    filteredSearchHistoy = filterSearchTerm(filter: null);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: Column(
    //     mainAxisSize: MainAxisSize.min,
    //     children: [
    //       FloatingSearchBar(
    //         controller: controller,
    //         body: FloatingSearchBarScrollNotifier(
    //           child: SearchResultsListView(
    //             searchTerm: selectedTerm,
    //           ),
    //         ),
    //         transition: CircularFloatingSearchBarTransition(),
    //         physics: BouncingScrollPhysics(),
    //         title: Text(
    //           selectedTerm ?? 'The Search App',
    //           style: Theme.of(context).textTheme.headline6,
    //         ),
    //         hint: 'Search',
    //         actions: [
    //           FloatingSearchBarAction.searchToClear(),
    //         ],
    //         onQueryChanged: (query) {
    //           setState(() {
    //             filteredSearchHistoy = filterSearchTerm(filter: query);
    //           });
    //         },
    //         onSubmitted: (query) {
    //           setState(() {
    //             addSearchTerm(query);
    //             selectedTerm = query;
    //           });
    //           controller.close();
    //         },
    //         builder: (context, transition) {
    //           return ClipRRect(
    //             borderRadius: BorderRadius.circular(8),
    //             child: Material(
    //                 color: Colors.white,
    //                 elevation: 4,
    //                 child: Builder(
    //                   builder: (context) {
    //                     if (filteredSearchHistoy.isEmpty &&
    //                         controller.query.isEmpty) {
    //                       return Container(
    //                         height: 56,
    //                         width: double.infinity,
    //                         alignment: Alignment.center,
    //                         child: Text(
    //                           'Search Here',
    //                           maxLines: 1,
    //                           overflow: TextOverflow.ellipsis,
    //                           style: Theme.of(context).textTheme.caption,
    //                         ),
    //                       );
    //
    //                     }else if (filteredSearchHistoy.isEmpty){
    //                       return ListTile(
    //                         title: Text(controller.query),
    //                         leading: const Icon(Icons.search),
    //                         onTap: (){
    //                           setState(() {
    //                             addSearchTerm(controller.query);
    //                             selectedTerm=controller.query;
    //
    //                           });
    //                           controller.close();
    //                         },
    //
    //                       );
    //
    //                     }else{
    //                       return Column(
    //                         mainAxisSize: MainAxisSize.min,
    //
    //                         children: filteredSearchHistoy.map((term) => ListTile(
    //                           title: Text(
    //                             term,
    //                             maxLines: 1,
    //                             overflow: TextOverflow.ellipsis,
    //                           ),
    //                           leading: const Icon(Icons.history),
    //                           trailing: IconButton(
    //                             icon: const Icon(Icons.clear),
    //                             onPressed: (){
    //                               setState(() {
    //                                 deleteSearchTerm(term);
    //                               });
    //                             },
    //                           ),
    //                           onTap: (){
    //                             setState(() {
    //                               putSearchTermFirst(term);
    //                               selectedTerm= term;
    //                             });
    //                             controller.close();
    //                           },
    //                         ),).toList(),
    //                       );
    //                     }
    //                   },
    //                 )),
    //           );
    //         },
    //       ),
    //     ],
    //   ),
    // );
    return Container(
      height: 60,
      padding: EdgeInsets.all(10),
      child: TextField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.circular(50),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          hintText: "Search",
          prefixIcon: Icon(Icons.search_rounded),
          suffixIcon:
              IconButton(onPressed: () {}, icon: Icon(Icons.close_rounded)),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.circular(50),
          ),
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
          children: [CategoriesSection()],
        ),
      );
    }

    final fsb = FloatingSearchBar.of(context);

    return ListView(
      padding: EdgeInsets.only(top: 30),
      children: List.generate(
        50,
        (index) => ListTile(
          title: Text('$searchTerm search result'),
          subtitle: Text(index.toString()),
        ),
      ),
    );
  }
}
