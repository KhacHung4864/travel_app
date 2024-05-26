import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travel_app/configs/palette.dart';
import 'package:travel_app/constants/validator.dart';
import 'package:travel_app/gen/assets.gen.dart';
import 'package:travel_app/modules/authentication/forgot/forgot_controller.dart';
import 'package:travel_app/modules/authentication/widget/text_form_field_widget.dart';

import '../../../configs/app_fonts.dart';

class ForgotScreen extends GetView<ForgotController> {
  ForgotScreen({super.key});
  final formKey = GlobalKey<FormState>();

  void submit(context) async {
    final isValid = formKey.currentState!.validate();
    if (!isValid || controller.emailController.text.trim().isEmpty) {
      return;
    }
    final bool isSuccess = await controller.forgotPassword(data: {
      "email": "travelix.bot@gmail.com",
      "receive_email": controller.emailController.text.trim(),
    });
    if (isSuccess == true) {
      showDialog(
        context: context,
        builder: (context) => Dialog(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 44,
                  child: Assets.images.forgot.image(),
                ),
                const SizedBox(height: 20),
                Text('Check your email', style: AppFont.t.s(18).w600),
                const SizedBox(height: 12),
                Text(
                  'We have sent a new password to your email',
                  style: AppFont.t.s(16).black7C838D,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    }

    formKey.currentState!.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(),
        centerTitle: true,
      ),
      backgroundColor: Palette.white,
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 90),
                  Text('Forgot password', style: AppFont.t.s(26).w600),

                  const SizedBox(height: 12),
                  Text(
                    'Enter your email account to reset your password',
                    style: AppFont.t.s(16).black7C838D,
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 40),
                  //login screen sign-in form
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      children: [
                        //email-pasword-login-btn
                        Form(
                          key: formKey,
                          child: Column(
                            children: [
                              //email
                              TextFormFieldWidget(
                                title: 'Email',
                                controller: controller.emailController,
                                icon: Icons.email,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty || ValidatorUlti.isEmail(value.trim())) {
                                    return 'Please enter a valid email address.';
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: 40),

                              //button
                              Container(
                                width: Get.width,
                                height: 56,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.sp),
                                  color: Palette.blueFF0D6EFD,
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    splashColor: Colors.white,
                                    borderRadius: BorderRadius.circular(16.sp),
                                    onTap: () {
                                      submit(context);
                                    },
                                    child: Center(
                                      child: Text(
                                        'Reset Password',
                                        style: AppFont.t.s(16).w500.white,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                        //dont have an account btn
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
