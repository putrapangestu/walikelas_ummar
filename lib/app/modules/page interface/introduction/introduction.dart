import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login/login.dart';

class Introduction extends StatefulWidget {
  const Introduction({Key? key}) : super(key: key);

  @override
  State<Introduction> createState() => _IntroductionState();
}

class _IntroductionState extends State<Introduction> {
  void dataChecked () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("checked", true);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
    );
  } 
  
  Future<bool> checkedFirst() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('checked');
  }
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: checkedFirst(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasData && snapshot.data!) {
          return const Login();
        } else {
          return LayoutBuilder(
            builder: (context, constraints) {
              const pageDecoration = PageDecoration(
                titleTextStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  fontFamily: 'poppins',
                ),
                bodyTextStyle: TextStyle(
                  fontSize: 13,
                  color: Color(0xff9F9F9F),
                  fontFamily: 'poppins',
                ),
                bodyPadding: EdgeInsets.all(10),
              );

              return IntroductionScreen(
                globalBackgroundColor: Colors.white,
                pages: [
                  PageViewModel(
                    title: 'Permudah Mengajar',
                    body: 'memberikan kemudahan dalam proses\nmengajar.',
                    decoration: pageDecoration,
                    image: Stack(
                      alignment: Alignment.topLeft,
                      children: [
                        Image.asset(
                          'assets/images/introSatu.png',
                          width: constraints.maxWidth * 0.9,
                        ),
                      ],
                    ),
                  ),
                  PageViewModel(
                    title: 'Lebih mudah dan\nEfektif ',
                    body:
                        'Lebih mudah dan efektif dalam memberikan\ntugas dan memantau tugas peserta didik.',
                    decoration: pageDecoration,
                    image: Stack(
                      alignment: Alignment.topLeft,
                      children: [
                        Image.asset(
                          'assets/images/introDua.png',
                          width: constraints.maxWidth * 0.9,
                        ),
                      ],
                    ),
                  ),
                ],
                onDone: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                  );
                },
                showSkipButton: true,
                showNextButton: true,
                showDoneButton: true,
                showBackButton: false,
                dotsFlex: 3,
                nextFlex: 1,
                skipOrBackFlex: 1,
                back: const Icon(Icons.arrow_back),
                skip: Text(
                  'Lewati',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                next: Container(
                  width: 80,
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xffE08008),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                ),
                done: Container(
                  // width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xffE08008),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: dataChecked,
                    child: Text(
                      'Mengerti',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  )
                ),
                bodyPadding: EdgeInsets.only(top: constraints.maxHeight * 0.1),
                dotsDecorator: DotsDecorator(
                  size: const Size(10, 10),
                  color: Colors.grey,
                  activeSize: const Size(22, 10),
                  activeColor: Colors.orange,
                  activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              );
            },
          );
        }
      }
    );
  }
}
