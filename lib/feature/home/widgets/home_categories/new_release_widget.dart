import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/feature/home/view/movie_details/movie_details_screen.dart';
import 'package:movie_app/feature/home/view_model/home_cubit.dart';
import 'package:movie_app/utils/app_colors/app_colors.dart';
import 'package:movie_app/utils/app_images/app_images.dart';
import 'package:movie_app/utils/constants/constants.dart';

class NewReleaseWidget extends StatelessWidget {
  const NewReleaseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(

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
                      final isInWatchlist = homeCubit
                          .watchListModel?.results
                          ?.any((e) => e.id == movie?.id) ??
                          false;
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
                                    arguments: movie?.id,
                                  );
                                },
                                child: Container(
                                    alignment: Alignment.topLeft,
                                    width: MediaQuery.sizeOf(context).width *
                                        0.28,
                                    height: MediaQuery.sizeOf(context).height *
                                        0.22,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          '${Constants.imageBaseUrl}${homeCubit.newReleaseModel?.results?[index].posterPath}',
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        homeCubit.addToWatchList(
                                          isWatchList:(homeCubit.watchListModel?.results?.any((e) => e.id == homeCubit.newReleaseModel
                                              ?.results?[index].id) ?? false) ? false : true,
                                          id: homeCubit.newReleaseModel
                                              ?.results?[index].id,
                                        );
                                      },
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          image: DecorationImage(
                                            image: AssetImage(
                                              isInWatchlist? AppImages.wishList:AppImages.bookmark,
                                            ),
                                          ),
                                        ),
                                        child:  Icon(
                                          (homeCubit.watchListModel?.results?.any((e) => e.id == homeCubit.newReleaseModel
                                              ?.results?[index].id) ?? false)?Icons.check:Icons.add,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )),
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
