import 'package:flutter/material.dart';
import '../fruit.dart';

class FruitDetailsScreen extends StatelessWidget {
  final Fruit fruit;
  final String snack;
  final String snackError;
  final VoidCallback deleteFruit;
  final VoidCallback onTap;

  const FruitDetailsScreen(
      {super.key,
      required this.fruit,
      required this.snack,
      required this.snackError,
      required this.deleteFruit,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(fruit.name,
                style: const TextStyle(
                  fontSize: 32, // Taille du texte en pixels
                  fontWeight:
                      FontWeight.normal, // Épaisseur du texte (bold = gras)
                ))),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/${fruit.pic}', // chemin de l'image à afficher
              height: 200,
              width: 200,
            ),
          ),
          const SizedBox(height: 50),
          Center(
              child: Text(fruit.name,
                  style: const TextStyle(
                    fontSize: 20, // Taille du texte en pixels
                    fontWeight:
                        FontWeight.bold, // Épaisseur du texte (bold = gras)
                  ))),
          const SizedBox(height: 50),
          Center(
              child: Text(
                  "${(fruit.price).toStringAsFixed(2).replaceAll('.', ',')} €",
                  style: const TextStyle(fontSize: 20))),
          const SizedBox(height: 50),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.red,
              // couleur du texte
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              textStyle: const TextStyle(
                fontSize: 16, // taille de police du texte
                fontWeight: FontWeight.normal, // épaisseur du texte
              ),
            ),
            onPressed: () {

              final snackBar = SnackBar(
                content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text((fruit.clickCount == 0) ? snackError : snack,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.normal)),
                    ]),
                action: SnackBarAction(
                  label: "X",
                  textColor: Colors.white,
                  onPressed: () {
                    // Some code to undo the change.
                  },
                ),
                backgroundColor: Colors.red,
              );
              if(fruit.clickCount == 0) {

              } else {
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
            duration: const Duration(milliseconds: 100),
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
              onPressed: () {
                // Some code to undo the change.
              },
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
