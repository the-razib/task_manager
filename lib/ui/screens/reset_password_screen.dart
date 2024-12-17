import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:task_manager_with_getx/ui/controllers/reset_password_controller.dart';

import 'package:task_manager_with_getx/ui/screens/sign_in_screen.dart';
import 'package:task_manager_with_getx/ui/utils/app_colors.dart';
import 'package:task_manager_with_getx/ui/widgets/background_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:task_manager_with_getx/ui/widgets/centerted_circular_progress_indicator.dart';
import 'package:task_manager_with_getx/ui/widgets/snackber_message.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const String name = '/reset-password-screen';

  const ResetPasswordScreen({
    super.key,
  });

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController =
      TextEditingController();
  final ResetPasswordController resetPasswordController =
      Get.find<ResetPasswordController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? email;
  String? otp;

  @override
  void initState() {
    super.initState();
    final Map<String, String?> args = Get.arguments;
    email = args['email'] ?? '';
    otp = args['otp'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BackgroundScreen(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 82),
                Text(
                  'Set Password',
                  style: textTheme.displaySmall
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                Text(
                  'Minimum Length password 8 character with Latter and number combination',
                  style: textTheme.titleSmall?.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 16),
                _buildResetPasswordForm(),
                const SizedBox(height: 48),
                _buildSignInSection()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResetPasswordForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _passwordTEController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              hintText: 'Password',
              prefixIcon: Icon(Icons.lock_outlined),
            ),
            validator: (String? value) {
              if (value?.isEmpty == true) {
                return 'Please enter password';
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          TextFormField(
              controller: _confirmPasswordTEController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                hintText: 'Confirm Password',
                prefixIcon: Icon(Icons.lock_outlined),
              ),
              validator: (String? value) {
                if (value?.isEmpty == true) {
                  return 'Please enter password';
                }
                return null;
              }),
          const SizedBox(height: 24),
          GetBuilder<ResetPasswordController>(builder: (controller) {
            return Visibility(
              visible: controller.setPasswordInProgress == false,
              replacement: const CenterCircularProgressIndicator(),
              child: ElevatedButton(
                onPressed: _onTabNextButton,
                child: Text(
                  'update password',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildSignInSection() {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 14,
            wordSpacing: 4),
        text: "Have Account?",
        children: [
          TextSpan(
            text: 'Sign In',
            style: const TextStyle(color: AppColor.themeColor),
            recognizer: TapGestureRecognizer()..onTap = _onTapSignIn,
            // Note: This sets up a gesture recognizer for the "Sign Up" text.
          ),
        ],
      ),
    );
  }

  void _onTabNextButton() {
    if (_formKey.currentState!.validate()) {
      if (_passwordTEController.text == _confirmPasswordTEController.text) {
        _setPassword();
      } else {
        showSnackBerMessage('Password does not match', true);
      }
    }
  }

  void _onTapSignIn() {
    Get.offNamedUntil(
      SignInScreen.name,
      (route) => false,
    );
  }

  Future<void> _setPassword() async {
    final bool result = await resetPasswordController.setPassword(
        email!, otp!, _passwordTEController.text);

    if (result) {
      showSnackBerMessage('Password set successfully');
      Get.offNamedUntil(
        SignInScreen.name,
        (route) => false,
      );
    } else {
      showSnackBerMessage(resetPasswordController.errorMessage!, true);
    }
  }
}
