import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mealmoneky/utility/constants.dart';
import 'package:mealmoneky/widgets/buttons.dart';
import 'package:mealmoneky/widgets/texts.dart';

class StartUpPage extends StatelessWidget {
  const StartUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height / 1.7,
              child: Stack(
                children: [
                  // top background.
                  Image.asset(
                    'lib/assets/images/Shaped subtraction.png',
                    fit: BoxFit.fitWidth,
                  ),
                  Image.asset('lib/assets/images/Background objects.png'),
                  // logo
                  Positioned(
                    bottom: 0,
                    right: MediaQuery.sizeOf(context).width / 3.4,
                    child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                            color: Colors.transparent, shape: BoxShape.circle),
                        child: Image.asset('lib/assets/icons/logo.png',
                            width: 120, height: 120)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Logo Text
                  const LogoText(),
                  // white space between subTitle and logo
                  const SizedBox(
                    height: 10,
                  ),
                  // sub title
                  const Text(
                    'Discover the best foods from over 1,000 restaurants and fast delivery to your doorstep',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13, color: subColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  // Login Button
                  CustomFilledButton(
                    title: 'Login',
                    onPressed: () => Navigator.pushNamed(context, 'login'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  // Sign Up Button
                  CustomOutlinedButton(
                    title: 'Create an Account',
                    onPressed: () => Navigator.pushNamed(context, 'signup'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
