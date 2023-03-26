import 'dart:math';
import 'package:flutter/material.dart';
import 'fruit.dart';
import 'fruitpreview.dart';
import 'screens/cartscreen.dart';
import 'package:dio/dio.dart';

class FruitsMaster extends StatefulWidget {

  const FruitsMaster(
      {super.key});

  @override
  FruitsMasterState createState() => FruitsMasterState();
}

class FruitsMasterState extends State<FruitsMaster> {
  final List<Fruit> _fruits = [];
  final List<Fruit> _cart = [];
  final PageController _pageController = PageController();
  double _sum = 0;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    // _fruits.addAll(widget.fruits);
    // _fruits = widget.fruits;
  }

  // "${fruit.name} supprimé(e) !";

  // "Erreur lors de la suppression ! Le fruit ${fruit.name} n'est pas dans votre panier !";

  void _onFruitTap(Fruit fruit) {
    setState(() {
      fruit.clickCount++;
      /*   if (fruit.clickCount == 2 && fruit.name[fruit.name.length - 1] != "s") {
        fruit.name = "${fruit.name}s";
      }*/

      if (_cart.contains(fruit)) {
      } else {
        _cart.add(fruit);
      }
      _sum += fruit.price;
    });
  }

  void _addRandomFruit() {
    setState(() {
      if (_fruits.isEmpty) {
        // Si tous les fruits ont été affichés, le bouton "+" ne fait plus rien.
        return;
      }
      final random = Random();
      final newFruitIndex = random.nextInt(_fruits.length);
      final newFruit = _fruits[newFruitIndex];
      // newFruit.color = Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(1.0);
      // _sum += newFruit.price;
      _fruits.insert(0, newFruit);
      _fruits.removeAt(
          newFruitIndex); // Retirer le fruit ajouté de la liste initiale
    });
  }

  void _resetPage() {
    setState(() {
      for (var i = 0; i < _fruits.length; i++) {
       _fruits.insert(0, _fruits[i]);
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
    setState(() {
      if (fruit.clickCount == 1) {
        _cart.remove(fruit);
      }

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

  Future<List<Fruit>> getFruits() async {

    final api = Dio(BaseOptions(
      baseUrl: 'https://fruits.shrp.dev/items/',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      headers: {},
    ));

    final List<Fruit> fruits = [];

    try {
      Response response = await api.get('fruits');
      //?fields=*.*
      //permet d'obtenir les données des modèles imbriqués Fruit + Country

      if (response.statusCode == 200 || response.statusCode == 304) {
        //on ajoute chaque objet Fruit à la liste fruits
        for (var element in response.data['data']) {


          Fruit aFruit = Fruit.fromJson(element);


          fruits.add(aFruit);
        }
      } else {
        throw Exception("Can't fetch data from API");
      }
    } catch (e) {
      print(e);
      throw Exception("Failed to load data");
    }
    return fruits;
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
        body: PageView(
          controller: _pageController,
          children: [
            FutureBuilder(future: getFruits(), builder: (context, snapshot) {
              if(snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    final fruit = snapshot.data![index];
                    return FruitPreview(
                      fruit: fruit,
                      onTap: () => _onFruitTap(fruit),
                      deleteFruit: () => _deleteFruit(fruit),
                    );
                  },
                );
              }else if(snapshot.hasError){
                print(snapshot.error);
                return const Text('error');
              }

              return const Text("Loading");
            }),
            ListView.builder(
              itemCount: _cart.length,
              itemBuilder: (context, index) {
                final fruit = _cart[index];
                return CartScreen(
                  fruits: _cart,
                  fruit: fruit,
                  deleteFruit: () => _deleteFruit(fruit),
                );
              },
            )
          ],
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
            });
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
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Fruits',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt),
              label: 'Panier',
            ),
          ],
          currentIndex: _currentPage,
          onTap: (index) {
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
            );
          },
        ));
  }
}
