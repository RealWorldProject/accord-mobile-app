import 'package:accord/models/category.dart';
import 'package:accord/responses/fetch_category_response.dart';
import 'package:accord/screens/home/category/all_categories_screen.dart';
import 'package:accord/screens/widgets/category_display_format.dart';
import 'package:accord/viewModel/category_view_model.dart';
import 'package:flutter/material.dart';

class CategoriesSection extends StatefulWidget {
  const CategoriesSection({Key key}) : super(key: key);

  @override
  _CategoriesSectionState createState() => _CategoriesSectionState();
}

class _CategoriesSectionState extends State<CategoriesSection> {
  Future<List<Category>> loadCategories() async {
    CategoryViewModel categoryViewModel = new CategoryViewModel();
    FetchCategoryResponse fetchCategoryResponse =
        await categoryViewModel.fetchCategories();

    if (fetchCategoryResponse.success) {
      return await fetchCategoryResponse.result;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10.0, top: 10.0),
      // padding: EdgeInsets.only(left: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 3.0),
                child: Text(
                  "Categories",
                  style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -1),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AllCategoriesScreen(),
                        ));
                  },
                  child: Text(
                    "View All",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w100,
                      color: Colors.blue[900],
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 180,
            child: FutureBuilder(
              future: loadCategories(),
              builder: (context, categoriesSnap) {
                if (categoriesSnap.hasData) {
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: categoriesSnap.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      Category categoryObj = categoriesSnap.data[index];
                      return Container(
                        margin: EdgeInsets.only(right: 20),
                        width: 132,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          color: Colors.black12,
                        ),
                        child: CategoryDisplayFormat(
                          categoryObj: categoryObj,
                          index: index,
                        ),
                      );
                    },
                  );
                }
                return Container();
              },
            ),
          )
        ],
      ),
    );
  }
}
