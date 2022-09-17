import 'package:car_rental_ui/app/home/views/home_screen.dart';
import 'package:car_rental_ui/constants/color_constans.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final controller = PageController();

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: 70),
        child: PageView(
          controller: controller,
          children: [
            boardingPage(
              boxSize: 0,
              colorBack: colorW,
              lottieAsset:
                  'https://assets6.lottiefiles.com/packages/lf20_tro96fce.json',
              title: 'Pembayaran Lebih Mudah',
              subTitle:
                  'Tidak Perlu Uang Cash, Pembayaran Cukup Dengan Bukti Transfer Anda',
            ),
            boardingPage(
              boxSize: 150,
              colorBack: colorW,
              lottieAsset:
                  'https://assets7.lottiefiles.com/packages/lf20_wkaoqtgc.json',
              title: 'Mobil Rekomendasi',
              subTitle:
                  'Mobil Pilihan Yang Lebih Bervariasi Tersedia Untuk Anda',
            ),
            boardingPage(
              boxSize: 150,
              colorBack: colorW,
              lottieAsset:
                  'https://assets10.lottiefiles.com/private_files/lf30_hsabbeks.json',
              title: 'Tersedia Armada Dengan Supir',
              subTitle:
                  'Armada Dengan Supir atau Lepas Kunci, Pilihan di Tangan Anda',
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 70,
        color: color1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              style: TextButton.styleFrom(primary: colorW),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
              child: Text('SKIP'),
            ),
            Center(
              child: SmoothPageIndicator(
                controller: controller,
                count: 3,
                effect: WormEffect(
                    spacing: 16,
                    dotColor: Colors.black26,
                    activeDotColor: colorW),
                onDotClicked: (index) => controller.animateToPage(index,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeIn),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(primary: colorW),
              onPressed: () => controller.nextPage(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut),
              child: Text('NEXT'),
            )
          ],
        ),
      ),
    );
  }

  Widget boardingPage(
      {required Color colorBack,
      required String lottieAsset,
      required String title,
      required String subTitle,
      required double boxSize}) {
    return Container(
      color: colorBack,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: boxSize,
          ),
          LottieBuilder.network(lottieAsset),
          Text(title,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              )),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              subTitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
