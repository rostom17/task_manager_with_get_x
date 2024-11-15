class AssetPathsAndUrls {
  static const String backgroundSVG = 'assets/images/background.svg';
  static const String logoSvg = 'assets/images/logo.svg';

  static  RegExp emailChecker = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  static const String _baseURL = "http://35.73.30.144:2005/api/v1";
  static const String loginURL = '$_baseURL/Login';
  static const String signUpURL = '$_baseURL/Registration';
  static const String newTaskURL = '$_baseURL/listTaskByStatus/New';
  static const String completedTaskURL = '$_baseURL/listTaskByStatus/Completed';
  static const String cancelledTaskURL = '$_baseURL/listTaskByStatus/Cancelled';
  static const String inProgressTaskURL = '$_baseURL/listTaskByStatus/Progress';
  static const String createTaskURL = '$_baseURL/createTask';
  static const String taskStatusCountURL = '$_baseURL/taskStatusCount';
  static const String deleteTaskURL = '$_baseURL/deleteTask/';
  static const String updateTaskStatus = '$_baseURL/updateTaskStatus/';
  static const String updateProfile = '$_baseURL/ProfileUpdate';
  static const String recoveryEmailURL = '$_baseURL/RecoverVerifyEmail/';
  static const String recoveryOTPURL = '$_baseURL/RecoverVerifyOTP/';
  static const String resetPasswordURL = '$_baseURL/RecoverResetPass';
}