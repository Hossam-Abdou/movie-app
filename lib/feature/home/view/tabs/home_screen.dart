import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/feature/home/widgets/home_categories/custom_popular_widget.dart';
import 'package:movie_app/feature/home/widgets/home_categories/new_release_widget.dart';
import 'package:movie_app/feature/home/widgets/home_categories/recommended_widget.dart';


class HomeScreen extends StatelessWidget {
  static String routeName = 'home';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomPopularWidget(),
              const NewReleaseWidget(),
               SizedBox(
                height: 30.h,
              ),
              const RecommendedWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
