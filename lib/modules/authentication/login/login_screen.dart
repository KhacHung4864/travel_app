import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travel_app/configs/app_fonts.dart';
import 'package:travel_app/configs/palette.dart';
import 'package:travel_app/constants/validator.dart';
import 'package:travel_app/gen/assets.gen.dart';
import 'package:travel_app/modules/authentication/login/login_controller.dart';
import 'package:travel_app/modules/authentication/widget/text_form_field_widget.dart';
import 'package:travel_app/routes/app_pages.dart';
import 'package:travel_app/utils/share_components/dialog/toast.dart';

class LoginScreen extends GetView<LoginController> {
  LoginScreen({super.key});
  final formKey = GlobalKey<FormState>();

  void submit() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid || controller.emailController.text.trim().isEmpty && controller.passwordController.text.trim().isEmpty) {
      return;
    }
    controller.loginUser(data: {
      'email': controller.emailController.text.trim(),
      'password': controller.passwordController.text.trim(),
    });
    formKey.currentState!.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Text('Sign in now', style: AppFont.t.s(26).w600),

                  const SizedBox(height: 12),
                  Text('Please sign in to continue our app', style: AppFont.t.s(16).black7C838D),

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

                              const SizedBox(height: 16),

                              //password
                              TextFormFieldWidget(
                                title: 'Password',
                                controller: controller.passwordController,
                                icon: Icons.vpn_key_sharp,
                                validator: (value) {
                                  if (value == null || value.trim().length < 3) {
                                    return 'Password must be at least 6 characters long';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.toNamed(Routes.forgot);
                                    },
                                    child: Text(
                                      'Forget Password?',
                                      style: AppFont.t.s(14).w500.blueFF0D6EFD,
                                    ),
                                  ),
                                ],
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
                                      submit();
                                    },
                                    child: Center(
                                      child: Text(
                                        'Sign In',
                                        style: AppFont.t.s(16).w400.white,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an Account?", style: AppFont.t.s(14).w400.black7C838D),
                            TextButton(
                                onPressed: () {
                                  Get.toNamed(Routes.signUp);
                                },
                                child: Text(
                                  'Sign up',
                                  style: AppFont.t.s(14).w500.blueFF0D6EFD,
                                ))
                          ],
                        ),

                        Text("Or connect", style: AppFont.t.s(14).w400.black7C838D),

                        const SizedBox(height: 100),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                ToastUtil.showText("The feature will be updated in the next version.");
                              },
                              child: SizedBox(
                                height: 44,
                                child: Assets.images.fbIcon.image(),
                              ),
                            ),
                            SizedBox(width: 24.w),
                            InkWell(
                              onTap: controller.handleGoogleSignIn,
                              child: SizedBox(
                                height: 44,
                                child: Assets.images.googleIcon.image(),
                              ),
                            ),
                          ],
                        ),
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
