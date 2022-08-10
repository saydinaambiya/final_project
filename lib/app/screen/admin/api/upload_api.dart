import 'dart:io';

import 'package:car_rental_ui/app/home/models/upload_model.dart';
import 'package:dio/dio.dart';

class UploadApi {
  static Future<UploadModel> uploadFile({
    required File file,
    // required da
  }) async {
    String fileName = file.path.split('/').last;
    try {
      Dio dio = Dio();

      String url = "http://10.140.170.138:8000/api/getdata";

      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(file.path, filename: fileName)
      });

      var response = await dio.post(
        url,
        options: Options(headers: {"Content-Type": "aplication/json"}),
        data: formData,
      );
      if (response.statusCode == 200) {
        var data = response.data;
        UploadModel uploadModel =
            UploadModel.fromJson(data as Map<String, dynamic>);
        // List data = response.data['data'] ?? [];

        // Map<String, dynamic> upload =
        //     Map<String, dynamic>.from(jsonDecode(response.data));
        // List<UploadModel> upload =
        //     data.map((data) => UploadModel.fromJson(data)).toList();
        print("Upload Berhasil");
        print(response.data);
        // print(uploadModel.data);
        return uploadModel;
      } else {
        throw Exception("Gagal Upload");
      }
    } catch (e) {
      print("Gagal");
      throw Exception(e);
    }
  }
}
