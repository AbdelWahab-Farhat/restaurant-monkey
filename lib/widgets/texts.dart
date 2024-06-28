import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mealmoneky/utility/constants.dart';

class LogoText extends StatelessWidget {
  const LogoText({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Title Text
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        Text('Meal',style: TextStyle(color: compColor,fontSize: 34,fontWeight: FontWeight.bold,fontFamily: GoogleFonts.adamina().fontFamily),),
           const SizedBox(width: 10,),
           Text('Monkey',style: TextStyle(color: mainColor,fontSize: 34,fontWeight: FontWeight.bold,fontFamily: GoogleFonts.adamina().fontFamily),),
        ],
        ),
        const SizedBox(height: 10,),
        // Sub title
        const Text('Food Delivery',style: TextStyle(fontSize: 14,color: mainColor,letterSpacing: 3),)
      ],
    );
  }
}

