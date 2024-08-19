import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_with_get_x/controllers/task_status_count_controller.dart';
import 'package:task_manager_with_get_x/data/models/status_count_data_model.dart';

class TaskStatusCountWidget extends StatefulWidget {
  const TaskStatusCountWidget({super.key});

  @override
  State<TaskStatusCountWidget> createState() => _TaskStatusCountWidgetState();
}

class _TaskStatusCountWidgetState extends State<TaskStatusCountWidget> {
  List<StatusCountDataModel> taskStatusList = [];

  Future<void> _getTaskStatus() async {
    taskStatusList =
        await Get.find<TaskStatusCountController>().taskStatusCountRequest();
  }

  @override
  void initState() {
    _getTaskStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return GetBuilder<TaskStatusCountController>(
      builder: (controller) {
        return Container(
          height: 100,
          width: screenWidth,
          color: Colors.green.shade50,
          child: ListView.builder(
            itemBuilder: (context, index) => _buildCard(
                taskStatusList[index].sum.toString(),
                taskStatusList[index].sId.toString()),
            itemCount: taskStatusList.length,
            scrollDirection: Axis.horizontal,
          ),
        );
      },
    );
  }

  Card _buildCard(String sum, String name) {
    return Card(
      elevation: 3,
      color: const Color.fromARGB(100, 193, 186, 186),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        height: 95,
        width: MediaQuery.of(context).size.width * .25,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                sum,
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: Colors.black),
              ),
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
