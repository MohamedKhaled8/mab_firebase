import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:working/core/error/login_failure.dart';
import 'package:working/core/networking/login_networking.dart';
import 'package:working/features/login_screen/data/repo/login_repo.dart';
import 'package:working/features/login_screen/data/model/user_login_model.dart';

class LoginRepoImp extends AuthLoginRepo {
  final LoginNetworking loginNetworking;

  LoginRepoImp(this.loginNetworking);

  @override
  Future<Either<Failure, LoginUserModel>> loginPost({
    required LoginUserModel loginUserModel,
    required body,
  }) async {
    try {
      await loginNetworking.loginPost(
        loginUserModel.toJson(),
        body: body,
      );
      return right(loginUserModel);
    } catch (e) {
      debugPrint('Login network error: $e');
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }
}
