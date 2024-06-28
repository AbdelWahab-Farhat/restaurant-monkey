import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:mealmoneky/utility/constants.dart';

class CustomNavBar extends StatelessWidget {
  List<Widget> items;
  int activeIndex;
  dynamic Function(int) onTap;
   CustomNavBar({super.key, required this.activeIndex , required this.onTap , required this.items});

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
        items: items, index:activeIndex , onTap: onTap,
        backgroundColor: compColor,
        height: 60,
    );
  }
}
