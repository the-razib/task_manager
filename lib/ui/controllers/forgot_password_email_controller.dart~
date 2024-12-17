import 'package:get/get.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';

class ForgotPasswordEmailController extends GetxController{
  bool _forgetPasswordInProgress=false;
  bool get forgetPasswordInProgress=> _forgetPasswordInProgress;

  String? _errorMessage;
  String? get errorMessage=>_errorMessage;

  Future<bool> sendOTPForEmailVerification(String email) async {
    bool isSuccess=false;
      _forgetPasswordInProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.recoverVerifyEmail(email),
    );

    if (response.isSuccess) {
      isSuccess=true;
    } else {
      _errorMessage=response.errorMessage;
    }
    _forgetPasswordInProgress = false;
    update();
    return isSuccess;
  }

}