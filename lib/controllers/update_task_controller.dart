import 'package:get/get.dart';
import 'package:task_manager_with_get_x/data/network_callers.dart';
import 'package:task_manager_with_get_x/data/network_respone.dart';
import 'package:task_manager_with_get_x/utilities/asset_paths_and_urls.dart';

class UpdateTaskController extends GetxController {
  bool updateTaskInProgress = false;

  Future<bool> updateTaskRequest (String id, String newStatus) async {
    updateTaskInProgress = true;
    update();

    NetworkResponse networkResponse = await NetworkCallers.getRequestAPI("${AssetPathsAndUrls.updateTaskStatus}$id/$newStatus");

    updateTaskInProgress = false;
    update();

    if(networkResponse.isSuccess) {
      return true;
    }
    else {
      return false;
    }
  }
}