import 'package:accord/constant/accord_labels.dart';
import 'package:accord/models/category.dart';
import 'package:accord/screens/shimmer/image_list_item.dart';
import 'package:accord/screens/widgets/category_display_format.dart';
import 'package:accord/viewModel/category_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllCategoriesScreen extends StatelessWidget {
  const AllCategoriesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Category> categories = context.read<CategoryViewModel>().categories;

    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            elevation: 0,
            snap: true,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(AccordLabels.allCategoriesLabel),
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
            children: categories != null
                ? List.generate(categories.length, (index) {
                    Category categoryObj = categories[index];
                    return Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: CategoryDisplayFormat(
                        categoryObj: categoryObj,
                        index: index,
                      ),
                    );
                  })
                : List.generate(4, (index) {
                    return ImageListItem(
                      index: index,
                      width: 175.0,
                      height: 219.0,
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    );
                  }),
          ),
        ],
      ),
    );
  }
}
