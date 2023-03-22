import 'package:flutter/material.dart';
import 'fruitsmaster.dart';
import 'fruit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final List<Fruit> fruits = [
    Fruit('Ananas', Colors.yellow, 3.70, 0, 'ananas.png'),
    Fruit('Banane', Colors.yellow, 1.99, 0, 'banane.png'),
    Fruit('Cassis', Colors.purple, 6.99, 0, 'cassis.png'),
    Fruit('Citron', Colors.amberAccent, 2.08, 0, 'citron.png'),
    Fruit('Citron Vert', Colors.greenAccent, 3.38, 0, 'citron-vert.png'),
    Fruit('Fraise', Colors.red, 5.99, 0, 'fraise.png'),
    Fruit('Framboise', Colors.redAccent, 2.50, 0, 'framboise.png'),
    Fruit('Fruit de la Passion', Colors.purple.shade900, 14.00, 0, 'fruit-de-la-passion.png'),
    Fruit('Goyave', Colors.pinkAccent, 8.90, 0, 'goyave.png'),
    Fruit('Grenade', Colors.redAccent, 2.59, 0, 'grenade.png'),
    Fruit('Kaki', Colors.orange, 2.50, 0, 'kaki.png'),
    Fruit('Kiwi', Colors.green, 2.50, 0, 'kiwi.png'),
    Fruit('Litchi', Colors.pink.shade700, 12.90, 0, 'litchi.png'),
    Fruit('Mangue', Colors.amber, 6.50, 0, 'mangue.png'),
    Fruit('Melon', Colors.yellow.shade600, 4.99, 0, 'melon.png'),
    Fruit('Mure', Colors.purple.shade900, 6.40, 0, 'mure.png'),
    Fruit('Myrtille', Colors.purple.shade900, 1.70, 0, 'myrtille.png'),
    Fruit('Orange', Colors.orange, 1.35, 0, 'orange.png'),
    Fruit('Pastèque', Colors.greenAccent, 4.99, 0, 'pasteque.png'),
    Fruit('Pêche', Colors.orangeAccent, 2.99, 0, 'peche.png'),
    Fruit('Poire', Colors.green, 1.48, 0, 'poire.png'),
    Fruit('Pomelo', Colors.orange.shade400, 0.70, 0, 'pomelo.png'),
    Fruit('Pomme', Colors.red, 1.20, 0, 'pomme.png'),
  ];

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fruit Salad',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FruitsMaster(
        fruits: fruits,
      )
    );
  }
}