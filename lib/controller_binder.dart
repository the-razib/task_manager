import 'package:get/get.dart';
import 'package:task_manager_with_getx/ui/controllers/add_new_task_controller.dart';
import 'package:task_manager_with_getx/ui/controllers/cancelled_task_controller.dart';
import 'package:task_manager_with_getx/ui/controllers/forgot_password_email_controller.dart';
import 'package:task_manager_with_getx/ui/controllers/forgot_password_otp_controller.dart';
import 'package:task_manager_with_getx/ui/controllers/new_task_list_controller.dart';
import 'package:task_manager_with_getx/ui/controllers/progress_task_controller.dart';
import 'package:task_manager_with_getx/ui/controllers/reset_password_controller.dart';
import 'package:task_manager_with_getx/ui/controllers/sign_up_controller.dart';
import 'package:task_manager_with_getx/ui/controllers/sing_in_controller.dart';
import 'package:task_manager_with_getx/ui/controllers/splas_screen_controller.dart';
import 'package:task_manager_with_getx/ui/controllers/chang_task_status_controller.dart';
import 'package:task_manager_with_getx/ui/controllers/task_delet_controller.dart';
import 'package:task_manager_with_getx/ui/controllers/task_manager_app_ber_controller.dart';
import 'package:task_manager_with_getx/ui/controllers/task_status_count_controller.dart';

import 'ui/controllers/compeleted_task_controller.dart';
import 'ui/controllers/profile_update_controller.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.put(SignInController());
    Get.put(SignUpController());
    Get.put(ForgotPasswordEmailController());
    Get.put(ForgotPasswordOTPController());
    Get.put(ResetPasswordController());
    Get.put(NewTaskListController());
    Get.put(TaskStatusCountController());
    Get.put(AddNewTaskController());
    Get.put(CancelledTaskController());
    Get.put(CompletedTaskController());
    Get.put(ProgressTaskController());
    Get.put(SplashScreenController());
    Get.put(ProfileUpdateController());
    Get.put(TaskDeleteController());
    Get.put(ChangeTaskStatusController());
    Get.put(TaskManagerAppBerController());
  }

}