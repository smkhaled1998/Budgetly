// widgets/category_dialogs.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryColorDialog extends StatelessWidget {
  final Color selectedColor;
  final Function(Color) onColorSelected;

  const CategoryColorDialog({
    Key? key,
    required this.selectedColor,
    required this.onColorSelected,
  }) : super(key: key);

  static const List<Color> categoryColors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.purple,
    Colors.orange,
    Colors.teal,
    Colors.pink,
    Colors.indigo,
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Select Color",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: categoryColors.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    onColorSelected(categoryColors[index]);
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: categoryColors[index],
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryIconDialog extends StatelessWidget {
  final String selectedIcon;
  final Function(String) onIconSelected;

  const CategoryIconDialog({
    Key? key,
    required this.selectedIcon,
    required this.onIconSelected,
  }) : super(key: key);

  static const List<String> categoryIcons = [
    "assets/housing.png",
    "assets/food.png",
    "assets/transport.png",
    "assets/shopping.png",
    "assets/entertainment.png",
    "assets/health.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Text(
                "Select Icon",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: categoryIcons.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      onIconSelected(categoryIcons[index]);
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Image.asset(
                        categoryIcons[index],
                        width: 32,
                        height: 32,
                      ),
                    ),
                  );
                },
              ),
            ])));
  }
}
