import 'package:car_rental_ui/app/home/widgets/cars_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class BookCars extends StatefulWidget {
  BookCars({Key? key}) : super(key: key);

  @override
  State<BookCars> createState() => _BookCarsState();
}

class _BookCarsState extends State<BookCars> {
  String? dropdownvalue;
  var items = [
    'Cash on Delivery',
    'QRIS Payment',
  ];

  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    Widget inputData(IconData icon, String text, TextInputType keyboard) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        child: Row(
          children: [
            Icon(icon),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextFormField(
                textInputAction: TextInputAction.next,
                keyboardType: keyboard,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: text,
                  hintStyle:
                      GoogleFonts.montserrat(fontWeight: FontWeight.normal),
                ),
              ),
            )
          ],
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black87,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              FontAwesomeIcons.angleLeft,
              color: Colors.white60,
              size: 30,
            ),
          ),
          title: Text(
            "Book Now",
            style: GoogleFonts.montserrat(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Text("Revisi")
                  // CarItem(),
                  ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    inputData(FontAwesomeIcons.solidUser, "Nama Pelanggan",
                        TextInputType.name),
                    inputData(FontAwesomeIcons.calendarDays,
                        "Tanggal Pengambilan", TextInputType.datetime),
                    inputData(FontAwesomeIcons.calendarDays,
                        "Tanggal Pengembalian", TextInputType.datetime),
                    inputData(FontAwesomeIcons.phone, "Nomor HP",
                        TextInputType.phone),
                    inputData(FontAwesomeIcons.locationDot, "Alamat Pelanggan",
                        TextInputType.streetAddress),
                    Row(
                      children: [
                        Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                        Icon(FontAwesomeIcons.wallet),
                        SizedBox(
                          width: 10,
                        ),
                        DropdownButton(
                            hint: Text(
                              "Pilih Pembayaran",
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.normal),
                            ),
                            value: dropdownvalue,
                            icon: Icon(Icons.keyboard_arrow_down),
                            items: items.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownvalue = newValue!;
                              });
                            }),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          checkColor: Colors.white,
                          fillColor: MaterialStateProperty.all(Colors.blue),
                          value: isChecked,
                          shape: CircleBorder(),
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                        ),
                        SizedBox(
                          width: 0,
                        ),
                        Text(
                          "Menyetujui Syarat dan Ketentuan",
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomSheet: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(left: 30),
              child: RichText(
                text: TextSpan(
                  style: GoogleFonts.montserrat(
                      fontSize: 17,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500),
                  children: const <TextSpan>[
                    TextSpan(text: '\Rp 350.000 '),
                    TextSpan(
                        text: '/ Hari',
                        style: TextStyle(color: Colors.black38)),
                  ],
                ),
              ),
            ),
            Container(
              width: 170,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => BookCars()));
                },
                child: Text(
                  "Book now",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w400, fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: new RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
