import 'dart:convert';

import 'package:mealmoneky/model/food.dart';

class UserCart {
   String userId;
   List<Food>? userCartFoods;

   UserCart({required this.userId, required this.userCartFoods});

   Map<String, dynamic> toJson() {
      return {
         "userId": userId,
         "userCartFoods": userCartFoods!.map((food) => food.toJson()).toList(),
         "totalPrice": countTotalPrice(userCartFoods!),
      };
   }

   factory UserCart.fromJson(Map<String, dynamic> json) {
      return UserCart(
         userId: json["userId"],
         userCartFoods: (json["userCartFoods"] as List<dynamic>).map((item) => Food.fromJson(item)).toList().isEmpty ? [] : (json["userCartFoods"] as List<dynamic>).map((item) => Food.fromJson(item)).toList(),
      );

   }


   // Count totalPrice for User Cart
   double countTotalPrice(List<Food> foods) {
      double totalPrice = 0.0;
      for (var food in foods) {
         totalPrice += food.quantity * food.price;
      }
      return totalPrice;
   }
}
