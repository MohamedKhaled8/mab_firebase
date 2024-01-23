import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import '../../../../core/error/login_failure.dart';
import 'package:working/core/networking/home_networking.dart';
import 'package:working/features/home_view/data/model/get_markers.dart';
import 'package:working/features/home_view/data/repo/get_mrkers_repo.dart';

class HomeRepoImp extends HomeRepo {
  final HomeNetworking homeNetworking;

  HomeRepoImp(this.homeNetworking);

  @override
  Future<Either<Failure, List<GetMarkerModel>>> getMarkers({
    required GetMarkerModel getMarkerModel,
    required Map<String, dynamic> body,
  }) async {
    try {
      var response = await homeNetworking.getMarker(
        getMarkerModel.toJson(),
        body: body,
      );
      return right(response);
    } catch (e) {
      debugPrint('Error: $e');
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }
}
