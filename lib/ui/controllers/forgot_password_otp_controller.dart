import 'package:get/get.dart';
import 'package:task_manager_with_getx/data/models/network_response.dart';
import 'package:task_manager_with_getx/data/services/network_caller.dart';
import 'package:task_manager_with_getx/data/utils/urls.dart';

class ForgotPasswordOTPController extends GetxController {
  bool _pinVerificationInProgress = false;

  bool get pinVerificationInProgress => _pinVerificationInProgress;
  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> pinVerification(String email, String otp) async {
    bool isSuccess = false;

    _pinVerificationInProgress = true;
    update();

    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.recoverVerifyOtp(email, otp));

    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _pinVerificationInProgress = false;
    update();
    return isSuccess;
  }
}
