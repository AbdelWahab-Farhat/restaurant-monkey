import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mealmoneky/model/food.dart';
import 'package:meta/meta.dart';

part 'food_state.dart';

class FoodCubit extends Cubit<FoodState> {
  List<Food> foods = [];
  FoodCubit() : super(FoodInitial());

  Future<void> getFood() async {
    final firebaseFirestore = FirebaseFirestore.instance;
     foods = [];

    try {
      final data = await firebaseFirestore.collection('foods').get();
      for (var item in data.docs) {
        foods.add(Food.fromJson(item.data()));
      }
      emit(FoodChangedState(foods: foods)); // Ensure this fits your state management
    } on FirebaseException catch (e) {
      print('Error fetching food data: $e'); // Error handling
      // Optionally emit an error state here
    }
  }
}

