import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movie_app/utils/constants/constants.dart';
import 'package:movie_app/utils/end_points/end_points.dart';
import '../../../../../utils/dio/dio_helper.dart';
import '../../../../../utils/failure/failure.dart';
import '../../models/details_model.dart';
import 'details_repo.dart';

class DetailsRepoImp implements DetailsRepo{
  @override
  Future<Either<Failure, DetailsModel>> getDetailsMovies({required int id}) async {
    try {
      Response response = await DioHelper.getData(
          endPoint: "movie/$id", token:Constants.apiKey);
      Map<String, dynamic>data = response.data;
      DetailsModel detailsModel=DetailsModel.fromJson(data);
      return right(detailsModel);
    }catch(e) {
      if(e is DioException)
      {
        return Left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

}