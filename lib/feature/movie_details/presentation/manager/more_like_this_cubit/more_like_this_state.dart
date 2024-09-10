import '../../../../category/model/category_movie_model.dart';

class MoreLikeThisState {}

class MoreLikeThisStateInitial extends MoreLikeThisState {}
class MoreLikeThisStateSuccess extends MoreLikeThisState {
  final List<Results> movies;

  MoreLikeThisStateSuccess({required this.movies});

}
class MoreLikeThisStateLoading extends MoreLikeThisState {}
class MoreLikeThisStateFailure extends MoreLikeThisState {
  final String error;

  MoreLikeThisStateFailure({required this.error});

}