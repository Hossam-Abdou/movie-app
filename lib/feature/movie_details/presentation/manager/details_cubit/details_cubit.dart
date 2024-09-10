import 'package:bloc/bloc.dart';

import '../../../data/repository/details_reop/details_repo.dart';
import 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit(this.detailsRepo) : super(DetailsInitial());
  final DetailsRepo detailsRepo;


  void getDetails({required int id})
  async {
    emit(DetailsLoading());
    var res=await detailsRepo.getDetailsMovies(id: id);
    res.fold((e){
      emit(DetailsFailure(error: e.message));
    }, (details){
      emit(DetailsSuccess(model: details));
    });
  }
}
