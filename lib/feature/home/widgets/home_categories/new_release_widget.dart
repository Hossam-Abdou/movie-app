import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/feature/home/view_model/home_cubit.dart';
import 'package:movie_app/utils/app_colors/app_colors.dart';
import 'package:movie_app/utils/app_images/app_images.dart';
import 'package:movie_app/utils/constants/constants.dart';
import '../../../movie_details/presentation/pages/details_screen.dart';
import '../../../watch_listt/cubit/watch_list_cubit.dart';

class NewReleaseWidget extends StatelessWidget {
  const NewReleaseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is NewReleaseLoadingState) {
          const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
      builder: (context, state) {
        var homeCubit = HomeCubit.get(context);
        if (homeCubit.newReleaseModel == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Container(
          height: MediaQuery.of(context).size.height * 0.32,
          color: AppColors.greyColor,
          child: Padding(
            padding: EdgeInsets.all(12.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'New Releases',
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
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) => SizedBox(
                      width: 8.w,
                    ),
                    itemCount: homeCubit.newReleaseModel?.results?.length ?? 0,
                    itemBuilder: (context, index) {
                      final movie = homeCubit.newReleaseModel?.results?[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    DetailsScreen.id,
                                    arguments: movie?.id,
                                  );
                                },
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  width: MediaQuery.sizeOf(context).width * 0.27,
                                  height: MediaQuery.sizeOf(context).height * 0.22,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        '${Constants.imageBaseUrl}${movie?.posterPath}',
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  child: InkWell(
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
                                    child: Container(
                                      height: MediaQuery.of(context).size.height * 0.05,
                                      decoration: const BoxDecoration(
                                        color: Colors.transparent,
                                        image: DecorationImage(
                                          image: AssetImage(AppImages.bookmark),
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
                        ],
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