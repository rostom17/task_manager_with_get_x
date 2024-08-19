import 'package:get/get.dart';
import 'package:task_manager_with_get_x/data/models/status_count_data_model.dart';
import 'package:task_manager_with_get_x/data/models/status_count_model.dart';
import 'package:task_manager_with_get_x/data/network_callers.dart';
import 'package:task_manager_with_get_x/data/network_respone.dart';
import 'package:task_manager_with_get_x/utilities/asset_paths_and_urls.dart';

class TaskStatusCountController extends GetxController {
  bool taskStatusCountInProgress = false;

  Future<List<StatusCountDataModel>> taskStatusCountRequest () async {
    taskStatusCountInProgress = true;
    update();

    NetworkResponse networkResponse = await NetworkCallers.getRequestAPI(AssetPathsAndUrls.taskStatusCountURL);

    taskStatusCountInProgress = false;
    update();

    if(networkResponse.isSuccess) {
      StatusCountModel statusCountModel = StatusCountModel.fromJson(networkResponse.responseData);
      List<StatusCountDataModel> taskStatus = statusCountModel.statusCountList ?? [];
      return taskStatus;
    } else {
      return [];
    }
  }
}