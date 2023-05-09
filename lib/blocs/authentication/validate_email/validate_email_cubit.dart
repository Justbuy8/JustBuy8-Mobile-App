import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/controllers/authentication/auth_controller.dart';
import 'package:meta/meta.dart';

part 'validate_email_state.dart';

class ValidateEmailCubit extends Cubit<ValidateEmailState> {
  ValidateEmailCubit() : super(ValidateEmailInitial());

  ApiManager apiManager = ApiManager();
  dynamic response;

  validateEmail(email) async {
    // try {
    response = await AuthenticationController.getEmailVerification(email);
    //   if (response['Message'] == '' && response['Success'] == true) {
    //     emit(ValidateEmailSuccessfuly());
    //   } else if (response['Message'] == 'Email already exist' &&
    //       response['Success'] == false) {
    //     emit(ValidateEmailAlreadyExist());
    //   }
    // } on SocketException {
    //   emit(ValidateEmailInternetError());
    // } on TimeoutException {
    //   emit(ValidateEmailTimeOut());
    // } catch (e) {
    //   emit(ValidateEmailFailed());
    // }

    //   if (response.statusCode == 200) {
    //     emit(LoginAuthorizedUser());
    //   }
    // } on AuthException catch (e) {
    //   if (e.message == 'Sign in failed') {
    //     emit(LoginInternetError());
    //   } else {
    //     emit(LoginUnAuthorizedUser());
    //   }
    // }
  }
}
