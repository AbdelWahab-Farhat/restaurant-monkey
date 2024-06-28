
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mealmoneky/blocs/food_details_bloc.dart';
import 'package:mealmoneky/cubits/account_user_cubit/account_user_cubit.dart';
import 'package:mealmoneky/cubits/food_cubit/food_cubit.dart';
import 'package:mealmoneky/cubits/login_cubit/login_cubit.dart';
import 'package:mealmoneky/cubits/root_cubit.dart';
import 'package:mealmoneky/cubits/signup_cubit/signup_cubit.dart';
import 'package:mealmoneky/pages/auth/login_page.dart';
import 'package:mealmoneky/pages/auth/reset_password_page.dart';
import 'package:mealmoneky/pages/auth/sign_up_page.dart';
import 'package:mealmoneky/pages/home_page.dart';
import 'package:mealmoneky/pages/menu/menu_detail_page.dart';
import 'package:mealmoneky/pages/on_boarding_page.dart';
import 'package:mealmoneky/pages/root_page.dart';
import 'package:mealmoneky/pages/splash_page.dart';
import 'package:mealmoneky/pages/startUp_page.dart';
import 'package:mealmoneky/utility/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mealmoneky/utility/fetching_methods.dart';
import 'package:mealmoneky/utility/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
bool isFirstTime = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final sharedPreferences = await SharedPreferences.getInstance();
  if (sharedPreferences.containsKey('isFirstTime')) {
    bool isFirstTime = false;
  }
  else {
    await sharedPreferences.setBool('isFirstTime', true);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
  providers: [
    BlocProvider(
      create: (context) => RootCubit(),
),
    BlocProvider(
      create: (context) => LoginCubit(),
    ),
    BlocProvider(
      create: (context) => SignupCubit(),
    ),
    BlocProvider(create: (context) => FoodCubit()),
    BlocProvider(create: (context) => AccountUserCubit()),
    BlocProvider(create: (context) => FoodDetailsBloc(),)
  ],
  child: MaterialApp(
        routes: <String, WidgetBuilder>{
          'login': (BuildContext context) => LoginPage(),
          'signup': (BuildContext context) => SignUpPage(),
          'home': (BuildContext context) => const HomePage(),
          'root': (BuildContext context) => const RootPage(),
          'splash': (BuildContext context) => const SplashPage(),
          'startup': (BuildContext context) => const StartUpPage(),
          'reset_password': (BuildContext context) => ResetPasswordPage(),
          'otp_massage': (BuildContext context) => OtpMassagePage(),
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: GoogleFonts.poppins().fontFamily,
        ),
        home: const SplashToRootPage(),
      ),
);
  }
}

class SplashToRootPage extends StatefulWidget {
  const SplashToRootPage({super.key});

  @override
  State<SplashToRootPage> createState() => _SplashToRootPageState();
}

class _SplashToRootPageState extends State<SplashToRootPage> {


  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return FutureBuilder(
      future: Future.delayed(const Duration(milliseconds: 2), ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashPage();
        } else {
          return  StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(), builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting ) {
                  return const SplashPage();
                }
                else if (snapshot.connectionState == ConnectionState.none) {
                  return const Text('Check Internet And Try Again');
                }
                else if (snapshot.hasData) {
                  return const RootPage();
                }
                else if (!snapshot.hasData) {
                  if (isFirstTime) {
                    return OnBoardingPage();
                  }
                  return const StartUpPage();
                }
                else  {
                  Get.defaultDialog(
                    title: 'Error',
                    content: const Text('Please Restart The App.',style:TextStyle(color: mainColor,fontSize: 20,),),
                  );
                  return const SplashPage();
                }
              },);
        }
      },
    );
  }
}
