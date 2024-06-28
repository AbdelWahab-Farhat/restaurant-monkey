import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mealmoneky/model/food.dart';
import 'package:mealmoneky/model/user_cart.dart';
import 'package:meta/meta.dart';

part 'food_details_event.dart';
part 'food_details_state.dart';

class FoodDetailsBloc extends Bloc<FoodDetailsEvent, FoodDetailsState> {
  late UserCart cart;

  FoodDetailsBloc() : super(FoodDetailsInitial()) {
    on<RemoveFromCartEvent>((event, emit) async {
      // Iterate over the items in the cart
      cart.userCartFoods!.removeWhere((item) => item.id == event.food.id);

      // Update Firestore document after modifying the cart
      final FirebaseFirestore store = FirebaseFirestore.instance;
      final userDocRef = store.collection('users').doc(FirebaseAuth.instance.currentUser!.uid);

      // Update the user's cart in Firestore
      await userDocRef.update({
        'cart': cart.toJson(),
      });

      // Emit the state change
      emit(FoodCDetailsChangedState(cart: cart));
    });

    on<AddToCartEvent>((event, emit) async {
      bool found = false;

      for (var item in cart.userCartFoods!) {
        if (item.id == event.food.id) {
          item.quantity += event.food.quantity;
          found = true;
          break;
        }
      }

      if (!found) {
        cart.userCartFoods!.add(event.food);
      }

      // Update Firestore
      final FirebaseFirestore store = FirebaseFirestore.instance;
      final userDocRef = store.collection('users').doc(FirebaseAuth.instance.currentUser!.uid);
      await userDocRef.update({
        'cart': cart.toJson(),
      });

      emit(FoodCDetailsChangedState(cart: cart));
    });


  }


    Future<void> initFoodCart() async {
      final FirebaseFirestore store = FirebaseFirestore.instance;
      final snapShot = await store.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
      cart = UserCart.fromJson(snapShot.data()!['cart']);
      emit(FoodCDetailsChangedState(cart: cart));
    }

}
