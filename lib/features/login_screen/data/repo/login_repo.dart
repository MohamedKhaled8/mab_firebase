import 'package:dartz/dartz.dart';
import '../model/user_login_model.dart';
import '../../../../core/error/login_failure.dart';


abstract class AuthLoginRepo {
Future<Either<Failure, LoginUserModel>> loginPost({
    required LoginUserModel loginUserModel,
    required body,
  });
}