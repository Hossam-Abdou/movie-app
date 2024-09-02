import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/feature/home/model/GetWatchListModel.dart';
import 'package:movie_app/feature/home/model/MoviesDetailsModel.dart';
import 'package:movie_app/feature/home/model/NewReleaseModel.dart';
import 'package:movie_app/feature/home/model/PopularMoviesModel.dart';
import 'package:movie_app/feature/home/model/SearchModel.dart';
import 'package:movie_app/feature/home/model/SimilarMoviesModel.dart';
import 'package:movie_app/feature/home/model/TopRatedModel.dart';
import 'package:movie_app/utils/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/utils/end_points/end_points.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);
  NewReleaseModel? newReleaseModel;
  TopRatedModel? topRatedModel;
  PopularMoviesModel? popularMoviesModel;
  MoviesDetailsModel? moviesDetailsModel;
  SimilarMoviesModel? similarMoviesModel;
  WatchListModel? watchListModel;
  SearchModel? searchModel;



  getPopularMovies() async {
    emit(PopularLoadingState());
    Uri uri = Uri.https(
      EndPoints.baseUrl,
      EndPoints.popular,
      {
        'language': 'en',
      },
    );

    try {
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer ${Constants.apiKey}',
        'Accept': 'application/json',
      });

      if (response.statusCode == 200) {
        popularMoviesModel = PopularMoviesModel.fromJson(
          jsonDecode(response.body),
        );
        emit(PopularSuccessState());
      } else {
        emit(PopularErrorState());
      }
    } catch (error) {
      emit(PopularErrorState());
    }
  }
  getNewReleasesMovies() async {
    emit(NewReleaseLoadingState());
    Uri uri = Uri.https(
      EndPoints.baseUrl,
      EndPoints.upcomingMovies,
      {
        'language': 'en',
      },
    );

    try {
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer ${Constants.apiKey}',
        'Accept': 'application/json',
      });

      if (response.statusCode == 200) {
        newReleaseModel = NewReleaseModel.fromJson(
          jsonDecode(response.body),
        );
        emit(NewReleaseSuccessState());
      } else {
        emit(NewReleaseErrorState());
      }
    } catch (error) {
      emit(NewReleaseErrorState());
    }
  }

  getRecommendedMovies() async {
    emit(TopRatedLoadingState());
    Uri uri = Uri.https(
      EndPoints.baseUrl,
      EndPoints.topRated,
      {
        'language': 'en',
      },
    );

    try {
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer ${Constants.apiKey}',
        'Accept': 'application/json',
      });

      if (response.statusCode == 200) {
        topRatedModel = TopRatedModel.fromJson(
          jsonDecode(response.body),
        );
        emit(TopRatedSuccessState());
      } else {
        emit(TopRatedErrorState());
      }
    } catch (error) {
      emit(TopRatedErrorState());
    }
  }


  searchMovies(String query) async {
    emit(SearchMovieLoadingState());
    Uri uri = Uri.https(
      EndPoints.baseUrl,
      EndPoints.searchMovie,
      {
        'language': 'en',
        'query': query,

      },
    );

    try {
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer ${Constants.apiKey}',
        'Accept': 'application/json',
      });

      if (response.statusCode == 200) {
        searchModel = SearchModel.fromJson(
          jsonDecode(response.body),
        );
        emit(SearchMovieSuccessState());
      } else {
        emit(SearchMovieErrorState());
      }
    } catch (error) {
      emit(SearchMovieErrorState());
      debugPrint(error.toString());
      // print(error.toString());
    }
  }




}

