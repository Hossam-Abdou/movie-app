part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class NewReleaseLoadingState extends HomeState {}
final class NewReleaseSuccessState extends HomeState {}
final class NewReleaseErrorState extends HomeState {}

final class TopRatedLoadingState extends HomeState {}
final class TopRatedSuccessState extends HomeState {}
final class TopRatedErrorState extends HomeState {}

final class PopularLoadingState extends HomeState {}
final class PopularSuccessState extends HomeState {}
final class PopularErrorState extends HomeState {}

final class GetMoviesGenresLoadingState extends HomeState {}
final class GetMoviesGenresSuccessState extends HomeState {}
final class GetMoviesGenresErrorState extends HomeState {}

final class SearchMovieLoadingState extends HomeState {}
final class SearchMovieSuccessState extends HomeState {}
final class SearchMovieErrorState extends HomeState {}
