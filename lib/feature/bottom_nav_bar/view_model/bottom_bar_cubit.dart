import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/feature/category/view/browse_screen.dart';
import 'package:movie_app/feature/home/view/home_screen.dart';
import 'package:movie_app/feature/home/view/search_screen.dart';
import 'package:movie_app/feature/home/view/watch_list_screen.dart';


part 'bottom_bar_state.dart';

class BottomBarCubit extends Cubit<BottomBarState> {
  BottomBarCubit() : super(BottomBarInitial());
  static BottomBarCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  void changeIndex(int newIndex) {
    currentIndex = newIndex;
    emit(ChangeIndexState());
  }

  List<Widget> layouts = [
    const HomeScreen(),
     const  SearchScreen(),
     const BrowseScreen(),
    const WatchListScreen()
  ];
}
