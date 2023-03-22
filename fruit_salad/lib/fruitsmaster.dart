import 'dart:math';
import 'package:flutter/material.dart';
import 'fruit.dart';
import 'fruitpreview.dart';

class FruitsMaster extends StatefulWidget {
  final List<Fruit> fruits;

  const FruitsMaster({super.key, required this.fruits});

  @override
  _FruitsMasterState createState() => _FruitsMasterState();
}

class _FruitsMasterState extends State<FruitsMaster> {
  final List<Fruit> _fruits = [];
  final List<Fruit> _cart = [];
  double _sum = 0;
  String snack = "";
  String snackError = "";

  @override
  void initState() {
    super.initState();
    // _fruits.addAll(widget.fruits);
    // _fruits = widget.fruits;
  }

  void initSnack(Fruit fruit) {
   snack = "${fruit.name} supprimé(e) !";
   snackError = "Erreur lors de la suppression ! Le fruit ${fruit.name} n'est pas dans votre panier !";
  }

  void _onFruitTap(Fruit fruit) {
    initSnack(fruit);
    setState(() {
      fruit.clickCount++;
   /*   if (fruit.clickCount == 2 && fruit.name[fruit.name.length - 1] != "s") {
        fruit.name = "${fruit.name}s";
      }*/
      _cart.add(fruit);
      _sum += fruit.price;
    });
  }

  void _addRandomFruit() {
    setState(() {
      if (widget.fruits.isEmpty) {
        // Si tous les fruits ont été affichés, le bouton "+" ne fait plus rien.
        return;
      }
      final random = Random();
      final newFruitIndex = random.nextInt(widget.fruits.length);
      final newFruit = widget.fruits[newFruitIndex];
      // newFruit.color = Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(1.0);
      // _sum += newFruit.price;
      _fruits.insert(0, newFruit);
      widget.fruits.removeAt(
          newFruitIndex); // Retirer le fruit ajouté de la liste initiale
    });
  }

  void _resetPage() {
    setState(() {
      for (var i = 0; i < _fruits.length; i++) {
        widget.fruits.insert(0, _fruits[i]);
      }
/*      for (var i = 0; i < widget.fruits.length; i++) {
        widget.fruits[i].clickCount = 1;
        if (widget.fruits[i].name[widget.fruits[i].name.length - 1] == "s" &&
            widget.fruits[i].name != 'Cassis') {
          widget.fruits[i].name = widget.fruits[i].name
              .substring(0, widget.fruits[i].name.length - 1);
        }
      }*/
      _sum = 0;

      _fruits.clear();
    });
  }

  void _deleteFruit(Fruit fruit) {
    initSnack(fruit);
    setState(() {
      // final newFruitIndex = _fruits.indexOf(fruit);

      if (fruit.clickCount == 0) {
/*        widget.fruits.insert(0, _fruits[newFruitIndex]);
        _fruits.removeAt(newFruitIndex);*/

      } else {
        _sum = (_sum - fruit.price);
      }

      if (fruit.clickCount > 0) {
        fruit.clickCount = fruit.clickCount - 1;
      }

/*      if (fruit.name[fruit.name.length - 1] == "s" &&
          fruit.clickCount < 2 &&
          fruit.name != "Cassis") {
        fruit.name = fruit.name.substring(0, fruit.name.length - 1);
      }*/
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          "Montant : ${_sum.toStringAsFixed(2).replaceAll('.', ',')} €",
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.normal),
        )),
      ),
      body: ListView.builder(
        itemCount: _fruits.length,
        itemBuilder: (context, index) {
          final fruit = _fruits[index];
          return FruitPreview(
            fruit: fruit,
            snack: snack,
            snackError: snackError,
            onTap: () => _onFruitTap(fruit),
            deleteFruit: () => _deleteFruit(fruit),
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _addRandomFruit,
            tooltip: 'Ajouter un fruit !',
            heroTag: null,
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 16.0), // espace entre les deux boutons
          FloatingActionButton(
            onPressed: _resetPage,
            tooltip: 'Réinitialiser la page ?',
            heroTag: null,
            child: const Icon(Icons.restart_alt),
          ),
        ],
      ),
    );
  }
}
