import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/feature/home/view_model/home_cubit.dart';
import 'package:movie_app/feature/home/widgets/home_categories/custom_popular_widget.dart';
import 'package:movie_app/feature/home/widgets/home_categories/new_release_widget.dart';
import 'package:movie_app/feature/home/widgets/home_categories/recommended_widget.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = 'home';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()
        ..getWatchList()
        ..getNewReleasesMovies()
        ..getRecommendedMovies()
        ..getPopularMovies(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
               const CustomPopularWidget(),
               const NewReleaseWidget(),
                SizedBox(
                  height: 30.h,
                ),
               const RecommendedWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
