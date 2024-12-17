import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_with_getx/ui/controllers/forgot_password_email_controller.dart';
import 'package:task_manager_with_getx/ui/screens/forgot_password_otp_screen.dart';
import 'package:task_manager_with_getx/ui/screens/sign_in_screen.dart';
import 'package:task_manager_with_getx/ui/utils/app_colors.dart';
import 'package:task_manager_with_getx/ui/widgets/background_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:task_manager_with_getx/ui/widgets/centerted_circular_progress_indicator.dart';
import 'package:task_manager_with_getx/ui/widgets/snackber_message.dart';

class ForgotPasswordEmailScreen extends StatefulWidget {
  static const String name = '/forgot-password-email-screen';

  const ForgotPasswordEmailScreen({super.key});

  @override
  State<ForgotPasswordEmailScreen> createState() =>
      _ForgotPasswordEmailScreenState();
}

class _ForgotPasswordEmailScreenState extends State<ForgotPasswordEmailScreen> {
  final TextEditingController _emailTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ForgotPasswordEmailController forgotPasswordEmailController =
      Get.find<ForgotPasswordEmailController>();

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
                  'Your Email Address',
                  style: textTheme.displaySmall
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                Text(
                  'A 6 digit verification pin will send to your email address',
                  style: textTheme.titleSmall?.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 16),
                _buildEmailVerificationForm(),
                const SizedBox(height: 48),
                _buildSignInSection()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailVerificationForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailTEController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'Email',
              prefixIcon: Icon(Icons.email_outlined),
            ),
            validator: (String? value) {
              if (value?.isEmpty == true) {
                return 'Please enter your email';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          GetBuilder<ForgotPasswordEmailController>(builder: (controller) {
            return Visibility(
              visible: controller.forgetPasswordInProgress == false,
              replacement: const CenterCircularProgressIndicator(),
              child: ElevatedButton(
                onPressed: _onTabNextButton,
                child: const Text(
                  'Next',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
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
      if (isBasicEmailValid(_emailTEController.text) == true) {
        _sendOTPForEmailVerification();
      } else {
        showSnackBerMessage('Please enter valid email', true);
      }
    }
  }

  bool isBasicEmailValid(String email) {
    const pattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
    final regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  void _onTapSignIn() {
    Get.toNamed(SignInScreen.name);
  }

  Future<void> _sendOTPForEmailVerification() async {
    final bool result = await forgotPasswordEmailController
        .sendOTPForEmailVerification(_emailTEController.text);

    if (result) {
      showSnackBerMessage('A 6 digit OTP code sent to your email');
      Get.toNamed(ForgotPasswordOtpScreen.name,
          arguments: {'email': _emailTEController.text});
    } else {
      showSnackBerMessage(forgotPasswordEmailController.errorMessage!, true);
    }
  }
}
