import 'package:get/get.dart';
import 'package:task_manager_with_get_x/data/network_callers.dart';
import 'package:task_manager_with_get_x/data/network_respone.dart';
import 'package:task_manager_with_get_x/utilities/asset_paths_and_urls.dart';

class DeleteTaskController extends GetxController {
  bool deleteTakInProgress = false;

  Future<bool> deleteTaskRequest (String id) async {
    deleteTakInProgress = true;
    update();

    NetworkResponse networkResponse = await NetworkCallers.getRequestAPI(AssetPathsAndUrls.deleteTaskURL+id);

    deleteTakInProgress = false;
    update();

    if(networkResponse.isSuccess) {
      return true;
    } else {
      return false;
    }
  }
}