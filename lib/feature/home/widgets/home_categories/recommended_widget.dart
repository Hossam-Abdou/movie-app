import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/feature/home/view_model/home_cubit.dart';
import 'package:movie_app/utils/app_colors/app_colors.dart';
import 'package:movie_app/utils/app_images/app_images.dart';
import 'package:movie_app/utils/components/custom_rate.dart';
import 'package:movie_app/utils/components/custom_wish_list_container.dart';
import '../../../movie_details/presentation/pages/details_screen.dart';
import '../../../watch_listt/cubit/watch_list_cubit.dart';

class RecommendedWidget extends StatelessWidget {
  const RecommendedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var homeCubit = HomeCubit.get(context);
        if (homeCubit.topRatedModel == null) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.yellowColor,
            ),
          );
        }

        return Container(
          height: MediaQuery.of(context).size.height * 0.46,
          color: AppColors.greyColor,
          child: Padding(
            padding: EdgeInsets.all(12.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Recommended',
                  style: GoogleFonts.poppins(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: homeCubit.topRatedModel?.results?.length ?? 0,
                    itemBuilder: (context, index) {
                      final movie = homeCubit.topRatedModel?.results?[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            DetailsScreen.id,
                            arguments: movie?.id,
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomWishListContainer(
                              firstImage: '${movie?.posterPath}',
                              secondImage: AppImages.bookmark,
                              onTap: () {
                                context.read<WatchListCubit>().addToWatchList({
                                  'id': movie?.id,
                                  'title': movie?.title,
                                  'backdropPath': movie?.backdropPath,
                                  'posterPath': movie?.posterPath,
                                  'releaseDate': movie?.releaseDate,
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${movie?.title} added to watchlist!'),
                                  ),
                                );
                              },
                            ),
                            CustomRate(rate: movie?.voteAverage.toString(),),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.36,
                              child: Text(
                                movie?.title ?? '',
                                style: GoogleFonts.poppins(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Text(
                              '${movie?.releaseDate?.substring(0, 4)}',
                              style: GoogleFonts.poppins(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}