import 'package:flutter/material.dart';
import '../fruit.dart';

class FruitDetailsScreen extends StatelessWidget {
  final Fruit fruit;
  final VoidCallback deleteFruit;
  final VoidCallback onTap;

  const FruitDetailsScreen({
    super.key,
    required this.fruit,
    required this.deleteFruit,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(fruit.name,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.normal,
                ))),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              './assets/${fruit.image}', // Chemin de l'image
              height: 200,
              width: 200,
            ),
          ),
          const SizedBox(height: 50),
          Center(
              child: Text(fruit.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ))),
          const SizedBox(height: 50),
          Center(
              child: Text("Origine : ${fruit.origin}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ))),
          const SizedBox(height: 50),
          Center(
              child: Text("Stock : ${fruit.stock}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ))),
          const SizedBox(height: 50),
          Center(
              child: Text(
                  "Tarif à l'unité : ${(fruit.price).toStringAsFixed(2).replaceAll('.', ',')} €",
                  style: const TextStyle(fontSize: 20))),
          const SizedBox(height: 50),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
            onPressed: () {
              final snackBar = SnackBar(
                duration: const Duration(milliseconds: 550),
                content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          (fruit.clickCount == 0)
                              ? "Erreur lors de la suppression ! Le fruit ${fruit.name} n'est pas dans votre panier !"
                              : "${fruit.name} supprimé(e) !",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.normal)),
                    ]),
                action: SnackBarAction(
                  label: "X",
                  textColor: Colors.white,
                  onPressed: () {},
                ),
                backgroundColor: Colors.red,
              );
              if (!(fruit.clickCount == 0)) {
                deleteFruit();
              }
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            child: const Icon(Icons.remove_shopping_cart,
                color: Colors.white, size: 30),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          onTap();
          final snackBar = SnackBar(
            duration: const Duration(milliseconds: 550),
            content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${fruit.name} ajouté(e) !',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.normal)),
                ]),
            backgroundColor: Colors.green,
            action: SnackBarAction(
              label: "X",
              textColor: Colors.white,
              onPressed: () {},
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        tooltip: 'Ajouter ce fruit dans le panier ?',
        child: const Icon(Icons.add),
      ),
    );
  }
}
