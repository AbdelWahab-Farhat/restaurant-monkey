import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mealmoneky/cubits/signup_cubit/signup_cubit.dart';
import 'package:mealmoneky/model/address.dart';
import 'package:mealmoneky/services/services.dart';
import 'package:mealmoneky/utility/constants.dart';
import 'package:mealmoneky/utility/helpers.dart';
import 'package:mealmoneky/widgets/buttons.dart';
import 'package:mealmoneky/widgets/custom_textfield.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late TextEditingController _controllerEmail;
  late TextEditingController _controllerName;
  late TextEditingController _controllerMobile;
  late TextEditingController _controllerPassword;
  late TextEditingController _controllerConfirmPassword;
  UserAddress? _address;
  String hint = 'Click To get Address';
  Color hintColor = Color(0xffB6B7B7);
  @override
  void initState() {
    _controllerName = TextEditingController();
    _controllerEmail = TextEditingController();
    _controllerPassword = TextEditingController();
    _controllerConfirmPassword = TextEditingController();
    _controllerMobile = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controllerName.dispose();
    _controllerMobile.dispose();
    _controllerConfirmPassword.dispose();
    _controllerPassword.dispose();
    _controllerEmail.dispose();
  }

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
                Text(
                  'Sign Up',
                  style: bigTitleStyle(),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Add your details to Create an Account',
                  style: subTitleStyle(),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(controller: _controllerName, hintText: 'Name'),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                    controller: _controllerEmail, hintText: 'Email'),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  controller: _controllerMobile,
                  hintText: 'Mobile No',
                  isPhoneNumber: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                // TODO:Future Add Address By Clicking.
                _locationTextField(
                    context, () => AppServices.determinePosition()),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  controller: _controllerPassword,
                  hintText: 'Password',
                  isPassword: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  controller: _controllerConfirmPassword,
                  hintText: 'Confirm Password',
                  isPassword: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocConsumer<SignupCubit, SignupState>(
                  listener: (context, state) {
                    if (state is SignupSuccessful) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(state.message)));
                      Navigator.pushReplacementNamed(context, 'login');
                    } else if (state is SignupBadInfo) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(state.message)));
                    } else if (state is SignupError) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(state.message)));
                    }
                  },
                  builder: (context, state) {
                    if (state is SignupLoading) {
                      return const Center(child: CircularProgressIndicator(color: compColor,));
                    }
                    else if (state is SignupBadInfo  || state is SignupError  || state is SignupInitial) {
                      return _signUpButton();
                    }
                    else {
                      return _signUpButton();
                    }
                  },
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height / 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "have an Account?",
                      style: subTitleStyle(),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                        onTap: () => Navigator.pushNamed(context, 'login'),
                        child: const Text(
                          "Login",
                          style: TextStyle(
                              color: compColor, fontWeight: FontWeight.bold),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _signUpButton(){
  return   CustomFilledButton(
      onPressed: () {
        String name = _controllerName.text.trim();
        String email = _controllerEmail.text.trim();
        String password = _controllerPassword.text.trim();
        String conPassword = _controllerConfirmPassword.text.trim();
        String phoneNumber = _controllerMobile.text.trim();
        context.read<SignupCubit>().signUp(name, email, password,conPassword,_address, phoneNumber);
      },
      title: 'Sign Up');
  }
  Widget _locationTextField(
      BuildContext context, Future<Position> Function() getLocation) {
    return GestureDetector(
      onTap: () async {
        final Position position = await getLocation();
        GeoCode geoCode = GeoCode(apiKey: '181479783094849564458x38318');
        final address = await geoCode.reverseGeocoding(
            latitude: position.latitude, longitude: position.longitude);
        _address = UserAddress(
            country: address.countryName ?? "",
            cityName: address.city ?? "",
            streetAddress: address.streetAddress ?? "");
        setState(() {
          hint ="${_address!.country}-${_address!.cityName}";
          hintColor = Colors.black;
        });
      },
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          color: const Color(0xffF2F2F2),
        ),
        child: TextField(
          enabled: false,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            border: InputBorder.none,
            hintText: hint,
            hintStyle:  TextStyle(
                color: hintColor,
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
