//
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import '../../../../../../../core/themes/app_color.dart';
// import '../../../../core/domain/entities/category_entity.dart';
// import '../cubit/category_cubit.dart';
// import '../cubit/category_states.dart';
//
// class EditableCategoryCard extends StatelessWidget {
//   final bool isEditing;
//   final String selectedColor;
//   final String selectedIcon;
//   final CategoryEntity item;
//   final TextEditingController nameController;
//   final TextEditingController budgetController;
//   final VoidCallback onEditToggle;
//   final CategoryManagementCubit categoryCubit;
//
//   const EditableCategoryCard({
//     Key? key,
//     required this.isEditing,
//     required this.selectedColor,
//     required this.selectedIcon,
//     required this.nameController,
//     required this.budgetController,
//     required this.onEditToggle,
//     required this.item,
//     required this.categoryCubit,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return isEditing ? _buildEditingCard(context) : _buildDisplayCard(context);
//   }
//
//   Widget _buildEditingCard(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
//       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//       decoration: BoxDecoration(
//         boxShadow: const [
//           BoxShadow(
//             color: Colors.black26,
//             blurRadius: 10,
//             spreadRadius: 1,
//             offset: Offset(0, 5),
//           ),
//         ],
//         color: AppColor.backgroundCardShadow,
//         borderRadius: const BorderRadius.all(Radius.circular(15)),
//         border: Border.all(
//           color: AppColor.primaryColor,
//           width: 2,
//         ),
//       ),
//       child: _buildCardContent(true,context),
//     );
//   }
//
//   Widget _buildDisplayCard(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration:  BoxDecoration(
//         color: AppColor.backgroundCardShadow,
//         borderRadius: BorderRadius.all(Radius.circular(15)),
//       ),
//       child: _buildCardContent(false,context),
//     );
//   }
//
//   Widget _buildCardContent(bool isEditing,BuildContext context) {
//     return Row(
//       children: [
//         Container(
//           width: 45,
//           height: 45,
//           decoration: BoxDecoration(
//             color: categoryCubit.categoryColor,
//             shape: BoxShape.circle,
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Image.asset(
//               "categoryCubit.categoryIcon!",
//               width: 30,
//               height: 30,
//             ),
//           ),
//         ),
//         const Gap(15),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildNameField(isEditing),
//               if (isEditing) const SizedBox(height: 8),
//               _buildBudgetField(isEditing),
//             ],
//           ),
//         ),
//         Column(children: [
//          isEditing? _buildEditButton(isEditing,Icons.cancel,false,context): Container() ,
//           const Gap(15),
//           _buildEditButton(isEditing,Icons.done_outline_rounded,true,context),
//
//
//         ],)
//       ],
//     );
//   }
//
//   Widget _buildNameField(bool isEditing) {
//     if (isEditing) {
//       return Container(
//         decoration: BoxDecoration(
//           color: Colors.grey[100],
//           borderRadius: BorderRadius.circular(8),
//         ),
//         padding: const EdgeInsets.symmetric(horizontal: 8),
//         child: TextField(
//           controller: nameController,
//           style: const TextStyle(
//             color: Colors.black,
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//           ),
//           decoration: const InputDecoration(
//             hintText: "Category Name",
//             hintStyle: TextStyle(color: Colors.grey),
//             border: InputBorder.none,
//             suffixIcon: Icon(Icons.edit, size: 16, color: Colors.grey),
//           ),
//         ),
//       );
//     }
//     return Text(
//       categoryCubit.updatedCategoryName!,
//       style: const TextStyle(
//         color: Colors.black,
//         fontSize: 16,
//         fontWeight: FontWeight.bold,
//       ),
//     );
//   }
//
//   Widget _buildBudgetField(bool isEditing) {
//     if (isEditing) {
//       return Container(
//         decoration: BoxDecoration(
//           color: Colors.grey[100],
//           borderRadius: BorderRadius.circular(8),
//         ),
//         padding: const EdgeInsets.symmetric(horizontal: 8),
//         child: TextField(
//           controller: budgetController,
//           style: const TextStyle(
//             color: Colors.black,
//             fontSize: 12,
//             fontWeight: FontWeight.w500,
//           ),
//           decoration: const InputDecoration(
//             hintText: "Allocated Amount",
//             hintStyle: TextStyle(color: Colors.grey),
//             border: InputBorder.none,
//             suffixIcon: Icon(Icons.edit, size: 16, color: Colors.grey),
//           ),
//         ),
//       );
//     }
//     return Text(
//       "Budget Slice is ${categoryCubit.updatedAllocatedAmount}",
//       style:  TextStyle(
//         color: AppColor.textWhite,
//         fontSize: 12,
//         fontWeight: FontWeight.w500,
//       ),
//     );
//   }
//
//   Widget _buildEditButton(bool isEditing,IconData icon,bool isCanceled,BuildContext context) {
//     return IconButton(
//       onPressed:isEditing? (){
//         categoryCubit.updatedCategoryName=item.name;
//         categoryCubit.updatedAllocatedAmount=item.allocatedAmount;
//         categoryCubit.emit(ChangeAppearanceState(items: categoryCubit.fetchedCategories));
//         categoryCubit.toggleEditMode();
//
//       }: onEditToggle,
//       icon: Icon(
//         isEditing ? icon : Icons.edit,
//         color: AppColor.primaryColor,
//         size: isEditing ? 28 : 24,
//       ),
//     );
//   }
// }