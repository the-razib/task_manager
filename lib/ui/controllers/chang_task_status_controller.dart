import 'package:get/get.dart';
import 'package:task_manager_with_getx/data/models/network_response.dart';
import 'package:task_manager_with_getx/data/services/network_caller.dart';
import 'package:task_manager_with_getx/data/utils/urls.dart';

class ChangeTaskStatusController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage;

  Future<bool> changesStatues(String taskId, String newStatus) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse networkResponse = await NetworkCaller.getRequest(
        url: Urls.changeStatus(taskId, newStatus));

    if (networkResponse.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = networkResponse.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
