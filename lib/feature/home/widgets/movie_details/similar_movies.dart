import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/feature/home/view/movie_details/movie_details_screen.dart';
import 'package:movie_app/feature/home/view_model/home_cubit.dart';
import 'package:movie_app/utils/app_colors/app_colors.dart';
import 'package:movie_app/utils/constants/constants.dart';

class SimilarMovies extends StatelessWidget {
  final int id;

  const SimilarMovies({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getSimilarMovie(id),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return Container(
            height: MediaQuery.sizeOf(context).height * 0.37,
            padding: EdgeInsets.all(5.r),
            color: AppColors.greyColor,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: cubit.similarMoviesModel?.results?.length ?? 0,
              separatorBuilder: (context, index) => SizedBox(
                width: 12.w,
              ),
              itemBuilder: (context, index) {
                if (state is GetSimilarMovieSuccessState &&
                    cubit.similarMoviesModel!.results!.isEmpty) {
                  return Text(
                    'NO Similar Movies Found',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 15.sp,
                    ),
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              MovieDetailsScreen.routeName,
                              arguments:
                                  cubit.similarMoviesModel?.results?[index].id,
                            );
                          },
                          child: CachedNetworkImage(
                            placeholder: (context, text) => const Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.yellowColor,
                                )),
                            errorWidget: (context, url, error) => Container(
                              width: MediaQuery.of(context).size.width * 0.42,
                              height: MediaQuery.of(context).size.height * 0.25,

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    'https://img.freepik.com/premium-vector/modern-design-concept-no-image-found-design_637684-247.jpg',
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            imageUrl:
                                '${Constants.imageBaseUrl}${cubit.similarMoviesModel?.results?[index].posterPath}',
                            imageBuilder: (context, imageProvider) => Container(
                              alignment: Alignment.topLeft,
                              width: MediaQuery.of(context).size.width * 0.42,
                              height: MediaQuery.of(context).size.height * 0.25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      '${Constants.imageBaseUrl}${cubit.similarMoviesModel?.results?[index].posterPath}'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: Container(
                                height:
                                    MediaQuery.sizeOf(context).height * 0.05,
                                decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/bookmark.png',
                                    ),
                                  ),
                                ),
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          const ImageIcon(
                            AssetImage('assets/images/star.png'),
                            color: Color(0xffFFBB3B),
                          ),
                          // Icon(Icons.star,color: Colors.yellow,),
                          Text(
                            cubit.similarMoviesModel?.results?[index]
                                    .voteAverage
                                    .toString() ??
                                '',
                            style: GoogleFonts.poppins(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        cubit.similarMoviesModel?.results?[index].title ?? '',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      '2018  R  1h 59m',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
