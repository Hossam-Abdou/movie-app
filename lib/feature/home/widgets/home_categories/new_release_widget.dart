import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/feature/home/view_model/home_cubit.dart';
import 'package:movie_app/utils/app_colors/app_colors.dart';
import 'package:movie_app/utils/app_images/app_images.dart';
import 'package:movie_app/utils/constants/constants.dart';

class NewReleaseWidget extends StatelessWidget {
  const NewReleaseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is NewReleaseLoadingState) {

const Center(child:
  CircularProgressIndicator(),);
        }
          },
        builder: (context, state) {
          var cubit = HomeCubit.get(context);

          return Container(
            height: MediaQuery.of(context).size.height * 0.36,
            color: AppColors.greyColor,
            child: Padding(
              padding:  EdgeInsets.all(12.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'New Releases',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Expanded(
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) =>  SizedBox(
                        width: 12.w,
                      ),
                      itemCount: cubit.newReleaseModel?.results?.length??0,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                InkWell(
                                  onTap: () {

                                  },
                                  child: Container(
                                      alignment: Alignment.topLeft,
                                      width:
                                          MediaQuery.of(context).size.width * 0.39,
                                      height:
                                          MediaQuery.of(context).size.height * 0.24,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.r),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            '${Constants.imageBaseUrl}${cubit.newReleaseModel?.results?[index].posterPath}' ?? '',
                                          ),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      child: Container(
                                        height: MediaQuery.of(context).size.height * 0.05,
                                        decoration: const BoxDecoration(
                                          color: Colors.transparent,
                                          image: DecorationImage(
                                            image: AssetImage(
                                              AppImages.bookmark,
                                            ),
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.add,
                                          color: Colors.white,
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
