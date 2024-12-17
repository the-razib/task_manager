import 'package:get/get.dart';
import 'package:task_manager_with_getx/data/models/user_model.dart';
import 'package:task_manager_with_getx/ui/controllers/auth_controller.dart';

class TaskManagerAppBerController extends GetxController {
  UserModel? _userModel;

  UserModel? get userModel => _userModel;

  void updateUserData() {
    _userModel = AuthController.userdata;
    update();
  }
}
