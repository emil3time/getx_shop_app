import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Product {
  String? id;
  String title;
  String description;
  String imageUrl;
  double price;
  RxBool isFavorite = false.obs;

  Product({
    required this.description,
     this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
  });
  void toggleIsFavorite() {
    isFavorite.value = !isFavorite.value;
  }
}
