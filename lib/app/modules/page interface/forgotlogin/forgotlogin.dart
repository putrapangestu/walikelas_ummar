import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../home/home.dart';
import '../login/login.dart';

class ForgotLogin extends StatelessWidget {
  const ForgotLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Body(),
      ),
    );
  }
}

// ignore: use_key_in_widget_constructors
class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: constraints.maxHeight * 0.4,
                decoration: const BoxDecoration(
                  color: Color(0xffD9D9D9),
                ),
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth * 0.2,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: constraints.maxHeight * 0.1,
                      ),
                      Image.asset(
                        'assets/images/logoummar.png',
                        width: constraints.maxWidth * 0.8,
                        height: constraints.maxHeight * 0.3,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: const Color(0xffD9D9D9),
                child: Stack(
                  children: [
                    Container(
                      // height: constraints.maxHeight * 0.6,
                      width: constraints.maxWidth,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50),
                          topLeft: Radius.circular(50),
                        ),
                        color: Color(0xffF9F9F9),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: constraints.maxHeight * 0.1,
                              right: constraints.maxWidth * 0.3,
                            ),
                            child: Text(
                              'Lupa Password ?',
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                // fontSize: constraints.maxWidth * 0.06,
                                fontSize: 24,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: constraints.maxHeight * 0.00,
                              right: constraints.maxWidth * 0.3,
                            ),
                            child: Text(
                              'Masukkan alamat email Anda',
                              style: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                                // fontSize: constraints.maxWidth * 0.025,
                              ),
                            ),
                          ),
                          SizedBox(height: constraints.maxHeight * 0.02),
                          Container(
                            width: constraints.maxWidth * 0.81,
                            height: 60,
                            decoration: BoxDecoration(
                              color: const Color(0xffEFEFEF),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                            child: const TextField(
                              decoration: InputDecoration(
                                hintText: 'Email',
                                contentPadding:
                                    EdgeInsets.only(left: 10, top: 7),
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          SizedBox(height: constraints.maxHeight * 0.10),
                          GestureDetector(
                            onTap: () {
                              // Aksi ketika tombol "Kirim" ditekan saya
                              //saya
                            },
                            child: Container(
                              width: constraints.maxWidth * 0.81,
                              height: constraints.maxHeight * 0.07,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Center(
                                child: Text(
                                  'Kirim',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    // fontSize: constraints.maxWidth * 0.045,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: constraints.maxHeight * 0.02),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Home(),
                                ),
                              );
                            },
                            child: Container(
                              width: constraints.maxWidth * 0.75,
                              height: constraints.maxHeight * 0.07,
                              decoration: BoxDecoration(
                                color: const Color(0xffE08008),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Center(
                                child: Text(
                                  'Kirim',
                                  style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: constraints.maxHeight * 0.035,
                      left: constraints.maxWidth * 0.10,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()),
                          );
                        },
                        child: Container(
                          width: constraints.maxWidth * 0.08,
                          height: constraints.maxWidth * 0.08,
                          decoration: BoxDecoration(
                            color: const Color(0xffE08008),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
