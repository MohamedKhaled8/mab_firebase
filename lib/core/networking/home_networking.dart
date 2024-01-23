import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:working/core/helper/dio_helper.dart';
import 'package:working/core/constant/api_end_poit.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:working/features/home_view/data/model/get_markers.dart';

class HomeNetworking {
  final DioHelper dioHelper;
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  HomeNetworking(this.dioHelper);

  Future<List<GetMarkerModel>> getMarker(
    Map<String, dynamic> json, {
    required body,
  }) async {
    String token = await getToken();

    Response response = await dioHelper.post(
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': Headers.formUrlEncodedContentType,
      },
      body: body,
      url: EndPointName.getMarkers,
      contentType: Headers.formUrlEncodedContentType,
    );

    final responseData = jsonDecode(response.data);

    return List<GetMarkerModel>.from(
      responseData.map((item) => GetMarkerModel.fromJson(item as Map<String, dynamic>))
    );
  }

  Future<String> getToken() async {
    String? token = await secureStorage.read(key: 'UserToken');
    return token ?? '';
  }
}
