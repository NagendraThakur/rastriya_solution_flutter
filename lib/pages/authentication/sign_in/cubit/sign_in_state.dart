part of 'sign_in_cubit.dart';

abstract class SignInState {}

class SignInInitial extends SignInState {}

class SignInLoading extends SignInState {}

class SignInSuccess extends SignInState {
  final AuthModel authModel;

  SignInSuccess({required this.authModel});
}

class SignInFailure extends SignInState {
  final String error;
  SignInFailure(this.error);
}

class PasswordVisibilityState extends SignInState {
  final bool isVisible;
  PasswordVisibilityState(this.isVisible);
}
