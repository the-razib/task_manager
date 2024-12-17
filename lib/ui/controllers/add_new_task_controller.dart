import 'package:get/get.dart';
import 'package:task_manager_with_getx/data/models/network_response.dart';
import 'package:task_manager_with_getx/data/services/network_caller.dart';
import 'package:task_manager_with_getx/data/utils/urls.dart';

class AddNewTaskController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;
  bool _shoudRefreshPreviousPage = false;

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage;
  bool get  shoudRefreshPreviousPage => _shoudRefreshPreviousPage;

  Future<bool> addNewTask(
    String title,
    String description,
  ) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    Map<String, dynamic> requestBody = {
      "title": title,
      "description": description,
      "status": "New"
    };

    final NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.createTask,
      body: requestBody,
    );

    if (response.isSuccess) {
      isSuccess = true;
      _shoudRefreshPreviousPage=true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
