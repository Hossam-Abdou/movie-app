import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/feature/watch_listt/cubit/watch_list_cubit.dart';

class WatchListScreen extends StatelessWidget {
  static  String routeName = 'WatchList';

  const WatchListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Watch List')),
      body: BlocBuilder<WatchListCubit, List<Map<String, dynamic>>>(
        builder: (context, watchList) {
          return ListView.builder(
            itemCount: watchList.length,
            itemBuilder: (context, index) {
              final movie = watchList[index];
              return ListTile(
                title: Text(movie['title'] ?? 'No Title'),
                // باقي تفاصيل العرض هنا
              );
            },
          );
        },
      ),
    );
  }
}