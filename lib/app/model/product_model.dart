import 'package:flutter/material.dart';

class Product {
  Stream id;
  String name;
  String description;
  String photoUrl;
  int price;
  bool isFavorite;

  Product(
      {required this.description,
      required this.id,
      required this.name,
      required this.photoUrl,
      required this.price,
      this.isFavorite = false});
}
