import 'package:bloc/bloc.dart';
import 'package:rastriya_solution_flutter/constants/config.dart';
import 'package:rastriya_solution_flutter/data/repository/get_repository.dart';
import 'package:rastriya_solution_flutter/data/repository/google_access_token.dart';
import 'package:rastriya_solution_flutter/data/repository/post_repository.dart';
import 'package:rastriya_solution_flutter/model/auth_model.dart';
import 'package:rastriya_solution_flutter/model/user_model.dart';
import 'package:rastriya_solution_flutter/shared/shared_pre.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());

  void updateUser({required User user}) {
    if (state is SignInSuccess) {
      final currentState =
          state as SignInSuccess; // Cast state to SignInSuccess
      final updatedAuthModel = currentState.authModel.copyWith(user: user);
      emit(SignInSuccess(authModel: updatedAuthModel));
    }
  }

  void signInButtonPressed(
      {required String username, required String password}) async {
    deleteAllSharedPreferences();
    emit(SignInLoading());
    try {
      final response = await PostRepository().authPostRequest(
          path: PostRepository.classicAuth,
          body: {"username": username, "password": password});
      responseHandeling(response: response);
    } catch (e) {
      emit(SignInFailure(e.toString()));
    }
  }

  Future<void> googleSignIn() async {
    deleteAllSharedPreferences();
    emit(SignInLoading());
    final accessToken = await GoogleAccessToken().signInWithGoogle();
    if (accessToken != null) {
      try {
        final response = await PostRepository().authPostRequest(
            path: PostRepository.googleAuth,
            body: {"google_token": accessToken});
        responseHandeling(response: response);
      } catch (error) {
        emit(SignInFailure('Error: $error'));
      }
    } else {
      emit(SignInFailure('Google Sign-In Failed'));
    }
  }

  Future<void> userTokenSignIn() async {
    emit(SignInLoading());
    final response =
        await GetRepository().getRequest(path: GetRepository.loggedinUserInfo);
    loggedinResponseHandeling(response: response);
  }

  void loggedinResponseHandeling({required dynamic response}) {
    if (response != null) {
      final AuthModel authModel = AuthModel.fromJson(response);
      emit(SignInSuccess(authModel: authModel));
    } else {
      emit(SignInFailure(
        'Session Expired',
      ));
    }
  }

  void responseHandeling({required dynamic response}) {
    if (response != null) {
      if (response["status"] == "success") {
        final AuthModel authModel = AuthModel.fromJson(response);
        savePreference(
            key: "userAuthenticationToken",
            value: authModel.userAuthenticationToken);
        Config.userAuthenticationToken = authModel.userAuthenticationToken;
        savePreference(key: "assetsUpload", value: authModel.assets!.uploads);
        Config.assetsUpload = authModel.assets!.uploads;
        emit(SignInSuccess(authModel: authModel));
      } else {
        emit(SignInFailure(response["message"]));
      }
      GoogleAccessToken().signOutFromGoogle();
    } else {
      emit(SignInFailure('Authentication failed'));
    }
  }

  bool _isPasswordVisible = false;

  void logout() {
    Config.clear();
    deleteAllSharedPreferences();
    savePreference(key: "onBoarding", value: "true");
    emit(SignInInitial());
  }

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    emit(PasswordVisibilityState(_isPasswordVisible));
  }
}
