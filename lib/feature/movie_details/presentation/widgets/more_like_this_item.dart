import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../data/repository/more_like_this_repo/more_like_this_repo_impl.dart';
import '../manager/more_like_this_cubit/more_like_this_cubit.dart';
import '../manager/more_like_this_cubit/more_like_this_state.dart';
import '../pages/details_screen.dart';

class MoreLikeThisList extends StatelessWidget {
  const MoreLikeThisList({
    super.key,
    required this.id,
  });
  final int id;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MoreLikeThisCubit(MoreLikeThisRepoImp())
        ..getMoreLikeThisMovies(id: id),
      child: BlocBuilder<MoreLikeThisCubit, MoreLikeThisState>(
        builder: (context, state) {
          if(state is MoreLikeThisStateSuccess) {
            return Padding(
              padding: EdgeInsetsDirectional.only(start: 24.w),
              child: SizedBox(
                height: 190.h,
                child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) =>
                        GestureDetector(
                          onTap: ()
                          {
                            Navigator.pushNamed(context,DetailsScreen.id, arguments:state.movies[index].id );
                          },
                        ),
                    separatorBuilder: (context, index) =>
                        SizedBox(
                          width: 14.w,
                        ),
                    itemCount:state.movies.length),
              ),
            );
          }else if(state is MoreLikeThisStateFailure)
          {
            return  Center(
              child: Text('Error loading data',style: GoogleFonts.poppins(fontSize: 18,color: Colors.yellow),),
            );
          }
          return SizedBox(
              width:double.infinity,
              height: 128.h,
              child: const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.yellowColor,
                  )));
        },
      ),
    );
  }
}
