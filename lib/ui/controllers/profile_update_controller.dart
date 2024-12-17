import 'dart:convert';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager_with_getx/data/models/network_response.dart';
import 'package:task_manager_with_getx/data/models/user_model.dart';
import 'package:task_manager_with_getx/data/services/network_caller.dart';
import 'package:task_manager_with_getx/data/utils/urls.dart';

class ProfileUpdateController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;
  XFile? _selectedImage;

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage;

  XFile? get selectedImage => _selectedImage;

  Future<bool> updateProfile(String email, String firstName, String lastName,
      String mobile, String password) async {
    _inProgress = true;
    update();

    Map<String, dynamic> requestBody = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,

    };
    if (password.isNotEmpty) {
      requestBody['password'] = password;
    }
    if (_selectedImage != null) {
      List<int> imageByte = await _selectedImage!.readAsBytes();
      String convertedImage = base64Encode(imageByte);
      requestBody['photo'] = convertedImage;
    }
    final NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.profileUpdate,
      body: requestBody,
    );

    if (response.isSuccess) {
      UserModel userModel = UserModel.fromJson(requestBody);
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return response.isSuccess;
  }

  Future<void> pickedImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedImage =
    await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      _selectedImage = pickedImage;
      update();
    }
  }
}
