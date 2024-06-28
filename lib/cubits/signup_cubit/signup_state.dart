part of 'signup_cubit.dart';

@immutable
sealed class SignupState {}

final class SignupInitial extends SignupState {}

final class SignupBadInfo extends SignupState {
  String message;
  SignupBadInfo({required this.message});
}

final class SignupError extends SignupState {
  String message;
  SignupError({required this.message});
}
final class SignupSuccessful extends SignupState {
  String message;
  SignupSuccessful({required this.message});
}
final class SignupLoading extends SignupState {}


