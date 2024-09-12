import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/feature/home/view/movie_details/movie_details_screen.dart';
import 'package:movie_app/feature/home/view_model/home_cubit.dart';
import 'package:movie_app/utils/app_colors/app_colors.dart';
import 'package:movie_app/utils/app_images/app_images.dart';
import 'package:movie_app/utils/constants/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomPopularWidget extends StatefulWidget {
  const CustomPopularWidget({super.key});

  @override
  State<CustomPopularWidget> createState() => _CustomPopularWidgetState();
}

class _CustomPopularWidgetState extends State<CustomPopularWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        if (cubit.popularMoviesModel == null) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.yellowColor,
            ),
          );
        }
        return CarouselSlider(
          options: CarouselOptions(
            height: MediaQuery.sizeOf(context).height * 0.45,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 1
          ),
          items: cubit.popularMoviesModel?.results?.map((movie) {
            return Builder(
              builder: (BuildContext context) {
                final isInWatchlist = cubit
                    .watchListModel?.results
                    ?.any((e) => e.id == movie?.id) ??
                    false;
                return Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          MovieDetailsScreen.routeName,
                          arguments: movie.id,
                        );
                      },
                      child: AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        height: MediaQuery.sizeOf(context).height * 0.3,
                        width: double.infinity,
                        // Set width to full
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              '${Constants.imageBaseUrl}${movie.backdropPath}'
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            radius: 25.r,
                            backgroundColor: Colors.black54,
                            child: Icon(
                              Icons.play_arrow,
                              size: 20.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.sizeOf(context).height * 0.22,
                      left: MediaQuery.sizeOf(context).width * 0.07,
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.sizeOf(context).width * 0.26,
                            height: MediaQuery.sizeOf(context).height * 0.21,
                            alignment: Alignment.topRight,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.25),
                                  spreadRadius: 3,
                                  blurRadius: 2,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(15.r),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  '${Constants.imageBaseUrl}${movie.posterPath}',
                                ),
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                cubit.addToWatchList(
                                  isWatchList:(cubit.watchListModel?.results?.any((e) => e.id == movie.id) ?? false) ? false : true,
                                  id: movie.id,
                                );
                                // context.read<WatchListCubit>().addToWatchList({
                                //   'id': movie.id,
                                //   'title': movie.title,
                                //   'backdropPath': movie.backdropPath,
                                //   'posterPath': movie.posterPath,
                                //   'releaseDate': movie.releaseDate,
                                // });
                                //
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //   SnackBar(
                                //     content: Text('${movie.title} added to watchlist!'),
                                //   ),
                                // );
                              },
                              child: Container(
                                height: MediaQuery.sizeOf(context).height * 0.05,
                                decoration:  BoxDecoration(
                                  color: Colors.transparent,
                                  image: DecorationImage(
                                    image: AssetImage(
                                      isInWatchlist? AppImages.wishList:AppImages.bookmark,
                                    ),
                                  ),
                                ),
                                child:  Icon(
                                  isInWatchlist?Icons.check:Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            ),

                          ),
                          SizedBox(width: 8.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 40.h),
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width * 0.5,
                                child: DefaultTextStyle(
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  child: AnimatedTextKit(
                                    isRepeatingAnimation: true,
                                    repeatForever: true,
                                    // pause: const Duration(seconds: 2),
                                    animatedTexts: [
                                      TyperAnimatedText(movie.title ?? ''),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 6.h),
                              Text(
                                movie.releaseDate?.substring(0, 4) ?? '',
                                style: GoogleFonts.inter(
                                  color: Colors.grey,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                                  ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                InkWell(
                                  onTap: () async {
                                    await cubit.getMovieTrailer(movie.id
                                        .toString()); // Ensure this finishes first
                                    if (cubit.movieTrailerModel?.results
                                        ?.isNotEmpty ??
                                        false) {
                                      final trailerKey = cubit
                                          .movieTrailerModel?.results?[0].key;
                                      if (trailerKey != null) {
                                        Uri uri = Uri.parse(
                                            'https://youtu.be/$trailerKey');
                                        if (await canLaunchUrl(uri)) {
                                          await launchUrl(uri);
                                        } else {
                                          // Handle error if the URL cannot be launched
                                          debugPrint('Could not launch $uri');
                                        }
                                      } else {
                                        debugPrint('Trailer key is null');
                                      }
                                    } else {
                                      debugPrint(
                                          'No trailer available for this movie');
                                    }
                                  },
                                  child: Container(
                                    width: MediaQuery
                                        .sizeOf(context)
                                        .width *
                                        0.3,
                                    height:
                                    MediaQuery
                                        .sizeOf(context)
                                        .height *
                                        0.038,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: AppColors.yellowColor,
                                      borderRadius:
                                      BorderRadius.circular(5.r),
                                    ),
                                    child: Text(
                                      'Watch Now',
                                      style: GoogleFonts.inter(
                                        color: Colors.white,
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          }).toList(),
        );
      },
    );
  }
}
