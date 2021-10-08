import 'package:bloc/bloc.dart';
import 'package:demo_app/model/image.dart';
import 'package:demo_app/repository/image_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

part 'getimage_state.dart';

class GetimageCubit extends Cubit<GetimageState> {
  final Repository repo = Repository();
  GetimageCubit() : super(GetimageLoading());
  void getData(String filter) async {
    print("inside vloc");
    emit(GetimageLoading());
    List<ImageModel> result = [];
    try {
      result = await repo.getData(filter);
      print(result);
      emit(GetimageSuccess(images: result));
    } catch (e) {
      emit(GetimageFailure());
      debugPrint("error");
    }
  }
}
