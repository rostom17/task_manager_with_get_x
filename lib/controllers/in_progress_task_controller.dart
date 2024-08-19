import 'package:get/get.dart';
import 'package:task_manager_with_get_x/data/models/task_status_data_model.dart';
import 'package:task_manager_with_get_x/data/models/task_status_model.dart';
import 'package:task_manager_with_get_x/data/network_callers.dart';
import 'package:task_manager_with_get_x/data/network_respone.dart';
import 'package:task_manager_with_get_x/utilities/asset_paths_and_urls.dart';

class InProgressTaskController extends GetxController {
  bool getInProgressTaskIsLoading = false;

  Future<List<TaskStatusDataModel>> getInProgressTasksRequest () async {
    getInProgressTaskIsLoading = true;
    update();

    NetworkResponse networkResponse = await NetworkCallers.getRequestAPI(AssetPathsAndUrls.inProgressTaskURL);

    getInProgressTaskIsLoading = false;
    update();

    if(networkResponse.isSuccess) {
      TaskStatusModel taskStatusModel = TaskStatusModel.fromJson(networkResponse.responseData);
      return taskStatusModel.taskList ?? [];
    } else {
      return [];
    }
  }
}