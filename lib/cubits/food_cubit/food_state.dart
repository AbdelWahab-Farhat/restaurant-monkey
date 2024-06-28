part of 'food_cubit.dart';

@immutable
sealed class FoodState {}

final class FoodInitial extends FoodState {
}

final class FoodChangedState extends FoodState {
  List<Food> foods;
  FoodChangedState({required this.foods});
}