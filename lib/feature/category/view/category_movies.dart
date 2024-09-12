import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/feature/category/view_model/category_cubit.dart';
import 'package:movie_app/feature/home/view/movie_details/movie_details_screen.dart';
import 'package:movie_app/feature/home/view_model/home_cubit.dart';
import 'package:movie_app/utils/components/custom_rate.dart';
import 'package:movie_app/utils/components/custom_wish_list_container.dart';
import '../../../../utils/app_images/app_images.dart';

class CategoryMovies extends StatelessWidget {
  const CategoryMovies({super.key});

  static const String routeName = 'categoryMovies';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments as dynamic;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
          CategoryCubit()..getCategoryMovies(id.id.toString()),
        ),
        BlocProvider(create: (context) => HomeCubit()..getWatchList(),)
      ],
      child: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, categoryState) {
          var cubit = CategoryCubit.get(context);

          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 16.h,
                      ),
                      Text(
                        id.name,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 20.sp,
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      BlocBuilder<HomeCubit, HomeState>(
                        builder: (context, homeState) {
                          var homeCubit = context.read<HomeCubit>();

                          return GridView.builder(
                              itemCount: cubit.categoryMovieModel?.results?.length ?? 0,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10.h,
                                crossAxisSpacing: 10.w,
                                childAspectRatio: 0.6,
                              ),
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final movie = cubit.categoryMovieModel?.results?[index];
                                final isInWatchlist = homeCubit.watchListModel?.results?.any((e) => e.id == movie?.id) ?? false;

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: CustomWishListContainer(
                                        icon: isInWatchlist ? Icons.check : Icons.add,
                                        firstImage: '${movie?.posterPath}',
                                        secondImage: isInWatchlist ? AppImages.wishList : AppImages.bookmark,
                                        IconOnTap: () {
                                          homeCubit.addToWatchList(
                                            isWatchList: isInWatchlist ? false : true,
                                            id: movie?.id,
                                          );
                                        },
                                        onTap: () {
                                          Navigator.pushNamed(
                                            context,
                                            MovieDetailsScreen.routeName,
                                            arguments: movie?.id,
                                          );
                                        },
                                      ),
                                    ),
                                    CustomRate(
                                      rate: cubit.categoryMovieModel?.results?[index].voteAverage.toString(),
                                    ),
                                    Text(
                                      movie?.title ?? '',
                                      style: GoogleFonts.poppins(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
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
                                );
                              }
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
