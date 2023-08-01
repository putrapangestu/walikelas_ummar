// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:walikelas_ummar/app/core/all/user_client.dart';
import 'package:walikelas_ummar/app/modules/Siswa/siswa.dart';
import 'package:walikelas_ummar/app/modules/page2/agenda/agenda.dart';
import 'package:walikelas_ummar/app/modules/page2/kalender/kalender.dart';
import 'package:walikelas_ummar/app/modules/page2/pengumuman/pengumuman.dart';
import 'package:walikelas_ummar/app/modules/page2/tugas/tugas.dart';
import '../../../color/app_color.dart';
import '../../home/home copy.dart';
import '../notifikasi/notifikasi.dart';

// ignore: must_be_immutable
class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final UserApi userApi = UserApi();
  Map<String, dynamic> userData = {};

  // get preferences token
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    return token;
  }

  // get preferences email dan password
  Future<Map<String, dynamic>> getEmailPassword () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString("email");
    String? password = prefs.getString("password");

    return {
      'email' : email,
      'password' : password
    };
  }

   // function for api fetch data user
  Future<void> fetchUsers() async{
    try {
      String token = await getToken() ?? '';
      Map<String, dynamic> checkEP = await getEmailPassword();

      final response = await userApi.fetchUser(
        token,
        checkEP['email'],
        checkEP['password'],
      );

      if(response.statusCode == 200)
      {
        setState(() {
          userData = response.data!['data'];
        });
      } else {
        userData = {};
      }     
    } catch (e)
    {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red.shade300,
        ),
      );
      userData = {};
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }


  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEEE , dd MMMM yyyy').format(now);
    return Scaffold(
      // bottomNavigationBar: BottomNavigationPage(),
        body: ListView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 28),
          children: [
          // user
          Container(
            margin: EdgeInsets.only(bottom: 16),
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Home1()));
                      },
                      child: ClipOval(
                        child: Container(
                          color: Colors.grey.shade200,
                          width: 50,
                          height: 50,
                          child: Icon(
                            Icons.person,
                            size: 30,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Assalamualaikum",
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          userData['name'] ?? '--',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 19,
                            fontFamily: 'poppins',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    color: Color.fromARGB(255, 184, 143, 151),
                  ),
                  child: IconButton(
                    icon: Icon(CupertinoIcons.bell),
                    color: Colors.black,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Notifikasi()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // card guru...
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(bottom: 20),
            height: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: AppColor.primary,
            ),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.all(5),
                  child: Text(
                    // ignore: unnecessary_string_interpolations
                    '$formattedDate',
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3), // Atur posisi bayangan
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                              color: AppColor.secondarySoft,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            margin: EdgeInsets.all(10),
                            child: ClipOval(
                              child: Container(
                                color: Colors.grey.shade200,
                                width: 50,
                                height: 50,
                                child: Icon(
                                  Icons.person,
                                  size: 30,
                                  color: Colors.grey.shade400,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Nama',
                              style: GoogleFonts.poppins(
                                color: AppColor.secondary,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              'NIP',
                              style: GoogleFonts.poppins(
                                color: AppColor.secondary,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              'Wali kelas',
                              style: GoogleFonts.poppins(
                                color: AppColor.secondary,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ' :  ${userData["name"]}',
                              style: GoogleFonts.poppins(
                                color: AppColor.secondary,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              ' :  0976644874',
                              style: GoogleFonts.poppins(
                                color: AppColor.secondary,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              ' :  V (Lima)',
                              style: GoogleFonts.poppins(
                                color: AppColor.secondary,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),

          // Notifikasi
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Notifikasi()),
              );
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 45,
              decoration: BoxDecoration(
                  color: AppColor.primary,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    CupertinoIcons.bell,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    '1 Notifikasi Belum Dilihat',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),

          // button-button

          // base row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Layer Satu
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Siswa()),
                      );
                    },
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3), // Atur posisi bayangan
                          ),
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: AppColor.primary,
                      ),
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                        child: Image.asset(
                          'assets/logos/siswa.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 30),
                    child: Text(
                      'Siswa',
                      style: GoogleFonts.poppins(
                          fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Pengumuman()),
                      );
                    },
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3), // Atur posisi bayangan
                          ),
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: AppColor.primary,
                      ),
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 11, horizontal: 11),
                        child: Image.asset(
                          'assets/logos/pengumuman.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 30),
                    child: Text(
                      'Pengumuman',
                      style: GoogleFonts.poppins(
                          fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),

              SizedBox(
                width: 15,
              ),

              // Layer Dua
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Kalender()),
                      );
                    },
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3), // Atur posisi bayangan
                          ),
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: AppColor.primary,
                      ),
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                        child: Image.asset(
                          'assets/logos/kalender.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 12),
                    child: Text(
                      '  Kalender\nPendidikan',
                      style: GoogleFonts.poppins(
                          fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Agenda()),
                      );
                    },
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3), // Atur posisi bayangan
                          ),
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: AppColor.primary,
                      ),
                      child: Container(
                        padding: EdgeInsets.only(left: 4),
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: Image.asset(
                          'assets/logos/agenda.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 30),
                    child: Text(
                      'Agenda',
                      style: GoogleFonts.poppins(
                          fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 20,
              ),

              // Layer Tiga
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Tugas()),
                      );
                    },
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3), // Atur posisi bayangan
                          ),
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: AppColor.primary,
                      ),
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 11, horizontal: 11),
                        child: Image.asset(
                          'assets/logos/tugas.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 30),
                    child: Text(
                      'Tugas',
                      style: GoogleFonts.poppins(
                          fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    width: 70,
                    height: 70,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 28, bottom: 30),
                  ),
                ],
              ),

              SizedBox(
                width: 0,
              ),
            ],
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'Aktifitas hari ini',
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 100,
            // alignment: Alignment.centerLeft,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // Atur posisi bayangan
                ),
              ],
              color: Colors.white,
            ),
            child: Stack(
              children: [
                Container(
                  width: 100,
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: Image(
                    image: Image.asset(
                      'assets/images/percentimage.png',
                    ).image,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            left: 110,
                          ),
                          child: Text(
                            'Tugas harian',
                            style: GoogleFonts.poppins(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.only(
                              right: 10,
                            ),
                            child: Text(
                              '10%',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff6270FF)),
                            )),
                      ],
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(left: 100, bottom: 10, top: 10),
                      child: LinearPercentIndicator(
                        barRadius: const Radius.circular(5),
                        animation: true,
                        // lineHeight: 5.0,
                        percent: 0.1,
                        progressColor: const Color(0xff6270FF),
                        backgroundColor: AppColor.secondarySoft,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            left: 110,
                          ),
                          child: Text(
                            'Siswa yang selesai',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              color: AppColor.secondarySoft,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
