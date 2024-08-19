import 'package:task_manager_with_get_x/data/models/task_status_data_model.dart';

class TaskStatusModel {
  String? status;
  List<TaskStatusDataModel>? taskList;

  TaskStatusModel({this.status, this.taskList});

  TaskStatusModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      taskList = <TaskStatusDataModel>[];
      json['data'].forEach((v) {
        taskList!.add(TaskStatusDataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    if (taskList != null) {
      data['data'] = taskList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}