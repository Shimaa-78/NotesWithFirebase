part of 'sub_collections_cubit.dart';

@immutable
sealed class SubCollectionsState {}

final class SubCollectionsInitial extends SubCollectionsState {}

final class getSubCollectionsLoading extends SubCollectionsState {}
final class getSubCollectionsSuccess extends SubCollectionsState {}
final class getSubCollectionsError extends SubCollectionsState {
  String msg;
  getSubCollectionsError(this.msg);


}

final class addSubCollectionsLoading extends SubCollectionsState {}
final class addSubCollectionsSuccess extends SubCollectionsState {}
final class addSubCollectionsError extends SubCollectionsState {
  String msg;
  addSubCollectionsError(this.msg);


}


final class updateSubCollectionsLoading extends SubCollectionsState {}
final class updateSubCollectionsSuccess extends SubCollectionsState {}
final class updateSubCollectionsError extends SubCollectionsState {
  String msg;
  updateSubCollectionsError(this.msg);


}



final class deleteSubCollectionsLoading extends SubCollectionsState {}
final class deleteSubCollectionsSuccess extends SubCollectionsState {}
final class deleteSubCollectionsError extends SubCollectionsState {
  String msg;
  deleteSubCollectionsError(this.msg);


}

