import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc/blocs/shopping_cart/shopping_cart_event.dart';
import 'package:learn_bloc/blocs/shopping_cart/shopping_cart_state.dart';

class ShoppingCartBloc extends Bloc<ShoppingCartEvent, ShoppingCartState> {
  ShoppingCartBloc() : super(ShoppingCartLoading());

  final Map<String, double> dummyData = {
    'pen': 10,
    'lunchbox': 20,
    'pencil_box': 30,
    'eraser': 40,
  };

  @override
  Stream<ShoppingCartState> mapEventToState(ShoppingCartEvent event) async* {
    if (event is LoadShoppingCart) {
      yield ShoppingCartLoading();

      await Future.delayed(Duration(seconds: 5));

      yield ShoppingCartLoaded();
    } else if (event is AddItemShoppingCart) {
     

      dummyData[event.name] = event.price;

      yield ShoppingCartLoaded();
    }
  }
}
