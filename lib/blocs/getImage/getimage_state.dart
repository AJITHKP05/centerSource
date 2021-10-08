part of 'getimage_cubit.dart';

@immutable
abstract class GetimageState {}

class GetimageLoading extends GetimageState {}

class GetimageSuccess extends GetimageState {
  final List<ImageModel>? images;
  GetimageSuccess({
    this.images,
  });
}

class GetimageFailure extends GetimageState {}
