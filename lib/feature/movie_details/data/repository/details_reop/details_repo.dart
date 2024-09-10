
import 'package:dartz/dartz.dart';
import 'package:movie_app/feature/movie_details/data/models/details_model.dart';
import '../../../../../utils/failure/failure.dart';

abstract class DetailsRepo {
  Future<Either<Failure,DetailsModel>>getDetailsMovies({required int id});

}