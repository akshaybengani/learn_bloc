import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc/blocs/shopping_cart/shopping_cart_bloc.dart';
import 'package:learn_bloc/blocs/shopping_cart/shopping_cart_event.dart';
import 'package:learn_bloc/blocs/shopping_cart/shopping_cart_state.dart';

class ShoppingCartScreen extends StatefulWidget {
  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  ShoppingCartBloc _shoppingCartBloc;

  String name;
  double price;

  @override
  void initState() {
    _shoppingCartBloc = ShoppingCartBloc();
    _shoppingCartBloc.add(LoadShoppingCart());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _shoppingCartBloc,
      child: BlocBuilder<ShoppingCartBloc, ShoppingCartState>(
        builder: (BuildContext context, ShoppingCartState state) {
          print("State changed");

          if (state is ShoppingCartLoading) {
            return Scaffold(
              appBar: AppBar(),
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (state is ShoppingCartLoaded) {
            return Scaffold(
              appBar: AppBar(
                title: Text("App bar"),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Here are my cart items"),
                  TextField(
                    decoration: InputDecoration(hintText: "Enter name"),
                    onChanged: (final String data) {
                      name = data;
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: "Enter price"),
                    onChanged: (final String data) {
                      price = double.tryParse(data);
                    },
                  ),
                  RaisedButton(
                    onPressed: () {
                      _shoppingCartBloc.add(AddItemShoppingCart(name, price));
                    },
                    child: Text("Add item"),
                  ),
                  ..._cartItems(),
                ],
              ),
            );
          } else {
            return Scaffold(appBar: AppBar());
          }
        },
      ),
    );
  }

  List<Widget> _cartItems() {
    List<Widget> widgets = [];

    _shoppingCartBloc.dummyData.forEach((String key, double value) {
      widgets.add(Card(
          child: Row(children: [
        Text("Name: $key"),
        Text("Amount is $value"),
      ])));
    });

    return widgets;
  }
}
