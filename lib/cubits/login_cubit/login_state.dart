part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginBadInfo extends LoginState {
  String message;
  LoginBadInfo({required this.message});
}

final class LoginError extends LoginState {
  String message;
  LoginError({required this.message});
}
final class LoginSuccessful extends LoginState {
  String message;
  LoginSuccessful({required this.message});
}
final class LoginLoading extends LoginState {}


