abstract class ShoppingCartEvent {}

class LoadShoppingCart extends ShoppingCartEvent {}

class AddItemShoppingCart extends ShoppingCartEvent {
  final String name;
  final double price;

  AddItemShoppingCart(
    this.name,
    this.price,
  );
}
