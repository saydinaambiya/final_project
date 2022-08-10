class UploadModel {
  List<String>? data;

  UploadModel({this.data});

  UploadModel.fromJson(Map<String, dynamic> json) {
    data = json['data'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    // final Map<String, dynamic> data = new Map<String, dynamic>();
    return {
      'data': data,
    };
  }
}
