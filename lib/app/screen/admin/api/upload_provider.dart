import 'dart:io';

import 'package:car_rental_ui/app/home/models/upload_model.dart';
import 'package:car_rental_ui/app/screen/admin/api/upload_api.dart';
import 'package:flutter/material.dart';

class UploadProvider with ChangeNotifier {
  late UploadModel _hasil;

  UploadModel get hasil => _hasil;

  set hasil(UploadModel hasil) {
    _hasil = hasil;
    notifyListeners();
  }

  Future<bool> gethasil(File file) async {
    try {
      UploadModel hasil = await UploadApi.uploadFile(file: file);
      _hasil = hasil;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
