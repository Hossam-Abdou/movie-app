import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/feature/home/view_model/home_cubit.dart';
import 'package:movie_app/feature/home/widgets/movie_details/genres_grid_view.dart';
import 'package:movie_app/feature/home/widgets/movie_details/movie_background_poster.dart';
import 'package:movie_app/feature/home/widgets/movie_details/movie_poster.dart';
import 'package:movie_app/feature/home/widgets/movie_details/similar_movies.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({super.key});

  static String routeName = 'movieDetails';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments as dynamic;
    return BlocProvider(
      create: (context) => HomeCubit()
        ..getMovieDetails(id)
        ..getSimilarMovie(id)..getMovieTrailer(id),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          var cubit = HomeCubit.get(context);


          return Scaffold(
            appBar: AppBar(
              title: Text(
                cubit.moviesDetailsModel?.title ?? '',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const MovieBackgroundPoster(),
                  const SizedBox(height: 18),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          cubit.moviesDetailsModel?.title ?? '',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          cubit.moviesDetailsModel?.releaseDate ?? '',
                          style: GoogleFonts.inter(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const MoviePoster(),
                            SizedBox(width: 10.w),
                            const GenresGridView(),
                          ],
                        ),
                         SizedBox(
                          height: 10.h,
                        ),
                        SimilarMovies(id: id,),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
