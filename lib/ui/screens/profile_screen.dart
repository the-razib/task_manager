import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_with_getx/ui/controllers/auth_controller.dart';
import 'package:task_manager_with_getx/ui/controllers/profile_update_controller.dart';
import 'package:task_manager_with_getx/ui/controllers/task_manager_app_ber_controller.dart';
import 'package:task_manager_with_getx/ui/utils/app_colors.dart';
import 'package:task_manager_with_getx/ui/widgets/centerted_circular_progress_indicator.dart';
import 'package:task_manager_with_getx/ui/widgets/snackber_message.dart';
import 'package:task_manager_with_getx/ui/widgets/task_background.dart';
import 'package:task_manager_with_getx/ui/widgets/task_manager_app_ber.dart';

class ProfileScreen extends StatefulWidget {
  static const String name = '/profile-screen';

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _phoneTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ProfileUpdateController profileUpdateController =
      Get.find<ProfileUpdateController>();

  @override
  void initState() {
    setUserData();
    super.initState();
  }

  void setUserData() {
    _emailTEController.text = AuthController.userdata?.email ?? ' ';
    _firstNameTEController.text = AuthController.userdata?.firstName ?? ' ';
    _lastNameTEController.text = AuthController.userdata?.lastName ?? ' ';
    _phoneTEController.text = AuthController.userdata?.mobile ?? ' ';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TaskManagerAppBer(isProfileOpen: true),
      body: TaskBackground(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  Text(
                    'Get Started With',
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 24),
                  buildPhotoPicker(),
                  const SizedBox(height: 8),
                  TextFormField(
                    enabled: false,
                    controller: _emailTEController,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _firstNameTEController,
                    decoration: const InputDecoration(
                      hintText: 'First Name ',
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter first name';
                      }
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _lastNameTEController,
                    decoration: const InputDecoration(
                      hintText: 'Last Name',
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter last name';
                      }
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _phoneTEController,
                    decoration: const InputDecoration(
                      hintText: 'Phone',
                      prefixIcon: Icon(Icons.phone),
                    ),
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter phone number';
                      }
                      if (value?.length != 11) {
                        return 'Please enter valid phone number';
                      }
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _passwordTEController,
                    decoration:  const InputDecoration(hintText: 'Password',
                      prefixIcon: Icon(Icons.lock_open_outlined),),
                  ),
                  const SizedBox(height: 16),
                  GetBuilder<ProfileUpdateController>(builder: (controller) {
                    return Visibility(
                      visible: !controller.inProgress,
                      replacement: const CenterCircularProgressIndicator(),
                      child: ElevatedButton(
                          onPressed: _onTabUpdateProfile,
                          child: const Text(
                            'Update Profile',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          )),
                    );
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPhotoPicker() {
    return GestureDetector(
      onTap: () {
        _pickedImage();
      },
      child: Container(
        height: 50,
        width: 500,
        color: Colors.white,
        child: Row(
          children: [
            Container(
              height: 50,
              width: 100,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: AppColor.themeColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
              child: const Text(
                'Photo',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
            const SizedBox(width: 14),
            GetBuilder<ProfileUpdateController>(
              builder: (controller) {
                return Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(_selectedImageTitle(),
                        overflow: TextOverflow.ellipsis),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  String _selectedImageTitle() {
    if (profileUpdateController.selectedImage != null) {
      return profileUpdateController.selectedImage!.name;
    }
    return 'Select Photo';
  }

  void _onTabUpdateProfile() {
    if (_formKey.currentState!.validate()) {
      _updateProfile();
    }
  }

  Future<void> _updateProfile() async {
    final bool result = await profileUpdateController.updateProfile(
      _emailTEController.text.trim(),
      _firstNameTEController.text.trim(),
      _lastNameTEController.text.trim(),
      _phoneTEController.text.trim(),
      _passwordTEController.text.trim(),
    );

    if (result) {
      Get.find<TaskManagerAppBerController>().updateUserData();
      showSnackBerMessage('Profile Updated Successfully');
    } else {
      showSnackBerMessage(profileUpdateController.errorMessage!);
    }
  }

  Future<void> _pickedImage() async {
    await profileUpdateController.pickedImage();
  }
}
