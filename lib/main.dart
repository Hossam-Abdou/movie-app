import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/feature/bottom_nav_bar/view/bottom_bar_screen.dart';
import 'package:movie_app/feature/bottom_nav_bar/view_model/bottom_bar_cubit.dart';
import 'package:movie_app/feature/home/view/tabs/home_screen.dart';
import 'package:movie_app/feature/home/view_model/home_cubit.dart';
import 'package:movie_app/feature/splash_screen/splash_screen.dart';
import 'utils/app_colors/app_colors.dart';
import 'utils/my_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();

  // await EasyLocalization.ensureInitialized();
  runApp(const MyApp(),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BottomBarCubit()),
        BlocProvider(
          create: (context) => HomeCubit()
            ..getNewReleasesMovies()
            ..getRecommendedMovies()
          ..getPopularMovies()

          ,
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          theme: ThemeData(
              scaffoldBackgroundColor: AppColors.primaryColor,
              appBarTheme: const AppBarTheme(
                  backgroundColor: AppColors.greyColor,
                  iconTheme: IconThemeData(color: Colors.white,),),),
          debugShowCheckedModeBanner: false,
          initialRoute: BottomBarScreen.routeName,
          routes: {
            HomeScreen.routeName: (context) => const HomeScreen(),
            SplashScreen.routeName: (context) => const SplashScreen(),
            BottomBarScreen.routeName: (context) => const BottomBarScreen(),
          },

          // home: SplashScreen()
        ),
      ),
    );
  }
}
