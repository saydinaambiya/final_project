import 'dart:io';

import 'package:car_rental_ui/app/home/models/upload_model.dart';
import 'package:car_rental_ui/app/home/views/login_screen.dart';
import 'package:car_rental_ui/app/screen/admin/api/upload_api.dart';
import 'package:car_rental_ui/app/screen/admin/contents/widgets/hasil.dart';
import 'package:car_rental_ui/constants/color_constans.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
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
      appBar: AppBar(
        title: Text("Generate Data Rekomendasi"),
      ),
      body: Center(
        child: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Pilih File",
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold, fontSize: 16),
            ),
            IconButton(
              color: color1,
              iconSize: 50,
              onPressed: selectFile,
              icon: Icon(FontAwesomeIcons.fileArrowUp),
            ),
            SizedBox(height: 20),
            Text(fileName),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: color1),
                  onPressed: () async {
                    await uploadProvider.gethasil(file);
                    // setState(() {
                    //   hasil = uploadModel.data.toString();
                    // });
                  },
                  child: Text('Proses'),
                ),
                IconButton(
                  color: color1,
                  iconSize: 30,
                  icon: Icon(FontAwesomeIcons.circleArrowRight),
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                HasilPage(uploadProvider.hasil)));
                  },
                ),
              ],
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
