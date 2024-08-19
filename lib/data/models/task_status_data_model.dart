class TaskStatusDataModel {
  String? sId;
  String? title;
  String? description;
  String? status;
  String? createdDate;

  TaskStatusDataModel({this.sId, this.title, this.description, this.status, this.createdDate});

  TaskStatusDataModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['title'] = title;
    data['description'] = description;
    data['status'] = status;
    data['createdDate'] = createdDate;
    return data;
  }
}