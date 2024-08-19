class AssetPathsAndUrls {
  static const String backgroundSVG = 'assets/images/background.svg';
  static const String logoSvg = 'assets/images/logo.svg';

  static  RegExp emailChecker = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  static const String loginURL = 'https://task.teamrabbil.com/api/v1/login';
  static const String signUpURL = 'https://task.teamrabbil.com/api/v1/registration';
  static const String newTaskURL = 'https://task.teamrabbil.com/api/v1/listTaskByStatus/New';
  static const String completedTaskURL = 'https://task.teamrabbil.com/api/v1/listTaskByStatus/Completed';
  static const String cancelledTaskURL = 'https://task.teamrabbil.com/api/v1/listTaskByStatus/Cancelled';
  static const String inProgressTaskURL = 'https://task.teamrabbil.com/api/v1/listTaskByStatus/Progress';
  static const String createTaskURL = 'https://task.teamrabbil.com/api/v1/createTask';
  static const String taskStatusCountURL = 'https://task.teamrabbil.com/api/v1/taskStatusCount';
  static const String deleteTaskURL = 'https://task.teamrabbil.com/api/v1/deleteTask/';
  static const String updateTaskStatus = 'https://task.teamrabbil.com/api/v1/updateTaskStatus/';
  static const String updateProfile = 'https://task.teamrabbil.com/api/v1/profileUpdate';
  static const String recoveryEmailURL = 'https://task.teamrabbil.com/api/v1/RecoverVerifyEmail/';
  static const String recoveryOTPURL = 'https://task.teamrabbil.com/api/v1/RecoverVerifyOTP/';
  static const String resetPasswordURL = 'https://task.teamrabbil.com/api/v1/RecoverResetPass';
}