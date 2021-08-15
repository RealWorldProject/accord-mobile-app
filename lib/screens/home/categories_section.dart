import 'package:accord/constant/accord_labels.dart';
import 'package:accord/models/category.dart';
import 'package:accord/screens/shimmer/image_list_item.dart';
import 'package:accord/screens/widgets/category_display_format.dart';
import 'package:accord/screens/widgets/custom_label.dart';
import 'package:accord/utils/exposer.dart';
import 'package:accord/viewModel/category_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'category/all_categories_screen.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({Key key}) : super(key: key);

  dynamic categorySectionShimmer() {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) {
        return ImageListItem(
          index: index,
          margin: EdgeInsets.only(right: 20),
        );
      },
    );
  }

  dynamic displayCategoryData(List<Category> categories) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: categories.length,
      itemBuilder: (BuildContext context, int index) {
        Category categoryObj = categories[index];
        return CategoryDisplayFormat(
          categoryObj: categoryObj,
          index: index,
          margin: EdgeInsets.only(right: 20),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                textToShow: AccordLabels.categoriesLabel,
                fontSize: 21,
                fontWeight: FontWeight.w600,
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
                  child: CustomText(
                    textToShow: AccordLabels.viewAll,
                    fontSize: 12,
                    fontWeight: FontWeight.w200,
                    textColor: Colors.blue[900],
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
            child: Consumer<CategoryViewModel>(
              builder: (context, categoryViewModel, child) {
                if (categoryViewModel.data.status == Status.LOADING ||
                    categoryViewModel.data.status == Status.ERROR) {
                  return categorySectionShimmer();
                } else {
                  return displayCategoryData(categoryViewModel.categories);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
