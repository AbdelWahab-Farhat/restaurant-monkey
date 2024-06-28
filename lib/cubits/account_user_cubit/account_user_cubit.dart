
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mealmoneky/blocs/food_details_bloc.dart';
import 'package:mealmoneky/model/account_user.dart';
import 'package:meta/meta.dart';

part 'account_user_state.dart';

class AccountUserCubit extends Cubit<AccountUserState> {
  AccountUserCubit() : super(AccountUserChangedState(accountUser:null));

  Future<void> getUser()async {
    final firebaseStore = FirebaseFirestore.instance;
    final firebaseAuth  = FirebaseAuth.instance;
    try {
      final userData = await firebaseStore.collection('users').doc(firebaseAuth.currentUser!.uid).get();
      AccountUser currentUser = AccountUser.fromJson(userData.data()!,firebaseAuth.currentUser!.uid);
      emit(AccountUserChangedState(accountUser: currentUser));
      } on FirebaseException catch (e) {
      emit(AccountUserErrorState());
    }
  }
  // when click on edit button
 void onUpdateAccountUser(AccountUser user) {
    emit(AccountUserOnUpDateState(accountUser: user));
}

// When click on save button
Future<void> updateAccountUser(AccountUser updatedUser) async {
  final firebaseStore = FirebaseFirestore.instance;
  try {
    emit(AccountUserLoadingState());
    await firebaseStore.collection('users').doc(updatedUser.id).update(updatedUser.toJson());
    getUser();
  } on Exception catch (e) {
    emit(AccountUserErrorState());
  }
}
}


