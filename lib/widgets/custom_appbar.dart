import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mealmoneky/pages/cart_page.dart';
import 'package:mealmoneky/utility/constants.dart';


class CustomAppBar extends StatelessWidget {
  final String? title;
  final  bool? isHaveBackButton;

  const CustomAppBar({super.key,  this.title, this.isHaveBackButton});

  @override
  Widget build(BuildContext context) {
    return  Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (isHaveBackButton != null && isHaveBackButton == true)
          GestureDetector(
              onTap: () => Navigator.pop(context),
              child:  Icon(Icons.arrow_back_ios_new,size: 25,color:title == null?Colors.white:null,)),
        const SizedBox(width: 20,),
        Text(title ?? '',
          style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: title == null?Colors.white:mainColor),),
        const Spacer(),
        GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return CartPage();
              },));
            },
            child: Center(child: Image.asset('lib/assets/icons/shopping-cart-gray.png',width: 25,height: 25,color:title == null?Colors.white:null)))
      ],
    );
  }
}
