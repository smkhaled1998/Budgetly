import 'package:flutter/material.dart';

import '../../../category_managment/presentation/widgets/budget-categories-list-explore-screen.dart';

class TabBarViewWidget extends StatelessWidget {
  const TabBarViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TabBarView(
      children: [
        // Remove SingleChildScrollView here
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: MainCategoriesListWidget(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Text("Categories Content"),
            ],
          ),
        ),
      ],
    );
  }
}
