import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:working/core/routes/route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:working/features/login_screen/data/repo/login_repo_imp.dart';
import 'package:working/features/login_screen/data/model/user_login_model.dart';

class LoginController extends GetxController {
  final LoginRepoImp loginRepoImp;
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginController() : loginRepoImp = Get.find<LoginRepoImp>();

  Future<void> login({
    required String phone,
    required String password,
  }) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    try {
      final data = await loginRepoImp.loginPost(
        loginUserModel: LoginUserModel(),
        body: {'UserPhone': phone, 'Password': password},
      );

      data.fold(
        (l) => Get.snackbar('Error', l.errMessage),
        (r) async {
          await saveUserIdToFirebase();
          await saveUserPhoneNumber(phone);
          Get.snackbar('Success', 'Login Successful');
          Get.offAllNamed(Routes.home);
        },
      );
    } catch (e) {
      debugPrint('Login error: $e');
      Get.snackbar("Error", "Oops, there was an error: $e");
    }
  }

  Future<void> saveUserPhoneNumber(String phone) async {
    await FirebaseFirestore.instance
        .collection('userPhoneNumbers')
        .doc(phone)
        .set({
      'phone': phone,
    }, SetOptions(merge: true));
  }

  Future<void> saveUserIdToFirebase() async {
    var uuid = const Uuid();
    String uniqueId = uuid.v4();

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uniqueId)
        .set({'userId': uniqueId}, SetOptions(merge: true));
  }

  Future<String> getToken() async {
    String? token = await secureStorage.read(key: 'UserToken');
    return token ?? '';
  }

  Future<void> clearToken() async {
    await secureStorage.delete(key: 'UserToken');
  }

  @override
  void onClose() {
    phoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
