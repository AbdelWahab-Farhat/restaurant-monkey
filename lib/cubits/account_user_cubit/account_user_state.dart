part of 'account_user_cubit.dart';

@immutable
sealed class AccountUserState {}


final class AccountUserChangedState extends AccountUserState{
  AccountUser? accountUser;
  AccountUserChangedState({required this.accountUser});
}
final class AccountUserLoadingState extends AccountUserState {}
final class AccountUserErrorState extends AccountUserState {}
final class AccountUserOnUpDateState extends AccountUserState {
  AccountUser accountUser;
  AccountUserOnUpDateState({required this.accountUser});
}
