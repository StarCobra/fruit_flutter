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
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                      ),
                      Image.asset(
                        "./assets/pomme.png", // Chemin de l'image
                        height: 48,
                        width: 48,
                      ),
                    ]),
                    const SizedBox(width: 10),
                    const Text(
                      "POMME", // Nom des fruits dans le panier
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
                      "POMME €",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 10),
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
                            onPressed: () {},
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
