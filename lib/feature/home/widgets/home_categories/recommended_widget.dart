import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/feature/home/view_model/home_cubit.dart';
import 'package:movie_app/utils/app_colors/app_colors.dart';
import 'package:movie_app/utils/app_images/app_images.dart';
import 'package:movie_app/utils/components/custom_rate.dart';
import 'package:movie_app/utils/components/custom_wish_list_container.dart';
import 'package:movie_app/utils/constants/constants.dart';

class RecommendedWidget extends StatelessWidget {
  const RecommendedWidget({super.key});


  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<HomeCubit, HomeState>(
  builder: (context, state) {
    var  cubit = HomeCubit.get(context);
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      color: AppColors.greyColor ,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recomended',
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
                separatorBuilder: (context, index) =>  SizedBox(
                  width: 12.w,
                ),
                itemCount: cubit.topRatedModel?.results?.length??0,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       InkWell(
                         onTap: () {

                         },
                         child: CustomWishListContainer(
                          firstImage:'${cubit.topRatedModel?.results?[index].posterPath}' ?? '',
                          secondImage: AppImages.bookmark,
                           onTap: (){},
                                           ),
                       ),
                      CustomRate(rate: cubit.topRatedModel?.results?[index].voteAverage.toString() ,) ,
                      Text(
                        cubit.topRatedModel?.results?[index].title ?? '',
                        style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '${cubit.topRatedModel?.results?[index].releaseDate?.substring(0,4)}',
                        style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
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
