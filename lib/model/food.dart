import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mealmoneky/model/enums.dart';
import 'package:mealmoneky/utility/helpers.dart';
import 'package:uuid/uuid.dart';

class Food {
  String id;
  String title;
  String des;
  String image;
  FoodCategory foodCategory;
  GeneralCategory generalCategory;
  DateTime date;
  double rate;
  int quantity;
  double price;
  bool? isSlides;
  bool? isOffer;
  bool? hasSize;
  bool? hasDiscount;

  Food({
    required this.image,
    required this.title,
    required this.des,
    required this.foodCategory,
    required this.rate,
    required this.price,
    required this.generalCategory,
    required this.date,
    this.isOffer,
    this.hasSize,
    this.isSlides,
    this.hasDiscount,
    required this.quantity
  }) : id = const Uuid().v4();

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      image:json['image'] ?? 'https://www.cobsbread.com/wp-content/uploads/2022/09/Pepperoni-pizza-850x630-1-585x400-1.jpg',
      title: json["title"],
      des: json["des"],
      foodCategory: toFoodCategory(json["foodCategory"]),
      generalCategory:toGeneralCategory(json['generalCategory']),
      rate: json["rate"],
      price: json["price"],
      isSlides: json["isSlides"],
      isOffer: json["isOffer"],
      hasSize: json["hasSize"],
      hasDiscount: json["hasDiscount"],
        quantity:json["quantity"],
      date: (json["date"] as Timestamp).toDate(),
    )..id = json["id"];
  }

  Map<String, dynamic> toJson() {
    return {
      "image":image,
      "id": id,
      "title": title,
      "des": des,
      "date":Timestamp.fromDate(date),
      "foodCategory": foodCategory.toString(),
      "generalCategory":generalCategory.toString(),
      "rate": rate,
      "quantity": quantity,
      "price": price,
      "isSlides": isSlides,
      "isOffer": isOffer,
      "hasSize": hasSize,
      "hasDiscount": hasDiscount,
    };
  }
}

