import 'package:flutter/material.dart';
import 'package:task_manager_with_getx/ui/controllers/forgot_password_otp_controller.dart';
import 'package:task_manager_with_getx/ui/screens/reset_password_screen.dart';
import 'package:task_manager_with_getx/ui/screens/sign_in_screen.dart';
import 'package:task_manager_with_getx/ui/utils/app_colors.dart';
import 'package:task_manager_with_getx/ui/widgets/background_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_with_getx/ui/widgets/centerted_circular_progress_indicator.dart';
import 'package:task_manager_with_getx/ui/widgets/snackber_message.dart';
import 'package:get/get.dart';

class ForgotPasswordOtpScreen extends StatefulWidget {
  static const String name = '/forgot-password-otp-screen';

  const ForgotPasswordOtpScreen({
    super.key,
  });

  // final String email;

  @override
  State<ForgotPasswordOtpScreen> createState() =>
      _ForgotPasswordOtpScreenState();
}

class _ForgotPasswordOtpScreenState extends State<ForgotPasswordOtpScreen> {
  final TextEditingController _pinTEController = TextEditingController();
  final ForgotPasswordOTPController forgotPasswordOTPController =
      Get.find<ForgotPasswordOTPController>();
  String? otp;
  String? email;

  @override
  void initState() {
    super.initState();
    final Map<String, String>? args = Get.arguments;
    email = args?['email'] ?? '';
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 82),
                Text(
                  'Pin Verification',
                  style: textTheme.displaySmall
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                Text(
                  'A 6 digit verification pin has send to your email address',
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
    return Column(
      children: [
        PinCodeTextField(
          length: 6,
          obscureText: false,
          animationType: AnimationType.fade,
          keyboardType: TextInputType.number,
          pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(5),
              fieldHeight: 50,
              fieldWidth: 40,
              activeFillColor: Colors.white,
              inactiveFillColor: Colors.white),
          animationDuration: const Duration(milliseconds: 300),
          backgroundColor: Colors.white,
          enableActiveFill: true,
          appContext: context,
          controller: _pinTEController,
          onCompleted: (v) => print("Completed"),
          onChanged: (value) {
            setState(() {
              otp = value;
            });
          },
        ),
        const SizedBox(height: 24),
        GetBuilder<ForgotPasswordOTPController>(builder: (controller) {
          return Visibility(
            visible: controller.pinVerificationInProgress == false,
            replacement: const CenterCircularProgressIndicator(),
            child: ElevatedButton(
              onPressed: _onTabNextButton,
              child: const Text(
                'Verify',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildSignInSection() {
    return Center(
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 14,
              wordSpacing: 4),
          text: "Have Account?",
          children: [
            TextSpan(
              text: ' Sign In',
              style: const TextStyle(color: AppColor.themeColor),
              recognizer: TapGestureRecognizer()..onTap = _onTapSignIn,
              // Note: This sets up a gesture recognizer for the "Sign Up" text.
            ),
          ],
        ),
      ),
    );
  }

  void _onTabNextButton() {
    _pinVerification();
  }

  void _onTapSignIn() {
    Get.offNamedUntil(
      SignInScreen.name,
      (route) => false,
    );
  }

  Future<void> _pinVerification() async {
    final bool result =
        await forgotPasswordOTPController.pinVerification(email!, otp!);
    if (result) {
      Get.toNamed(ResetPasswordScreen.name,
          arguments: {'email': email, 'otp': otp});

      showSnackBerMessage('Otp Verified');
    } else {
      showSnackBerMessage(forgotPasswordOTPController.errorMessage!, true);
    }
  }
}
