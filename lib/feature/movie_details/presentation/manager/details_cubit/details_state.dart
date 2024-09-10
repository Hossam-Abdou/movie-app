import '../../../data/models/details_model.dart';

class DetailsState {}

class DetailsInitial extends DetailsState {}
class DetailsLoading extends DetailsState {}
class DetailsSuccess extends DetailsState {
  final DetailsModel model;

  DetailsSuccess({required this.model});
}
class DetailsFailure extends DetailsState {
  final String error;

  DetailsFailure({required this.error});
}
