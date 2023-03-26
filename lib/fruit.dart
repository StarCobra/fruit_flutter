import 'package:flutter/material.dart';

class Fruit {
  final int id;
  final String name;
  final double price;
  final String image;
  final Color color;
  final int stock;
  final String origin;
  final String season;
  int clickCount;

  Fruit(this.id, this.name, this.price, this.image, this.color, this.stock, this.origin, this.season, this.clickCount);

  factory Fruit.fromJson(Map<String, dynamic> json) {
    num stock = json['stock'];
    num price = json['price'];

    return Fruit(json['id'], json['name'], price.toDouble(), json['image'], Color(int.parse(json['color'].substring(1, 7), radix: 16) + 0xFF000000), stock.toInt(), json['origin']['name'], json['season'], 0);
  }

}