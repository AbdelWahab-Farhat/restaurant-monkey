import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:get/get.dart';
import 'package:mealmoneky/model/address.dart';
import 'package:mealmoneky/model/enums.dart';
import 'package:mealmoneky/model/food.dart';
import 'package:mealmoneky/utility/constants.dart';



TextStyle bigTitleStyle() {
  return const TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: mainColor
  );
}
TextStyle subTitleStyle() {
  return const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: subColor
  );
}
// code Email by adding stars in email name.
String codeEmail(String email) {
  // Find the index of '@' to ensure we do not mask the domain
  int atIndex = email.indexOf('@');
  if (atIndex == -1) {
    throw ArgumentError('Invalid email format');
  }

  // Ensure the email has enough characters to mask
  if (email.length <= 7) {
    throw ArgumentError('Email too short to mask properly');
  }
  // Mask characters between the 3rd character and the '@' symbol, leaving the last 4 characters of the local part
  return email.replaceRange(3, atIndex - 4 < 3 ? 3 : atIndex - 4, '*' * (atIndex - 3));
}

String formatAddress(UserAddress address, int type) {
  switch(type){
    case 1:return address.country;
    case 2:return '${address.country}-${address.cityName}';
    case 3:return '${address.country}-${address.cityName}-${address.streetAddress}';
    default: return '';
  }
}
// space Between 2 Words in category
String formatCategory(dynamic type) {
  if (type is GeneralCategory) {
    String typeFormatted = '';
    for (int i=0; i<type.name.length; i++) {
      if (type.name[i] == type.name[i].toUpperCase()) {
        typeFormatted+=" ";
        typeFormatted+=type.name[i];
      }
      else {
        typeFormatted+= type.name[i];
      }
    }
    return typeFormatted.capitalizeFirst.toString();
  }
  else if (type is FoodCategory) {
    String typeFormatted = '';
    for (int i=0; i<type.name.length; i++) {
      if (type.name[i] == type.name[i].toUpperCase()) {
        typeFormatted+=" ";
        typeFormatted+=type.name[i];
      }
      else {
        typeFormatted+= type.name[i];
      }
    }
    return typeFormatted.capitalizeFirst.toString();
  }
  else {
    return '';
  }

}



GeneralCategory toGeneralCategory(String generalCate) {
  String formatted = generalCate.split('.').last;
  if (GeneralCategory.italian.name == formatted) {
    return GeneralCategory.italian;
  }
  else if (GeneralCategory.offers.name == formatted) {
    return GeneralCategory.offers;
  }
  else if (GeneralCategory.sriLankan.name == formatted) {
    return GeneralCategory.sriLankan;
  }
  else if (GeneralCategory.indian.name == formatted) {
    return GeneralCategory.indian;
  }
  else {
    return GeneralCategory.sriLankan;
  }
}

FoodCategory toFoodCategory(String category) {
  switch (category) {
    case 'FoodCategory.fastFood':
      return FoodCategory.fastFood;
    case 'FoodCategory.beverages':
      return FoodCategory.beverages;
    case 'FoodCategory.desserts':
      return FoodCategory.desserts;
    case 'FoodCategory.appetizers':
      return FoodCategory.appetizers;
    case 'FoodCategory.mainCourse':
      return FoodCategory.mainCourse;
    default:
      throw Exception('Unknown FoodCategory: $category');
  }
}

