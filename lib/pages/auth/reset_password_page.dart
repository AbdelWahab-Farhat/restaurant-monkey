import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mealmoneky/utility/constants.dart';
import 'package:mealmoneky/utility/helpers.dart';
import 'package:mealmoneky/widgets/buttons.dart';
import 'package:mealmoneky/widgets/custom_textfield.dart';
import 'package:pinput/pinput.dart';

class ResetPasswordPage extends StatelessWidget {
  ResetPasswordPage({super.key});
  // TODO: WORK ON  RESET PASSWORD LATER.
  final controllerEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(
            top: kToolbarHeight / 1.2,
            right: 20,
            left: 20,
            bottom: kToolbarHeight / 1.2),
        child: Center(
          child: Column(
            children: [
              Text(
                'Reset Password',
                style: bigTitleStyle(),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Please enter your email to receive a link to  create a new password via email',
                textAlign: TextAlign.center,
                style: subTitleStyle(),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                  controller: controllerEmail, hintText: 'Your Email'),
              const SizedBox(
                height: 20,
              ),
              const CustomFilledButton(
                title: 'Send',
                onPressed: null,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OtpMassagePage extends StatelessWidget {
  OtpMassagePage({super.key});
  Widget buildPinPut(TextEditingController controller) {
    return Pinput(
      controller: controller,
      onCompleted: (value) {
        completedText = value;
      },
    );
  }

  String completedText = '';
  final controllerOtpText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(
            top: kToolbarHeight / 1.2,
            right: 20,
            left: 20,
            bottom: kToolbarHeight / 1.2),
        child: Center(
          child: Column(
            children: [
              Text(
                'We have sent OTP Number Check your Email',
                textAlign: TextAlign.center,
                style: bigTitleStyle(),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Please check your Email ${codeEmail('lolkillurself134@gmail.com')} continue to reset your password',
                textAlign: TextAlign.center,
                style: subTitleStyle(),
              ),
              const SizedBox(
                height: 20,
              ),
              buildPinPut(controllerOtpText),
              const SizedBox(
                height: 40,
              ),
              const CustomFilledButton(title: 'Next'),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't Receive?",
                    style: subTitleStyle(),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                      // TODO:SEND TEXT AGAIN
                      onTap: null,
                      child: const Text(
                        "Click Here",
                        style: TextStyle(
                            color: compColor, fontWeight: FontWeight.bold),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NewPasswordPage extends StatelessWidget {
  NewPasswordPage({super.key});
  final controllerNewPassword = TextEditingController();
  final controllerConfirmPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(
            top: kToolbarHeight / 1.2,
            right: 20,
            left: 20,
            bottom: kToolbarHeight / 1.2),
        child: Center(
          child: Column(
            children: [
              Text(
                'New Password',
                style: bigTitleStyle(),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Please enter your newPassword to Login with Your Email',
                textAlign: TextAlign.center,
                style: subTitleStyle(),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: controllerNewPassword,
                hintText: 'New Password',
                isPassword: true,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: controllerConfirmPassword,
                hintText: 'Confirm Password',
                isPassword: true,
              ),
              const SizedBox(
                height: 20,
              ),
              const CustomFilledButton(
                title: 'Next',
                onPressed: null,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
