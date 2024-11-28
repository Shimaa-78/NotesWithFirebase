part of 'collections_cubit.dart';

@immutable
sealed class CollectionsState {}

final class CollectionsInitial extends CollectionsState {}
final class CollectionsLoading extends CollectionsState {}
final class CollectionsSuccess extends CollectionsState {}
final class CollectionsError extends CollectionsState {
  String msg;
  CollectionsError(this.msg);

}


final class getCollectionsLoading extends CollectionsState {}
final class getCollectionsSuccess extends CollectionsState {

}
final class getCollectionsError extends CollectionsState {
  String msg;
  getCollectionsError(this.msg);

}


final class deleteCollectionsLoading extends CollectionsState {}
final class deleteCollectionsSuccess extends CollectionsState {

}


final class updateCollectionsLoading extends CollectionsState {}
final class updateCollectionsSuccess extends CollectionsState {}
final class updateCollectionsError extends CollectionsState {
  String msg;
  updateCollectionsError(this.msg);

}
