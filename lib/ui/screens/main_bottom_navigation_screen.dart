import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:task_manager_with_get_x/controllers/navigation_screen_controller.dart';
import 'package:task_manager_with_get_x/ui/screens/create_task_screen.dart';
import 'package:task_manager_with_get_x/ui/screens/new_task_screen.dart';
import 'package:task_manager_with_get_x/ui/screens/cancelled_task_screen.dart';
import 'package:task_manager_with_get_x/ui/screens/completed_task_screen.dart';
import 'package:task_manager_with_get_x/ui/screens/in_progress_task_screen.dart';
import 'package:task_manager_with_get_x/ui/screens/all_task_screen.dart';
import 'package:task_manager_with_get_x/ui/widgets/appbar_widget.dart';
import 'package:task_manager_with_get_x/ui/widgets/task_status_count_widget.dart';

class MainBottomNavigationScreen extends StatefulWidget {
  const MainBottomNavigationScreen({super.key});

  @override
  State<MainBottomNavigationScreen> createState() =>
      _MainBottomNavigationScreenState();
}

class _MainBottomNavigationScreenState
    extends State<MainBottomNavigationScreen> {
  final List<Widget> _renderScreens = [
    const AllTaskScreen(),
    const NewTaskScreen(),
    const InProgressTaskScreen(),
    const CompletedTaskScreen(),
    const CancelledTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationScreenController>(
        builder: (navigationScreenController) {
      return Scaffold(
        appBar: appBarWidget(context),
        bottomNavigationBar: Padding(
          padding:
              const EdgeInsets.only(bottom: 20, left: 20, right: 20, top: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: NavigationBar(
              selectedIndex: navigationScreenController.currentIndex,
              onDestinationSelected: (index) =>
                  navigationScreenController.renderScreen(index),
              height: 70,
              destinations: const [
                NavigationDestination(
                    icon: Icon(CupertinoIcons.doc_text), label: "All"),
                NavigationDestination(
                    icon: Icon(CupertinoIcons.add_circled), label: "New"),
                NavigationDestination(
                    icon: Icon(CupertinoIcons.memories), label: "Progress"),
                NavigationDestination(
                    icon: Icon(CupertinoIcons.checkmark_seal),
                    label: "Completed"),
                // NavigationDestination(
                //     icon: Icon(CupertinoIcons.xmark_seal), label: "Cancelled"),
              ],
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //const TaskStatusCountWidget(),
            Expanded(
                child: _renderScreens[navigationScreenController.currentIndex]),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          onPressed: () {
            Get.to(() => const CreateTaskScreen());
          },
          label: const Icon(Icons.add),
        ),
      );
    });
  }
}
