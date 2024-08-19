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
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            navigationScreenController.renderScreen(index);
          },
          selectedItemColor: Colors.white,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          iconSize: 30,
          elevation: 2,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.green.shade500,
          selectedIconTheme:
              const IconThemeData(color: Colors.white70),
          unselectedIconTheme:
              const IconThemeData(color: Color.fromARGB(255, 16, 15, 15)),
          currentIndex: navigationScreenController.currentIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.list_alt_outlined), label: "All"),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.pencil_ellipsis_rectangle), label: "New"),
            BottomNavigationBarItem(
                icon: Icon(Icons.incomplete_circle_outlined), label: "Progress"),
            BottomNavigationBarItem(
                icon: Icon(Icons.done_outline_outlined), label: "Completed"),
            BottomNavigationBarItem(
                icon: Icon(Icons.cancel_presentation_outlined), label: "Cancelled"),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TaskStatusCountWidget(),
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
