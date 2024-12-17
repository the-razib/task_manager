import 'package:get/get.dart';
import 'package:task_manager_with_getx/ui/controllers/auth_controller.dart';

class SplashScreenController extends GetxController {
  Future<bool> moveToNextScreen() async {
    bool isSuccess = false;
    await Future.delayed(const Duration(seconds: 2));
    await AuthController.getAccessToken();
    if (AuthController.loggedIn()) {
      await AuthController.getUserData();
      isSuccess = true;
    } else {}
    return isSuccess;
  }
}
