import 'package:dartz/dartz.dart';

import '../../../../../utils/failure/failure.dart';
import '../../../../category/model/category_movie_model.dart';

abstract class GetTrailerRepo {
  Future<Either<Failure,Results>>getTrailerMovie({required int id});

}