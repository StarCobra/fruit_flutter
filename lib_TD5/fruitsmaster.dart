import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'fruit.dart';
import 'fruitpreview.dart';
import 'screens/cartscreen.dart';

class FruitsMaster extends StatefulWidget {
  const FruitsMaster({super.key});

  @override
  FruitsMasterState createState() => FruitsMasterState();
}

class FruitsMasterState extends State<FruitsMaster> {
  final List<Fruit> _cart = [];
  double _sum = 0;

  Route _cartRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const CartScreen(),
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
  void initState() {
    super.initState();
  }

  void _onFruitTap(Fruit fruit) async {
    setState(() {
      fruit.clickCount++;

      if (!_cart.contains(fruit)) {
        _cart.add(fruit);
      }
      _sum += fruit.price;
    });
  }

  void _deleteFruit(Fruit fruit) async {
    setState(() {
      if (fruit.clickCount == 1) {
        _cart.remove(fruit);
      }
      if (!(fruit.clickCount == 0)) {
        _sum = (_sum - fruit.price);
      }
      if (fruit.clickCount > 0) {
        fruit.clickCount = fruit.clickCount - 1;
      }
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
      Response response = await api.get('fruits?fields=*.*');
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(""),
            Center(
                child: Text(
              "Montant : ${_sum.toStringAsFixed(2).replaceAll('.', ',')} €",
              style:
                  const TextStyle(fontSize: 32, fontWeight: FontWeight.normal),
            )),
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              iconSize: 30,
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  _cartRoute(),
                );
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder(
          future: getFruits(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
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
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return const Text('error');
            }

            return const Text("Loading");
          }),
    );
  }
}
