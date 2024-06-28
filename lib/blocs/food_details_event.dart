part of 'food_details_bloc.dart';

@immutable
sealed class FoodDetailsEvent {}


class AddToCartEvent extends FoodDetailsEvent{
  Food food;
  AddToCartEvent({required this.food});
}
class RemoveFromCartEvent extends FoodDetailsEvent{
  Food food;
  RemoveFromCartEvent({required this.food});
}
class QuantityEvent extends FoodDetailsEvent {
  int quantity;
  int typeOp;
  QuantityEvent({required this.quantity, required this.typeOp});
}