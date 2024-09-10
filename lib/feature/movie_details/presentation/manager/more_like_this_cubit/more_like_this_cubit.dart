import 'package:bloc/bloc.dart';

import '../../../data/repository/more_like_this_repo/more_like_this_repo.dart';
import 'more_like_this_state.dart';

class MoreLikeThisCubit extends Cubit<MoreLikeThisState> {
  MoreLikeThisCubit(this.moreLikeThisRepo) : super(MoreLikeThisStateInitial());

  final MoreLikeThisRepo moreLikeThisRepo;

  getMoreLikeThisMovies({required int id})
  async {
    emit(MoreLikeThisStateLoading());
    var result=await moreLikeThisRepo.getMoreLikeThisMovies(id: id);
    result.fold((e){
      emit(MoreLikeThisStateFailure(error: e.message));
    }, (movies){
      emit(MoreLikeThisStateSuccess(movies: movies));
    });

  }
}