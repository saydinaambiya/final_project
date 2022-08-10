import 'dart:io';

import 'package:car_rental_ui/app/home/models/upload_model.dart';
import 'package:car_rental_ui/app/screen/admin/api/upload_api.dart';
import 'package:car_rental_ui/app/screen/admin/contents/widgets/hasil.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import '../api/upload_provider.dart';

class ProsesApriori extends StatefulWidget {
  ProsesApriori({Key? key}) : super(key: key);

  @override
  State<ProsesApriori> createState() => _ProsesAprioriState();
}

class _ProsesAprioriState extends State<ProsesApriori> {
  File file = File('');

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file.path) : "No File selected";
    UploadProvider uploadProvider = Provider.of<UploadProvider>(context);

    String? hasil;

    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: selectFile, child: Text('Select')),
            SizedBox(height: 20),
            Text(fileName),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await uploadProvider.gethasil(file);
                // setState(() {
                //   hasil = uploadModel.data.toString();
                // });
              },
              child: Text('Proses'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HasilPage(uploadProvider.hasil)));
              },
              child: Text('pindah'),
            ),
          ],
        )),
      ),
    ));
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;

    final path = result.files.single.path;

    setState(() {
      file = File(path!);
    });
  }
}
