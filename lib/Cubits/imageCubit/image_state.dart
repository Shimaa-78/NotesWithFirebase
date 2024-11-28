part of 'image_cubit.dart';

@immutable
sealed class ImageState {}

final class ImageInitial extends ImageState {}

final class ImagePickLoading extends ImageState {}
final class ImagePickSuccess extends ImageState {}
final class ImagePickError extends ImageState {}
