import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movie_app/utils/constants/constants.dart';

import '../../../../../utils/dio/dio_helper.dart';
import '../../../../../utils/failure/failure.dart';
import '../../../../category/model/category_movie_model.dart';
import 'get_trailer_repo.dart';

class GetTrailerRepoImp implements GetTrailerRepo{
  @override
  Future<Either<Failure, Results>> getTrailerMovie({required int id}) async {
    try {
      Response response = await DioHelper.getData(
          endPoint: "movie/$id/videos", token: Constants.apiKey);
      Map<String, dynamic>data = response.data;
      List<Results>trailer=[];
      for(var item in data["results"])
      {
        trailer.add(Results.fromJson(item));
      }
      return right(trailer[0]);
    }catch(e) {
      if(e is DioException)
      {
        return Left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

}