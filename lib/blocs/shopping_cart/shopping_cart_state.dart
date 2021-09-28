// Take this like a boilerplate code you just need an abstract class so that every other state class have one common identity, so ShoppingCartState represents for every other class of state which is using ShoppingCartState as a parent in inheritence.
abstract class ShoppingCartState{}

class ShoppingCartLoading extends ShoppingCartState {}

class ShoppingCartLoaded extends ShoppingCartState {}
