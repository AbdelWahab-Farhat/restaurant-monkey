import 'dart:convert';

import 'package:mealmoneky/model/address.dart';
import 'package:mealmoneky/model/notification.dart';
import 'package:mealmoneky/model/user_cart.dart';
import 'package:uuid/uuid.dart';

class AccountUser {
  String id;
  String name;
  final String email;
  String phoneNumber;
  UserAddress address;
  UserCart userCart;
  // TODO WORK ON IT LATER!
  String? userImage;
  // TODO WORK ON IT LATER!
  AccountUser(
      {required this.name,
      required this.email,
      required this.phoneNumber,
      required this.address,required this.userCart,
        this.userImage,
        required this.id
      });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "userImage":userImage,
      "phoneNumber": phoneNumber,
      "address": address.toJson(),
      "cart":userCart.toJson(),
    };
  }

  factory AccountUser.fromJson(Map<String, dynamic> json, String id) {
    AccountUser user = AccountUser(
      name: json["name"],
      email: json["email"],
      userImage: json["userImage"],
      phoneNumber: json["phoneNumber"],
      address: UserAddress.fromJson(json["address"]),
      id: id,
      userCart: UserCart.fromJson(json['cart']),
    );
    return  user;
  }
//
}
