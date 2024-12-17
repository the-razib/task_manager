import 'package:get/get.dart';
import 'package:task_manager_with_getx/data/models/login_model.dart';
import 'package:task_manager_with_getx/data/models/network_response.dart';
import 'package:task_manager_with_getx/data/services/network_caller.dart';
import 'package:task_manager_with_getx/data/utils/urls.dart';
import 'package:task_manager_with_getx/ui/controllers/auth_controller.dart';

class SignInController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage;

  Future<bool> signIn(String email, String password) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    Map<String, dynamic> requestBody = {'email': email, 'password': password};

    NetworkResponse response =
        await NetworkCaller.postRequest(url: Urls.login, body: requestBody);
    if (response.isSuccess) {
      LogInModel logInModel = LogInModel.fromJson(response.responseData);
      // Save the access token to shared preferences
      await AuthController.saveAccessToken(logInModel.token!);
      await AuthController.saveUserData(logInModel.data!);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
