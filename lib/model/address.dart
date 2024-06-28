class UserAddress {
  String country;
  String cityName;
  String streetAddress;

  UserAddress(
      {required this.country,
      required this.cityName,
      required this.streetAddress});

  Map<String, dynamic> toJson() {
    return {
      "country": country,
      "cityName": cityName,
      "streetAddress": streetAddress,
    };
  }

  factory UserAddress.fromJson(Map<String, dynamic> json) {
    return UserAddress(
      country: json["country"],
      cityName: json["cityName"],
      streetAddress: json["streetAddress"],
    );
  }
//
}
