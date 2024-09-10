import '../../../../category/model/category_movie_model.dart';

class GetTrailerState {}

class GetTrailerInitial extends GetTrailerState {}
class GetTrailerLoading extends GetTrailerState {}
class GetTrailerSuccess extends GetTrailerState {
  final Results trailer;

  GetTrailerSuccess({required this.trailer});
}
class GetTrailerFailure extends GetTrailerState {
  final String error;

  GetTrailerFailure({required this.error});
}