import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final double? textFieldWidth;
  final bool? isPassword;
  final bool? isPhoneNumber;

  const CustomTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.textFieldWidth,
      this.isPassword,
      this.isPhoneNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: textFieldWidth ?? MediaQuery.sizeOf(context).width,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: const Color(0xffF2F2F2),
      ),
      child: TextField(
        obscureText: isPassword ?? false,
        keyboardType: isPhoneNumber == null ? null : TextInputType.number,
        inputFormatters: isPhoneNumber == null
            ? null
            : [FilteringTextInputFormatter.digitsOnly],
        controller: controller,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: const TextStyle(
              color: Color(0xffB6B7B7),
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
