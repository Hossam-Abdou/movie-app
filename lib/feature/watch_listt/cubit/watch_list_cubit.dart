import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WatchListCubit extends Cubit<List<Map<String, dynamic>>> {
  final FirebaseFirestore firestore;

  WatchListCubit(this.firestore) : super([]) {
    fetchWatchList(); // Fetch the initial data
  }

  // Fetch the watchlist from a fixed document
  Future<void> fetchWatchList() async {
    try {
      final snapshot = await firestore
          .collection('watchlists')
          .doc('shared') // اسم مستند ثابت
          .collection('movies')
          .get();

      emit(snapshot.docs.map((doc) => doc.data()).toList());
    } catch (e) {
      print('Error fetching watchlist: $e');
    }
  }

  // Add a movie to the watchlist
  Future<void> addToWatchList(Map<String, dynamic> movie) async {
    try {
      await firestore
          .collection('watchlists')
          .doc('shared') // اسم مستند ثابت
          .collection('movies')
          .add(movie);

      fetchWatchList(); // Update the state after adding a new movie
    } catch (e) {
      print('Error adding movie: $e');
    }
  }

  // Remove a movie from the watchlist
  Future<void> removeFromWatchList(String movieID) async {
    try {
      final snapshot = await firestore
          .collection('watchlists')
          .doc('shared') // اسم مستند ثابت
          .collection('movies')
          .where('id', isEqualTo: movieID)
          .get();

      for (var doc in snapshot.docs) {
        await doc.reference.delete();
      }

      fetchWatchList(); // Update the state after removing a movie
    } catch (e) {
      print('Error removing movie: $e');
    }
  }
}