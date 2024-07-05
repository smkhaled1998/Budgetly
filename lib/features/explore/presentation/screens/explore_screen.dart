import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/themes/app_color.dart';
import '../widgets/category_card_widget.dart';
import '../widgets/category_edit_action_row.dart';
import '../widgets/header_widget.dart';

class ExploreScreen extends StatelessWidget {
  ExploreScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F8),
      body: ListView(
        padding: EdgeInsets.zero,
        children:   const [
          HeaderWidget(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                CategoryEditActionRow(),
                SizedBox(height: 10),
                CategoryCardWidget(),
               ],
            ),
          )



        ],
      ),
    );
  }
}
