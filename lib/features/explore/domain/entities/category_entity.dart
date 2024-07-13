import 'package:flutter/material.dart';

abstract class CategoryEntity{
  final int? categoryId;
  final String name;
  final String? color;
  final String? icon;
  final String categorySlice;
  final String leftToSpend;
  final String spent;

  CategoryEntity({
     this.categoryId,
    required this.categorySlice,
     this.leftToSpend="",
     this.spent="",
     this.icon,
     this.color,
    required this.name});

}