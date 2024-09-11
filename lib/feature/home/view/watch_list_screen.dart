import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/feature/home/view/movie_details/movie_details_screen.dart';
import 'package:movie_app/feature/home/view_model/home_cubit.dart';
import 'package:movie_app/utils/app_colors/app_colors.dart';
import 'package:movie_app/utils/app_images/app_images.dart';
import 'package:movie_app/utils/constants/constants.dart';

class WatchListScreen extends StatelessWidget {
  const WatchListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getWatchList(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          if (state is GetMoviesWatchListLoadingState) {
            return const Center(child: CircularProgressIndicator(color: AppColors.yellowColor,));
          }
          if (state is GetMoviesWatchListSuccessState && cubit.watchListModel!.results!.isEmpty) {
            return  Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.25,
                ),
                Image.asset(
                  AppImages.nothing,
                  height: MediaQuery.sizeOf(context).height * 0.2,
                ),
                Text(
                  'No movies Found',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: Colors.white.withOpacity(0.67),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            );
          }
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 17.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Watchlist',
                    style: GoogleFonts.poppins(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => Column(
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          const Divider(),
                          SizedBox(
                            height: 10.h,
                          ),
                        ],
                      ),
                      itemCount:
                      cubit.watchListModel?.results?.length ?? 0,
                      itemBuilder: (context, index) => Row(
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.pushNamed(
                                context,
                                MovieDetailsScreen.routeName,
                                arguments: cubit.watchListModel?.results?[index].id,
                              );
                            },
                            child: Container(
                                alignment: Alignment.topLeft,
                                width: MediaQuery.of(context).size.width *
                                    0.33,
                                height: MediaQuery.of(context).size.height *
                                    0.195,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      '${Constants.imageBaseUrl}${cubit.watchListModel?.results?[index].posterPath ?? ''}',
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    // debugPrint(cubit.getWatchListModel
                                    //     ?.results?[index].id.toString(),);
                                    cubit.addToWatchList(
                                      id: cubit.watchListModel
                                          ?.results?[index].id,
                                      isWatchList: false,
                                    );
                                  },
                                  child: Container(
                                    height: MediaQuery.sizeOf(context).height * 0.05,
                                    decoration: const BoxDecoration(
                                      color: Colors.transparent,
                                      image: DecorationImage(
                                        image: AssetImage(
                                          AppImages.wishList,
                                        ),
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    ),
                                  ),
                                )),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cubit.watchListModel?.results?[index]
                                      .title ??
                                      '',
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  maxLines: 2,
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                  cubit.watchListModel?.results?[index]
                                      .releaseDate ??
                                      '',
                                  style: GoogleFonts.inter(
                                    color: AppColors.secondaryColor,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                  cubit.watchListModel?.results?[index]
                                      .popularity
                                      .toString() ??
                                      '',
                                  style: GoogleFonts.inter(
                                    color: AppColors.secondaryColor,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
