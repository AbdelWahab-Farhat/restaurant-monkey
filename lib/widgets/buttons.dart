import 'package:flutter/material.dart';
import 'package:mealmoneky/utility/constants.dart';

class CustomFilledButton extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  final double? buttonWidth;
  final double? buttonHeight;
  const CustomFilledButton(
      {super.key, this.onPressed, required this.title, this.buttonWidth, this.buttonHeight});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(5),
        width: buttonWidth ?? MediaQuery.sizeOf(context).width,
        height: buttonHeight ?? 55,
        decoration: BoxDecoration(
          color: compColor,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Center(
            child: Text(
          title,
          style:  TextStyle(
            color: Colors.white,
            fontSize: buttonHeight == null?16:12,
          ),
        )),
      ),
    );
  }
}

class CustomOutlinedButton extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  final double? buttonWidth;
  const CustomOutlinedButton(
      {super.key, this.onPressed, required this.title, this.buttonWidth});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(5),
        width: buttonWidth ?? MediaQuery.sizeOf(context).width,
        height: 55,
        decoration: BoxDecoration(
          border: Border.all(color: compColor, width: 1.1),
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Center(
            child: Text(
          title,
          style: const TextStyle(fontSize: 14, color: compColor),
        )),
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  final void Function()? onPressed;
  final Color color;
  final String iconImage;
  final String title;
  final double? buttonWidth;
  final double? buttonHeight;
  const CustomIconButton(
      {super.key,
      this.onPressed,
      required this.title,
      this.buttonWidth,
      required this.iconImage,
      required this.color,
      this.buttonHeight});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(10),
        width: buttonWidth ?? MediaQuery.sizeOf(context).width,
        height: buttonHeight ?? 55,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Center(
            child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconImage == 'lib/assets/icons/shopping-cart.png')
              Image.asset(
                iconImage,
                width: 20,
                height: 20,
                color: Colors.white,
              )
            else
              Image.asset(
                iconImage,
                width: 25,
                height: 25,
              ),
            const SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        )),
      ),
    );
  }
}
