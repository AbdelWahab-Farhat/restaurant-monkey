import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:mealmoneky/pages/home_page.dart';
import 'package:mealmoneky/pages/menu/menu_page.dart';
import 'package:mealmoneky/pages/more_page.dart';
import 'package:mealmoneky/pages/offers_page.dart';
import 'package:mealmoneky/pages/profile_page.dart';
import 'package:meta/meta.dart';

part 'root_state.dart';

class RootCubit extends Cubit<RootState> {
  int currentIndex = 2;
  List<Widget> pages = [
    MenuPage(),
    OffersPage(),
    HomePage(),
    ProfilePage(),
    MorePage(),
  ];
  RootCubit() : super(RootInitial());
  List<Widget> getNavIcons() {
    List<String> icons = [
      'lib/assets/icons/menu-gray.png',
      'lib/assets/icons/shopping-bag-gray.png',
      'lib/assets/icons/home-gray.png',
      'lib/assets/icons/user-gray.png',
      'lib/assets/icons/more-gray.png',
    ];

    return List<Widget>.generate(icons.length, (index) {
      return Image.asset(
        icons[index],
        width: 20,
        height: 20,
      );
    });
  }
}
