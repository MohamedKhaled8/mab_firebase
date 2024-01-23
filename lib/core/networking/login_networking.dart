import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:working/core/helper/dio_helper.dart';
import 'package:working/core/constant/api_end_poit.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:working/features/login_screen/data/model/user_login_model.dart';

class LoginNetworking {
  final DioHelper dioHelper;
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  LoginNetworking(this.dioHelper);

  Future<LoginUserModel> loginPost(
    Map<String, dynamic> json, {
    required body,
  }) async {
    Response response = await dioHelper.post(
      body: body,
      headers: {
        'Content-Type': Headers.formUrlEncodedContentType,
      },
      url: EndPointName.LOGIN,
      contentType: Headers.formUrlEncodedContentType,
    );

    final responseData = jsonDecode(response.data);

    // Assuming the token is in the response data under 'token' key
    if (responseData.containsKey('UserToken')) {
      String token = responseData['UserToken'];
      await secureStorage.write(key: 'UserToken', value: token);
      print("******** $token ###########");
    }
    print("******** MMMMMMMMMMM ###########");
    return LoginUserModel.fromJson(responseData);
  }
}
