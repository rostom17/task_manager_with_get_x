import 'package:get/get.dart';
import 'package:task_manager_with_get_x/data/models/task_status_data_model.dart';
import 'package:task_manager_with_get_x/data/models/task_status_model.dart';
import 'package:task_manager_with_get_x/data/network_callers.dart';
import 'package:task_manager_with_get_x/data/network_respone.dart';
import 'package:task_manager_with_get_x/utilities/asset_paths_and_urls.dart';

class CancelledTaskController extends GetxController {
  bool getCancelledTaskInProgress = false;

   Future<List<TaskStatusDataModel>> getCancelledTaskRequest () async {
     getCancelledTaskInProgress = true;
     update();
     NetworkResponse networkResponse = await NetworkCallers.getRequestAPI(AssetPathsAndUrls.cancelledTaskURL);

     getCancelledTaskInProgress = false;
     update();

     if(networkResponse.isSuccess) {
       TaskStatusModel taskStatusModel = TaskStatusModel.fromJson(networkResponse.responseData);
       return taskStatusModel.taskList ?? [];
     } else {
       return [];
     }
   }
}