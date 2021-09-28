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
  // Created a local variable of Bloc class if you are using null safety then add late keyword
  ShoppingCartBloc _shoppingCartBloc;

  String name;
  double price;

  @override
  void initState() {
    // Here you create an object of the class and you can also pass variables in the constructor if you want
    _shoppingCartBloc = ShoppingCartBloc();
    // This step is not necessary it is just to say that after initialization this is the 1st event you need to perform
    _shoppingCartBloc.add(LoadShoppingCart());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // A bloc always need a provider here you can use cubit, provider, or bloc provider, I use bloc provider because it is easy to understand and implement
    return BlocProvider(
      // You need to pass your bloc object here as such this bloc object will become part of the provider
      create: (BuildContext context) => _shoppingCartBloc,
      // Now you can directly start here with scaffold but since you are using bloc and you need to change the UI state based on every state change as such you have to use bloc builder
      child: BlocBuilder<ShoppingCartBloc, ShoppingCartState>(
        // Since we are using builder function here as such whenever there is a state change the builder function will rerender
        builder: (BuildContext context, ShoppingCartState state) {
          print("State changed");

          // states are basically what you want to show on which condition here for example I am waiting for the data to load as such I have a loadings state you can use multiple if else state statements for different purposes
          if (state is ShoppingCartLoading) {
            // So when the state is ShoppingCartLoading I have designed it like that I only need to show a progress indicator in center
            return Scaffold(
              appBar: AppBar(),
              body: Center(child: CircularProgressIndicator()),
            );

          } 
          // Now when the state will change and this time the state is data loaded I am showing different informatiom
          else if (state is ShoppingCartLoaded) {
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
                      // This is how you can add an event to the bloc Adding an event is basically you are saying bloc to do something, so when you call the .add method and you add an event you can tell bloc that I need to perform something
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
