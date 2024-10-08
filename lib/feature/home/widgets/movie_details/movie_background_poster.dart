import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/feature/home/view_model/home_cubit.dart';
import 'package:movie_app/utils/app_colors/app_colors.dart';
import 'package:movie_app/utils/constants/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieBackgroundPoster extends StatelessWidget {
  const MovieBackgroundPoster({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Column(
          children: [
            InkWell(
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) =>Video() ,));
                // print(cubit.movieTrailerModel?.results?[0].key);
                Uri uri = Uri.parse(
                    'https://www.youtube.com/watch?v=${cubit.movieTrailerModel?.results?[0].key}');
                launchUrl(uri);
              },
              child: CachedNetworkImage(
                placeholder: (context, text) => const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.yellowColor,
                    )),
                errorWidget: (context, url, error) => Container(
                  height: MediaQuery.sizeOf(context).height * 0.3,
                  width:  MediaQuery.sizeOf(context).width * 0.8,
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
                '${Constants.imageBaseUrl}${cubit.moviesDetailsModel?.backdropPath}',
                imageBuilder: (context, imageProvider) => Container(
                  height: MediaQuery.sizeOf(context).height * 0.3,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            '${Constants.imageBaseUrl}${cubit.moviesDetailsModel?.backdropPath}')),
                  ),
                  child: const Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.black54,
                      child: Icon(
                        Icons.play_arrow,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
