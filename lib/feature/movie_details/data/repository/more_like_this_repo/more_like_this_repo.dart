import 'package:dartz/dartz.dart';

import '../../../../../utils/failure/failure.dart';
import '../../../../category/model/category_movie_model.dart';

abstract class MoreLikeThisRepo {
  Future<Either<Failure,List<Results>>>getMoreLikeThisMovies({required int id});

}