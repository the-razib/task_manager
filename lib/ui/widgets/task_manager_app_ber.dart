import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_with_getx/ui/controllers/auth_controller.dart';
import 'package:task_manager_with_getx/ui/controllers/task_manager_app_ber_controller.dart';
import 'package:task_manager_with_getx/ui/screens/profile_screen.dart';
import 'package:task_manager_with_getx/ui/screens/sign_in_screen.dart';
import 'package:task_manager_with_getx/ui/utils/app_colors.dart';

class TaskManagerAppBer extends StatelessWidget implements PreferredSizeWidget {
  const TaskManagerAppBer({
    super.key,
    this.isProfileOpen = false,
  });

  final bool isProfileOpen;

  @override
  Widget build(BuildContext context) {
    final TaskManagerAppBerController taskManagerAppBerController =
    Get.find<TaskManagerAppBerController>();
    return GestureDetector(
      onTap: () {
        if (isProfileOpen) {
          return;
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ProfileScreen(),
          ),
        );
      },
      child: GetBuilder<TaskManagerAppBerController>(builder: (controller) {
        // Get profile image from the user model
        final String? profileImage = controller.userModel?.photo;

        return AppBar(
          backgroundColor: AppColor.themeColor,
          title: Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: Colors.white,
                backgroundImage: profileImage != null
                    ? (profileImage.startsWith('http') // Check if it's a URL
                    ? NetworkImage(profileImage) as ImageProvider
                    : MemoryImage(
                  base64Decode(profileImage),
                ))
                    : null,
                child: profileImage == null
                    ? const Icon(Icons.person, color: Colors.grey) // Default icon
                    : null,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.userModel?.fullName ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      controller.userModel?.email ?? '',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () async {
                  await AuthController.clearUserData();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignInScreen()),
                        (route) => false,
                  );
                },
                icon: const Icon(
                  Icons.logout,
                  size: 24,
                  color: Colors.white,
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
