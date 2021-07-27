import 'package:accord/constant/constant.dart';
import 'package:accord/models/category.dart';
import 'package:accord/responses/fetch_category_response.dart';
import 'package:accord/screens/shimmer/image_list_item.dart';
import 'package:accord/screens/widgets/category_display_format.dart';
import 'package:accord/viewModel/category_view_model.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AllCategoriesScreen extends StatefulWidget {
  const AllCategoriesScreen({Key key}) : super(key: key);

  @override
  _AllCategoriesScreenState createState() => _AllCategoriesScreenState();
}

class _AllCategoriesScreenState extends State<AllCategoriesScreen> {
  List<Category> _categories;

  @override
  initState() {
    getAllCategories().then((value) => setState(
          () {
            _categories = value;
          },
        ));
    super.initState();
  }

  Future<List<Category>> getAllCategories() async {
    CategoryViewModel categoryViewModel = new CategoryViewModel();
    FetchCategoryResponse fetchCategoryResponse =
        await categoryViewModel.fetchCategories();

    if (fetchCategoryResponse.success) {
      return fetchCategoryResponse.result;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            elevation: 0,
            snap: true,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("All Categories"),
              centerTitle: true,
              background: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      "assets/images/bookstore.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black38,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            pinned: true,
            expandedHeight: MediaQuery.of(context).size.height * 0.305,
          ),
          SliverGrid.count(
            crossAxisSpacing: 0,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 1.6),
            children: _categories != null
                ? List.generate(_categories.length, (index) {
                    Category categoryObj = _categories[index];
                    return Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      // margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                      child: CategoryDisplayFormat(
                        categoryObj: categoryObj,
                        index: index,
                      ),
                    );
                  })
                : List.generate(4, (index) {
                    return Shimmer.fromColors(
                      baseColor: Constant.shimmer_base_color,
                      highlightColor: Constant.shimmer_highlight_color,
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: ImageListItem(
                          index: index,
                          width: 175.0,
                          height: 219.0,
                        ),
                      ),
                    );
                  }),
          ),
        ],
      ),
    );
  }
}
