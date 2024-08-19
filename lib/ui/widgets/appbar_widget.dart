import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_with_get_x/controllers/authentication_controller.dart';
import 'package:task_manager_with_get_x/ui/screens/log_in_screen.dart';
import 'package:task_manager_with_get_x/ui/screens/update_profile_screen.dart';

AppBar appBarWidget(context) {
  return AppBar(
    backgroundColor: Colors.green.shade500,
    leading: GestureDetector(
      onTap: _onTapImageOrName,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          child: ClipRect(
            child: Image.memory(
              base64Decode(
                  AuthenticationController.userData?.photo ?? "NO Image"),
            ),
          ),
        ),
      ),
    ),
    title: GestureDetector(
      onTap: _onTapImageOrName,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${AuthenticationController.userData!.firstName} ${AuthenticationController.userData!.lastName}",
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            AuthenticationController.userData!.email ?? "",
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white),
          ),
        ],
      ),
    ),
    actions: [
      const IconButton(
        onPressed: onTapLogOutButton,
        icon: Icon(
          Icons.logout,
          color: Colors.white,
        ),
      ),
      IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.dark_mode_outlined,
          color: Colors.white,
        ),
      ),
    ],
  );
}

// @override
// Size get preferredSize => const Size.fromHeight(kToolbarHeight);

void _onTapImageOrName() {
  Get.to(
    () => const UpdateProfileScreen(
      onUpdate: onUpdateProfile,
    ),
  );
}

void onUpdateProfile() {}

void onTapLogOutButton() {
  AuthenticationController.clearAllData();
  Get.offAll(() => const LogInScreen());
}
