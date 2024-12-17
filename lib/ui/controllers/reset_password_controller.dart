import 'package:get/get.dart';
import 'package:task_manager_with_getx/data/models/network_response.dart';
import 'package:task_manager_with_getx/data/services/network_caller.dart';
import 'package:task_manager_with_getx/data/utils/urls.dart';

class ResetPasswordController extends GetxController {
  bool _setPasswordInProgress = false;

  bool get setPasswordInProgress => _setPasswordInProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> setPassword(String email, String otp, String password) async {
    bool isSuccess = false;
    _setPasswordInProgress = true;
    update();

    Map<String, dynamic> requestBody = {
      "email": email,
      "OTP": otp,
      "password": password
    };
    final NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.recoverResetPassword, body: requestBody);

    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _setPasswordInProgress = false;
    update();
    return isSuccess;
  }
}
