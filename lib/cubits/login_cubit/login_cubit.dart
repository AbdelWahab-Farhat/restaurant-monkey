import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocode/geocode.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mealmoneky/model/account_user.dart';
import 'package:mealmoneky/model/address.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());


  // Login Method
  Future<void> googleLogin() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signIn();
    } on Exception catch (_) {}
  }

  Future<void> login(
      String email, String password, BuildContext context) async {
    if (!email.isEmail || email.isEmpty) {
      emit(LoginBadInfo(message: 'Please Enter Valid Email'));
      return;
    } else if (password.length < 8 ||
        password.isEmpty) {
      emit(LoginBadInfo(message: 'Please Enter Valid Password'));
      return;
    }
    final firebaseAuth = FirebaseAuth.instance;
    try {
      emit(LoginLoading());
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      emit(LoginSuccessful(message: 'Login Successful'));
    } on FirebaseAuthException catch (error) {
      late String errorMessage;
      if (error.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (error.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user.';
      } else if (error.code == 'invalid-email') {
        errorMessage = 'The email address is not valid.';
      } else if (error.code == 'user-disabled') {
        errorMessage = 'The user account has been disabled.';
      } else if (error.code == 'weak-password') {
        errorMessage = ' password provided too weak.';
      } else {
        errorMessage = 'An unknown error occurred. Please try again.';
      }
      emit(LoginError(message: errorMessage));
    } catch (error) {
      emit(LoginError(message: 'An unknown error occurred. Please try again.x'));
    }
  }
}
