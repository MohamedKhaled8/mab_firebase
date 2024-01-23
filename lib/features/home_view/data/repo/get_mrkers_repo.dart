import 'package:dartz/dartz.dart';
import '../../../../core/error/login_failure.dart';
import 'package:working/features/home_view/data/model/get_markers.dart';

abstract class HomeRepo {
  @override
  Future<Either<Failure, List<GetMarkerModel>>> getMarkers({
    required GetMarkerModel getMarkerModel,
    required Map<String, dynamic> body,
  });
}
