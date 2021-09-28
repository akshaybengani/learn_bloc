// Similar to state file there are events and a common event which represents to all other events
abstract class ShoppingCartEvent {}

// This is just a name you can name it anything keep it meaningful so you can understand better
class LoadShoppingCart extends ShoppingCartEvent {}


// For example I need to add an item in the cart and this event is taking that information from the UI and passing it to bloc
class AddItemShoppingCart extends ShoppingCartEvent {
  final String name;
  final double price;

  AddItemShoppingCart(
    this.name,
    this.price,
  );
}
