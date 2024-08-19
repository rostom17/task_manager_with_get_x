import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_with_get_x/controllers/all_tasks_controller.dart';
import 'package:task_manager_with_get_x/data/models/task_status_data_model.dart';
import 'package:task_manager_with_get_x/ui/widgets/task_widget.dart';

class AllTaskScreen extends StatefulWidget {
  const AllTaskScreen({super.key});

  @override
  State<AllTaskScreen> createState() => _AllTaskScreenState();
}

class _AllTaskScreenState extends State<AllTaskScreen> {
  List<TaskStatusDataModel> allTask = [];

  Future<void> _getAllTask() async {
    allTask = await Get.find<AllTasksController>().getAllTasks();
    allTask.shuffle();

    if (mounted) {
      if (allTask.isNotEmpty) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Successfully Fetched All Tasks"),),);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Failed !"),),);
      }
    }
  }

  @override
  void initState() {
    _getAllTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: GetBuilder<AllTasksController>(
        builder: (allTaskController) {
          return RefreshIndicator(
            onRefresh: _getAllTask,
            child: Visibility(
              visible: allTaskController.allTaskInProgress == false,
              replacement: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 20,),
                    Text("Please Wait a moment !"),
                    Text("All The Task Data are fetching"),
                  ],
                ),
              ),
              child: ListView.builder(
                itemCount: allTask.length,
                itemBuilder: (context, index) {
                  return TaskWidget(
                    title: allTask[index].title.toString(),
                    description: allTask[index].description.toString(),
                    status: allTask[index].status.toString(),
                    datTime: allTask[index].createdDate.toString(),
                    taskId: allTask[index].sId.toString(),
                    onDeleted: _getAllTask,
                    onEdited: _getAllTask,
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
