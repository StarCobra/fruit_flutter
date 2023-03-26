import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {


  const CartScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
              child: Text(
            "Montant : €",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.normal),
          )),
        ),
        body: ListView.builder(itemBuilder: (context, index) {
          return ListTile(
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
                        "pomme.png", // chemin de l'image à afficher
                        height: 48,
                        width: 48, // largeur de l'image
                      ),
                    ]),
                    const SizedBox(width: 10),
                    const Text(
                      "Nom du fruit",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ]),
                ),
                Row(
                  children: [
                    const Text(
                      "Prix €",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 10),
                    // espace entre le texte et le bouton
                    TextButton(
                      onPressed: () {
                        final snackBar = SnackBar(
                          duration: const Duration(milliseconds: 550),
                          content: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text('supprimé(e) !',
                                    style: TextStyle(
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
                      child: const Icon(Icons.delete,
                          size: 20, color: Colors.black38),
                    )
                  ],
                ),
              ],
            ),
          );
        }));
  }
}
