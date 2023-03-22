import 'package:flutter/material.dart';
import 'fruitsmaster.dart';
import 'fruit.dart';

void main() {
  runApp(MyApp());
}




class MyApp extends StatelessWidget {

  final List<Fruit> fruits = [
    Fruit('Ananas', Colors.yellow, 3.70, 0, '../lib/assets/ananas.png'),
    Fruit('Banane', Colors.yellow, 1.99, 0, '../lib/assets/banane.png'),
    Fruit('Cassis', Colors.purple, 6.99, 0, '../lib/assets/cassis.png'),
    Fruit('Citron', Colors.amberAccent, 2.08, 0, '../lib/assets/citron.png'),
    Fruit('Citron Vert', Colors.greenAccent, 3.38, 0, '../lib/assets/citron-vert.png'),
    Fruit('Fraise', Colors.red, 5.99, 0, '../lib/assets/fraise.png'),
    Fruit('Framboise', Colors.redAccent, 2.50, 0, '../lib/assets/framboise.png'),
    Fruit('Fruit de la Passion', Colors.purple.shade900, 14.00, 0, '../lib/assets/fruit-de-la-passion.png'),
    Fruit('Goyave', Colors.pinkAccent, 8.90, 0, '../lib/assets/goyave.png'),
    Fruit('Grenade', Colors.redAccent, 2.59, 0, '../lib/assets/grenade.png'),
    Fruit('Kaki', Colors.orange, 2.50, 0, '../lib/assets/kaki.png'),
    Fruit('Kiwi', Colors.green, 2.50, 0, '../lib/assets/kiwi.png'),
    Fruit('Litchi', Colors.pink.shade700, 12.90, 0, '../lib/assets/litchi.png'),
    Fruit('Mangue', Colors.amber, 6.50, 0, '../lib/assets/mangue.png'),
    Fruit('Melon', Colors.yellow.shade600, 4.99, 0, '../lib/assets/melon.png'),
    Fruit('Mure', Colors.purple.shade900, 6.40, 0, '../lib/assets/mure.png'),
    Fruit('Myrtille', Colors.purple.shade900, 1.70, 0, '../lib/assets/myrtille.png'),
    Fruit('Orange', Colors.orange, 1.35, 0, '../lib/assets/orange.png'),
    Fruit('Pastèque', Colors.greenAccent, 4.99, 0, '../lib/assets/pasteque.png'),
    Fruit('Pêche', Colors.orangeAccent, 2.99, 0, '../lib/assets/peche.png'),
    Fruit('Poire', Colors.green, 1.48, 0, '../lib/assets/poire.png'),
    Fruit('Pomelo', Colors.orange.shade400, 0.70, 0, '../lib/assets/pomelo.png'),
    Fruit('Pomme', Colors.red, 1.20, 0, '../lib/assets/pomme.png'),
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