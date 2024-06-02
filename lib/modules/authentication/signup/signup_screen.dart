import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travel_app/configs/app_fonts.dart';
import 'package:travel_app/configs/constants/validator.dart';
import 'package:travel_app/configs/palette.dart';
import 'package:travel_app/gen/assets.gen.dart';
import 'package:travel_app/modules/authentication/signup/signup_controller.dart';
import 'package:travel_app/modules/authentication/widget/text_form_field_widget.dart';
import 'package:travel_app/utils/share_components/dialog/toast.dart';

class SignUpScreen extends GetView<SignUpController> {
  const SignUpScreen({super.key});

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
                  const SizedBox(height: 100),
                  Text('Sign up now', style: AppFont.t.s(26).w600),

                  const SizedBox(height: 12),
                  Text('Please fill the details and create account', style: AppFont.t.s(16).black7C838D),

                  const SizedBox(height: 40),
                  //login screen sign-in form
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      children: [
                        //email-pasword-login-btn
                        Form(
                          key: controller.formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //email

                              TextFormFieldWidget(
                                title: 'Name',
                                controller: controller.nameController,
                                icon: Icons.person,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Please enter a valid name.';
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: 24),

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

                              const SizedBox(height: 24),

                              //password
                              TextFormFieldWidget(
                                title: 'Password',
                                isPassword: true,
                                controller: controller.passwordController,
                                icon: Icons.vpn_key_sharp,
                                validator: (value) {
                                  if (value == null || value.trim().length < 4) {
                                    return 'Password must be at least 4 characters long';
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: 16),
                              Text("Password must be 8 character", style: AppFont.t.s(14).w400.black7C838D),

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
                                    onTap: controller.submit,
                                    child: Center(
                                      child: Text(
                                        'Sign Up',
                                        style: AppFont.t.s(16).w400.white,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        //dont have an account btn
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an account", style: AppFont.t.s(14).w400.black7C838D),
                            TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text(
                                  'Sign in',
                                  style: AppFont.t.s(14).w500.blueFF0D6EFD,
                                ))
                          ],
                        ),

                        Text("Or connect", style: AppFont.t.s(14).w400.black7C838D),

                        const SizedBox(height: 40),
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
                            const SizedBox(width: 24),
                            InkWell(
                              child: SizedBox(
                                height: 44,
                                child: Assets.images.googleIcon.image(),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 50)
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
