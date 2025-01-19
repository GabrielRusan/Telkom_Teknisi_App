import 'dart:io';

import 'package:core/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'edit_foto_profile_event.dart';
part 'edit_foto_profile_state.dart';

class EditFotoProfileBloc
    extends Bloc<EditFotoProfileEvent, EditFotoProfileState> {
  final Dio dio;
  final SharedPreferences sharedPref;
  EditFotoProfileBloc(this.dio, this.sharedPref)
      : super(EditFotoProfileInitial()) {
    on<EditFotoProfileEvent>((event, emit) async {
      emit(EditFotoProfileLoading());

      String imagePath = event.image.path;
      String fileName = imagePath.split('/').last;
      final String? token = sharedPref.getString("token");
      final String? idteknisi = sharedPref.getString("idteknisi");
      // Tentukan MIME type berdasarkan extension
      String mimeType = 'jpeg';
      if (fileName == '.png') {
        mimeType = 'png';
      }

      if (token == null || idteknisi == null) {
        emit(EditFotoProfileFailed());
        return;
      }
      try {
        final file = await MultipartFile.fromFile(
          imagePath,
          filename: fileName,
          contentType: DioMediaType('image', mimeType),
        );

        final formData = FormData.fromMap({
          'foto': file,
        });

        final response = await dio.put(
          '$BASE_URL/teknisi/$idteknisi', // Sesuaikan dengan endpoint Anda
          data: formData,
          options: Options(
            headers: {
              'Authorization':
                  'Bearer $token', // Tambahkan token jika diperlukan
              'Content-Type': 'multipart/form-data',
            },
          ),
        );

        if (response.statusCode == 200) {
          emit(EditFotoProfileSuccess()); // Sesuaikan dengan response dari API
        } else {
          emit(EditFotoProfileFailed());
        }
      } on DioException {
        emit(EditFotoProfileFailed());
      }
    });
  }
}
