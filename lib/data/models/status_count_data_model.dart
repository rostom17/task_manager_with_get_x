class StatusCountDataModel {
  String? sId;
  int? sum;

  StatusCountDataModel({this.sId, this.sum});

  StatusCountDataModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    sum = json['sum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['sum'] = sum;
    return data;
  }
}