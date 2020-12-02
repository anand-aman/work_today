import 'package:flutter/material.dart';

class Category {
  var categoryBool;
  Category() {
    categoryBool = new List<bool>(categoryList.length);
    for (int i = 0; i < categoryList.length; i++) categoryBool[i] = false;
  }
  List<String> categoryList = [
    'Driver',
    'Sweeper',
    'Laundary',
    'Sanitisation',
    'Mason',
    'Plumber',
    'Security',
  ];
}
