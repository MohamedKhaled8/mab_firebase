import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:working/core/functions/validator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:working/core/widgets/custom_button_local.dart';
import 'package:working/controller/login_controller/login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final LoginController _loginControllerWork = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: GetBuilder<LoginController>(
          builder: (_) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Column(
                children: [
                  Center(child: Image.asset("assets/images/png/infinty.png")),
                  SizedBox(height: 20.h),
                  Form(
                      key: _loginControllerWork.formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (val) {
                              return validInput(val!, 5, 30, "phone");
                            },
                            controller: _loginControllerWork.phoneController,
                            // onSaved: (value) => controller.phone = value,
                            decoration:
                                const InputDecoration(hintText: 'Phone'),
                          ),
                          SizedBox(height: 20.h),
                          TextFormField(
                            validator: (val) {
                              return validInput(val!, 5, 30, "password");
                            },
                            controller: _loginControllerWork.passwordController,
                            // onSaved: (value) => controller.password = value,
                            decoration:
                                const InputDecoration(hintText: 'Password'),
                          ),
                        ],
                      )),
                  SizedBox(height: 20.h),
                  CustomButtonLocal(
                    onTap: () async {
                      if (_loginControllerWork.formKey.currentState!
                          .validate()) {
                        await _loginControllerWork.login(
                            phone: _loginControllerWork.phoneController.text,
                            password:
                                _loginControllerWork.passwordController.text);
                      }
                    },
                    higth: 50,
                    width: 310,
                    text: 'Log in Work',
                    colorText: Colors.white,
                    size: 22.sp,
                    colorButtom: Colors.blue,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
