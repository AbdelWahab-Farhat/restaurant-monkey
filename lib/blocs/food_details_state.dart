part of 'food_details_bloc.dart';

@immutable
sealed class FoodDetailsState {}

final class FoodDetailsInitial extends FoodDetailsState {}

final class FoodCDetailsChangedState extends FoodDetailsState{
  UserCart cart;
  FoodCDetailsChangedState({required this.cart});
}


