


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mealmoneky/model/enums.dart';
import 'package:mealmoneky/model/food.dart';
import 'package:pinput/pinput.dart';

List<Food> mostPopularFood(List<Food>  foods) {
  List<Food> mostPopular = [];
  for (var item in foods) {
    if (item.rate > 2.9) {
      mostPopular.add(item);
    }
  }
  return mostPopular;
}

List<Food> resentItems(List<Food> foods) {
  List<Food> items = List.from(foods); // Create a copy of the list to avoid modifying the original
  for (int i = 0; i < items.length - 1; i++) {
    for (int j = 0; j < items.length - i - 1; j++) {
      if (items[j].date.isBefore(items[j + 1].date)) {
        Food temp = items[j];
        items[j] = items[j + 1];
        items[j + 1] = temp;
      }
    }
  }
  return items;
}


List<Food> offerFoods(List<Food> foods) {
  List<Food> offers = [];
  for (var item in foods) {
    if (item.generalCategory == GeneralCategory.offers) {
      offers.add(item);
    }
  }
  return offers;
}
List<Food> filterFoodCategory(List<Food> foods, FoodCategory type) {
  switch(type) {
    case FoodCategory.fastFood:
      return foods.where((item) => item.foodCategory == type).toList();
    case FoodCategory.beverages:
      return foods.where((item) => item.foodCategory == type).toList();
    case FoodCategory.mainCourse:
      return foods.where((item) => item.foodCategory == type).toList();
    case FoodCategory.desserts:
      return foods.where((item) => item.foodCategory == type).toList();
    case FoodCategory.appetizers:
      return foods.where((item) => item.foodCategory == type).toList();
    default:
      return [];
  }
}
List<Food> filterGeneralCate(List<Food> foods, GeneralCategory type) {
  switch(type) {
    case GeneralCategory.offers:
      return foods.where((item) => item.generalCategory == type).toList();
    case GeneralCategory.italian:
      return foods.where((item) => item.generalCategory == type).toList();
    case GeneralCategory.sriLankan:
      return foods.where((item) => item.generalCategory == type).toList();
    case GeneralCategory.indian:
      return foods.where((item) => item.generalCategory == type).toList();
    default:
      return [];
  }
}
