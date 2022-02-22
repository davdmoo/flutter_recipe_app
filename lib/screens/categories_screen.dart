import "package:flutter/material.dart";

import '../dummy_data.dart';
import '../widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(20),
      children: DUMMY_CATEGORIES
        .map((cat) => CategoryItem(
            cat.id,
            cat.title,
            cat.color,
          )).toList(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 2, // for 200 width, the height is 300 px
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
      ),
    );
  }
}