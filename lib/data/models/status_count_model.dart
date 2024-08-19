import 'package:task_manager_with_get_x/data/models/status_count_data_model.dart';

class StatusCountModel {
  String? status;
  List<StatusCountDataModel>? statusCountList;

  StatusCountModel({this.status, this.statusCountList});

  StatusCountModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      statusCountList = <StatusCountDataModel>[];
      json['data'].forEach((v) {
        statusCountList!.add(StatusCountDataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    if (statusCountList != null) {
      data['data'] = statusCountList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}