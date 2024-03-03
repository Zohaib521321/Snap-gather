import 'package:event_management/ViewModel/AppStrings/app_colors.dart';
import 'package:event_management/ViewModel/AppStrings/image_path.dart';
import 'package:event_management/ViewModel/Controllers/Auth/pin_code_controller.dart';
import 'package:event_management/ViewModel/Widgets/Button/primary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyScreen extends StatelessWidget {
  final int initialRandomNumber;
  final String email;
  final String password;
  VerifyScreen({
    Key? key,
    required this.initialRandomNumber,
    required this.email,
    required this.password,
  }) : super(key: key) {
    // Initialize the controller once
    Get.put(VerifyController(initialRandomNumber: initialRandomNumber));
  }

  @override
  Widget build(BuildContext context) {
    final verifyController = Get.find<VerifyController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pin Code"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PinCodeTextField(
              appContext: context,
              length: 4,
              controller: verifyController.textEditingController,
              cursorColor: Colors.deepPurple,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                verifyController.handlePinCodeChange(email, password);
              },
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(8),
                fieldHeight: 60,
                fieldWidth: 60,
                activeColor: Colors.purple,
                activeFillColor: Colors.purple.withOpacity(0.1),
                inactiveColor: Colors.grey,
                inactiveFillColor: Colors.purple.withOpacity(0.1),
                selectedColor: Colors.purple,
                selectedFillColor: Colors.purple.withOpacity(0.1),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Choose another email?",
                style: TextStyle(color: Colors.blue, fontSize: 17),
              ),
            ),
            const SizedBox(height: 20),
            Obx(
              () => verifyController.isResendClickable.value
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Did not get the code? ',
                          style: TextStyle(fontSize: 16),
                        ),
                        InkWell(
                          onTap: () {
                            verifyController.resendCode(email);
                          },
                          child: Text(
                            'Resend',
                            style: TextStyle(
                              fontSize: 16,
                              color: verifyController.isResendClickable.value
                                  ? Colors.blue
                                  : Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(),
            ),
            const SizedBox(height: 20),
            Obx(
              () => verifyController.loading.value
                  ? const Center(
                      child: CircularProgressIndicator(
                      color: ColorUtils.blueShade,
                      backgroundColor: ColorUtils.redShade,
                    ))
                  : PrimaryButton(
                      onPressed: () {
                        verifyController.handleVerifyButton(email, password);
                      },
                      title: "Verify",
                      imagePath: ImagePathUtils.verify,
                      color: ColorUtils.blueShade,
                    ),
            )
          ],
        ),
      ),
    );
  }
}
