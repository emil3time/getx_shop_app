import 'package:flutter/material.dart';

class Product {
  String id;
  String title;
  String description;
  String imageUrl;
  double price;
  bool isFavorite;

  Product(
      {required this.description,
      required this.id,
      required this.title,
      required this.imageUrl,
      required this.price,
      this.isFavorite = false});
}
