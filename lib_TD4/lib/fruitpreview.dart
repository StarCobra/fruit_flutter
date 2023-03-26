import 'package:flutter/material.dart';
import 'package:fruit_salad/screens/fruitdetailsscreen.dart';
import 'fruit.dart';

class FruitPreview extends StatelessWidget {
  final Fruit fruit;
  final VoidCallback onTap;
  final VoidCallback deleteFruit;

  const FruitPreview({
    super.key,
    required this.fruit,
    required this.onTap,
    required this.deleteFruit,
  });

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          FruitDetailsScreen(
        fruit: fruit,
        deleteFruit: deleteFruit,
        onTap: onTap,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: fruit.color, // couleur de fond du fruit
        child: ListTile(
          onTap: () {
            Navigator.push(
              context,
              _createRoute(),
            );
          },
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
                    fruit.name,
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
                  /* Text(
                    "${((fruit.price * fruit.clickCount).toStringAsFixed(2)).replaceAll('.', ',')} €",
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),*/
                  TextButton(
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
                            onPressed: () {
                              // Some code to undo the change.
                            },
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.all(
                              20.0), // Remplacez 10.0 par la valeur de votre choix
                        ),
                        shape: MaterialStateProperty.all<CircleBorder>(
                            const CircleBorder()),
                      ),
                      child: const Icon(
                        Icons.add_shopping_cart,
                        color: Colors.black38,
                        // Ajouter cette ligne pour définir la couleur
                        size:
                            30, // Ajouter cette ligne pour définir la taille),
                      )),
                  const SizedBox(width: 10),
                  // espace entre le texte et le bouton
                  /*        TextButton(
                    onPressed: deleteFruit,
                    child: const Icon(Icons.delete),
                  ),*/
                ],
              ),
            ],
          ),
        ));
  }
}
