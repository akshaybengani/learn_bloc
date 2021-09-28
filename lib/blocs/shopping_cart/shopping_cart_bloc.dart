import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc/blocs/shopping_cart/shopping_cart_event.dart';
import 'package:learn_bloc/blocs/shopping_cart/shopping_cart_state.dart';

// So take it like a boilerplate code you need to extend Bloc class here which takes two generic types, one is your event and one is your state, 
// now you will understand why we created abstract class in event and state file, they represent commonly as event and state to the bloc
class ShoppingCartBloc extends Bloc<ShoppingCartEvent, ShoppingCartState> {

  // This is just the constructor and this ShoppingCartLoading is a state name, so basically this is the default state when your screen will load this is the default view user will see, until there is any other state change.
  ShoppingCartBloc() : super(ShoppingCartLoading());


  final Map<String, double> dummyData = {
    'pen': 10,
    'lunchbox': 20,
    'pencil_box': 30,
    'eraser': 40,
  };


  // This is also boilerplate code, dont get confuse with Stream and wiered function it is just a boilerplate code
  // As you noticed why there is async* not async and not use return insteed of yield
  // basically the diff in yiled and return is, after return statement everything below it will be dead code, but in yield you are returning something as well as moving on to the next line
  // so yiled here we used it to rerender the screen we pass state here and if you want to pass something with the state you can pass in the state constructor
  @override
  Stream<ShoppingCartState> mapEventToState(ShoppingCartEvent event) async* {
    if (event is LoadShoppingCart) {
      // So this will call the builder function of your screen again and this time the state is ShoppingCartLoading so whatever you want to show you can use if else in the ui
      yield ShoppingCartLoading();

      await Future.delayed(Duration(seconds: 5));

      // This is again a state change and ui will rerender basically it will perform setstate in the builder function that's why we call blpc a state management solution, internally you are only performing set state but now with a bloc 
      yield ShoppingCartLoaded();
    } 
    // As I said when you need to pass infromation to the bloc you use events
    else if (event is AddItemShoppingCart) {
     

      dummyData[event.name] = event.price;

      // when you need to pass information to the screen you use state 
      yield ShoppingCartLoaded();
    }
  }
}
