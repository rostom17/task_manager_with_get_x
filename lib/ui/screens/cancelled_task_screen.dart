import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_with_get_x/controllers/cancelled_task_controller.dart';
import 'package:task_manager_with_get_x/data/models/task_status_data_model.dart';
import 'package:task_manager_with_get_x/ui/widgets/task_widget.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key, });



  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  List<TaskStatusDataModel> cancelledTasks = [];

  @override
  void initState() {
    _getCancelledTask();
    super.initState();
  }

  Future<void> _getCancelledTask() async {
    cancelledTasks =
        await Get.find<CancelledTaskController>().getCancelledTaskRequest();
    if (mounted) {
      if (cancelledTasks.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Get Cancelled Successful"),
            duration: Duration(milliseconds: 500),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Get Cancelled Failed !"),
            duration: Duration(milliseconds: 500),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CancelledTaskController>(
        builder: (cancelledTaskController) {
          return RefreshIndicator(
            onRefresh: _getCancelledTask,
            child: Visibility(
              visible: cancelledTaskController.getCancelledTaskInProgress == false,
              replacement: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ],
                ),
              ),
              child: ListView.builder(
                itemCount: cancelledTasks.length,
                itemBuilder: (context, index) {
                  return TaskWidget(
                    title: cancelledTasks[index].title.toString(),
                    description: cancelledTasks[index].description.toString(),
                    status: cancelledTasks[index].status.toString(),
                    datTime: cancelledTasks[index].createdDate.toString(),
                    taskId: cancelledTasks[index].sId.toString(),
                    onDeleted: _getCancelledTask,
                    onEdited: _getCancelledTask,
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
