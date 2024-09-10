import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/utils/constants/constants.dart';
import 'package:movie_app/utils/end_points/end_points.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/app_images/app_images.dart';
import '../../../home/view/tabs/home_screen.dart';
import '../../data/repository/details_reop/details_repo_impl.dart';
import '../manager/details_cubit/details_cubit.dart';
import '../manager/details_cubit/details_state.dart';
import '../pages/trailer_screen.dart';

class DetailsSection extends StatelessWidget {
  const DetailsSection({
    super.key,
    required this.id,
  });
  final int id;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailsCubit(DetailsRepoImp())..getDetails(id: id),
      child: BlocConsumer<DetailsCubit, DetailsState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is DetailsSuccess) {
            var cub=state.model;
            return Stack(
              alignment: Alignment.bottomLeft,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    width: 412.w,
                    height: 689.h,
                    fit: BoxFit.cover,
                    imageUrl: "${Constants.imageBaseUrl}${state.model.backdropPath}",
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                      child: CircularProgressIndicator(
                          color: AppColors.yellowColor,
                          value: downloadProgress.progress),
                    ),
                    errorWidget: (context, url, error) =>
                    const Icon(Icons.error),
                  ),
                ),
                Container(
                  height: 703.h,
                  width: 412.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                      colors: [
                        Colors.transparent,
                        AppColors.primaryColor,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.05, 1],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text("${state.model.title}",
                            style: GoogleFonts.abrilFatface(
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "${state.model.releaseDate}",
                          style: GoogleFonts.poppins(fontSize: 13,color: Colors.grey),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5.w),
                            child: Stack(
                              children: [
                                CachedNetworkImage(
                                  width: 129.w,
                                  height: 199.h,
                                  fit: BoxFit.cover,
                                  imageUrl:
                                  "${Constants.imageBaseUrl}${state.model.posterPath}",
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                      Center(
                                        child: CircularProgressIndicator(
                                            color: AppColors.yellowColor,
                                            value: downloadProgress.progress),
                                      ),
                                  errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 11.w),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 30.h,
                                  child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      physics: const BouncingScrollPhysics(),
                                      itemBuilder: (context, index) =>
                                          GestureDetector(
                                            onTap:(){},
                                            child: Container(
                                              height: 30.h,
                                              decoration: ShapeDecoration(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      5.w),
                                                  side: const BorderSide(
                                                      color: AppColors.searchFieldColor),
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .symmetric(horizontal: 8.w),
                                                child: Center(
                                                  child: Text(
                                                    "${state.model.genres![index].name}",
                                                    style: GoogleFonts.poppins(fontSize: 10,color: Colors.grey),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                      itemCount: state.model.genres!.length),
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  "${state.model.overview}",
                                  maxLines: 7,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(fontSize: 13,color: Colors.grey),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const Image(
                                        image: AssetImage(AppImages.star)),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      state.model.voteAverage
                                          .toString()
                                          .substring(0, 3),
                                      style: GoogleFonts.poppins(fontSize: 18,color:Colors.grey),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                    top: 50.h,
                    left: 15.w,
                    child: GestureDetector(
                        onTap: () {
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ))),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.31,
                  left: MediaQuery.of(context).size.width * 0.42,
                  child: FloatingActionButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      backgroundColor: AppColors.greyColor.withOpacity(0.5),
                      onPressed: () {
                        Navigator.pushNamed(context, TrailerScreen.routeName,
                            arguments: id);
                      },
                      child: const Icon(
                        Icons.play_arrow,
                        color: AppColors.yellowColor,
                      )),
                )
              ],
            );
          } else if (state is DetailsFailure) {
            return Center(
                child: Text(
                  'Failed to load movie details',
                  style: GoogleFonts.poppins(fontSize: 18,color: Colors.yellow),
                ));
          }
          return SizedBox(
            height: 492.h,
            width: 412.w,
            child: const Center(
              child: CircularProgressIndicator(
                color: AppColors.yellowColor,
              ),
            ),
          );
        },
      ),
    );
  }
}
