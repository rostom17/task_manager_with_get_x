import 'package:task_manager_with_get_x/data/models/user_data_model.dart';

class LoginModel {
  String? status;
  String? token;
  UserDataModel? userDataModel;

  LoginModel({this.status, this.token, this.userDataModel});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    token = json['token'];
    userDataModel = json['data'] != null ? UserDataModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['token'] = token;
    if (userDataModel != null) {
      data['data'] = userDataModel!.toJson();
    }
    return data;
  }
}

