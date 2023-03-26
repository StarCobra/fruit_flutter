import 'package:flutter/material.dart';
import '../fruit.dart';

class CartScreen extends StatelessWidget {
  final Fruit fruit;
  final List<Fruit> fruits;
  final VoidCallback deleteFruit;

  const CartScreen(
      {super.key,
      required this.fruit,
      required this.fruits,
      required this.deleteFruit});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: fruit.color, // couleur de fond du fruit
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(children: [
                  Stack(children: [
                    Container(
                      height: 50, // hauteur du cercle
                      width: 50, // largeur du cercle
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue, // couleur du cercle
                      ),
                    ),
                    Image.asset(
                      fruit.image, // chemin de l'image à afficher
                      height: 48,
                      width: 48, // largeur de l'image
                    ),
                  ]),
                  const SizedBox(width: 10),
                  Text(
                    "${fruit.name} (${fruit.clickCount})",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ]),
              ),
              Row(
                children: [
                  Text(
                    "${((fruit.price * fruit.clickCount).toStringAsFixed(2)).replaceAll('.', ',')} €",
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 10),
                  // espace entre le texte et le bouton
                  TextButton(
                    onPressed: () {
                      deleteFruit();
                      final snackBar = SnackBar(
                        duration: const Duration(milliseconds: 550),
                        content: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${fruit.name} supprimé(e) !',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal)),
                            ]),
                        backgroundColor: Colors.red,
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
                    child: const Icon(Icons.delete, size: 20, color: Colors.black38),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
