import 'package:task_manager_with_getx/data/models/user_model.dart';

class LogInModel {
  String? status;
  UserModel? data;
  String? token;

  LogInModel({this.status, this.data, this.token});

  LogInModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ?  UserModel.fromJson(json['data']) : null;
    token = json['token'];
  }

}

