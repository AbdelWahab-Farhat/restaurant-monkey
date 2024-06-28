import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mealmoneky/model/account_user.dart';
import 'package:mealmoneky/model/address.dart';
import 'package:mealmoneky/model/user_cart.dart';
import 'package:meta/meta.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());


  Future<void> signUp(
      String name,
      String email,
      String password,
      String confirmedPassword,
      UserAddress? address,
      String phoneNumber) async {
    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmedPassword.isEmpty ||
        phoneNumber.isEmpty ||
        address == null) {
      emit(SignupBadInfo(message: 'Please Fill The Fields'));
      return;
    }
    if (password != confirmedPassword) {
      emit(SignupBadInfo(message: 'Passwords does not match'));
      return;
    }
    if (!email.isEmail) {
      emit(SignupBadInfo(message: 'Please Enter Correct Email'));
    }
    if (password.length < 8) {
      emit((SignupBadInfo(message: 'Short Password Length minimum is 8 digits')));
    }
    emit(SignupLoading());
    final firebaseAuth = FirebaseAuth.instance;
    final firebaseFireStore = FirebaseFirestore.instance;
    AccountUser user = AccountUser(
        name: name, email: email, phoneNumber: phoneNumber, address: address, id: '', userCart: UserCart(userId: '', userCartFoods: []));
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      user.id = firebaseAuth.currentUser!.uid;
      user.userCart.userId = firebaseAuth.currentUser!.uid;
      // Done creating
      try {
        await firebaseFireStore
            .collection('users')
            .doc(user.id)
            .set(user.toJson());
      } on FirebaseException catch (_) {
        emit(SignupError(message: 'Error Saving Data'));
        return;
      }
      emit(SignupSuccessful(message: 'Account Created Successful'));
    } on FirebaseAuthException catch (_) {
      emit(SignupError(message: 'Check internet And try Again'));
      firebaseFireStore.collection('users').doc(user.id).delete();
    }
  }
}
