import 'package:flutter/material.dart';
import 'package:mealmoneky/utility/size_config.dart';
import 'package:mealmoneky/widgets/texts.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight,
        // Background image for Splash Screen
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/images/01.png'),
            fit: BoxFit.cover,
          ),
        ),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo
            Image.asset('lib/assets/icons/logo.png',width: 120,height: 120),
            // white Space
            const SizedBox(height: 20,),
            // Logo Text
            const LogoText()
          ],
        ),
      ),
    );
  }
}
