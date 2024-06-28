import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealmoneky/cubits/login_cubit/login_cubit.dart';
import 'package:mealmoneky/utility/constants.dart';
import 'package:mealmoneky/utility/helpers.dart';
import 'package:mealmoneky/widgets/buttons.dart';
import 'package:mealmoneky/widgets/custom_textfield.dart';

class LoginPage extends StatelessWidget {
  final _controllerEmail = TextEditingController();
  final _controllerPassword = TextEditingController();
  LoginPage({super.key});

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
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Main Login Text.
                Text(
                  'Login',
                  style: bigTitleStyle(),
                ),
                const SizedBox(
                  height: 10,
                ),

                Text(
                  'Add your details to login',
                  style: subTitleStyle(),
                ),
                const SizedBox(
                  height: 20,
                ),
                // Email TextField
                CustomTextField(
                    controller: _controllerEmail, hintText: 'Email'),

                const SizedBox(
                  height: 20,
                ),

                // Password TextField
                CustomTextField(
                  controller: _controllerPassword,
                  hintText: 'Password',
                  isPassword: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                // Listen to Change in Auth State
                BlocConsumer<LoginCubit, LoginState>(
                  listener: (context, state) {
                    if (state is LoginSuccessful) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(state.message)));
                      Navigator.pushNamedAndRemoveUntil(
                          context, 'root', (route) => false);
                    } else if (state is LoginBadInfo) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(state.message)));
                    } else if (state is LoginError) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(state.message)));
                    }
                  },
                  // Build Widget depends On State
                  builder: (context, state) {
                    if (state is LoginInitial ||
                        state is LoginBadInfo ||
                        state is LoginError) {
                      return _loginButton(context);
                    } else if (state is LoginLoading) {
                      return const CircularProgressIndicator(
                        color: compColor,
                      );
                    }
                    return const SizedBox();
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                // Forget Password Button
                Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, 'reset_password'),
                        child: Text(
                          'Forgot your password?',
                          style: subTitleStyle(),
                        ))),
                const SizedBox(
                  height: 40,
                ),
                _customDivider(),
                const SizedBox(
                  height: 30,
                ),
                // Login With Facebook
                // TODO: NOT COMPLETED
                const CustomIconButton(
                  title: 'Login With Facebook',
                  iconImage: 'lib/assets/icons/Facebook.png',
                  color: Color(0xff367FC0),
                ),
                const SizedBox(
                  height: 20,
                ),
                // Login With GOOGLE
                // TODO: NOT COMPLETED
                CustomIconButton(
                  title: 'Login With Google',
                  iconImage: 'lib/assets/icons/google-plus-logo.png',
                  color: Color(0xffDD4B39),
                  onPressed: () {
                    context.read<LoginCubit>().googleLogin();
                  },
                ),

                SizedBox(height: MediaQuery.sizeOf(context).height / 10),

                // Go to Sign Up Page.
                _toggleSignUpButton(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _toggleSignUpButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an Account?",
          style: subTitleStyle(),
        ),
        const SizedBox(
          width: 5,
        ),
        GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'signup'),
            child: const Text(
              "Sign Up",
              style: TextStyle(color: compColor, fontWeight: FontWeight.bold),
            ))
      ],
    );
  }

  Widget _customDivider() {
    return Row(
      children: [
        const Expanded(child: Divider()),
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Or',
              style: subTitleStyle(),
            )),
        const Expanded(child: Divider()),
      ],
    );
  }

  Widget _loginButton(BuildContext context) {
    return CustomFilledButton(
      title: 'Login',
      onPressed: () {
        String email = _controllerEmail.text.trim();
        String password = _controllerPassword.text.trim();
        context.read<LoginCubit>().login(email, password, context);
      },
    );
  }
}
