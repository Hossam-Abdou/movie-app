import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movie_app/utils/constants/constants.dart';
import '../../../../../utils/dio/dio_helper.dart';
import '../../../../../utils/failure/failure.dart';
import '../../../../category/model/category_movie_model.dart';
import 'more_like_this_repo.dart';

class MoreLikeThisRepoImp implements MoreLikeThisRepo{
  @override
  Future<Either<Failure, List<Results>>> getMoreLikeThisMovies({required int id}) async {
    try {
      Response response = await DioHelper.getData(
          endPoint: 'movie/$id/similar', token: Constants.apiKey);
      Map<String, dynamic>data = response.data;
      List<Results> movies = [];
      for (var item in data["results"]) {
        movies.add(Results.fromJson(item));
      }
      return Right(movies);
    }catch(e) {
      if(e is DioException)
      {
        return Left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

}