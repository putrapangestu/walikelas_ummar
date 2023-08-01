import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:walikelas_ummar/app/core/all/pengumuman_client.dart';
import 'package:walikelas_ummar/app/modules/home/home.dart';
import 'package:walikelas_ummar/app/modules/page2/pengumuman/pengumumanLanjutan/pengumumanLanjutan.dart';

class Pengumuman extends StatefulWidget {
  const Pengumuman({super.key});

  @override
  State<Pengumuman> createState() => _PengumumanState();
}

class _PengumumanState extends State<Pengumuman> {
  final PengumumanApi _api = PengumumanApi();

   // get preferences token
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    return token;
  }

  // function for api fetch data pengumuman
  Future<Map<String, dynamic>> fetchPengumuman() async{
    try {
      String token = await getToken() ?? '';

      final response = await _api.fetchPengumuman(token);

      if(response.statusCode == 200)
      {
        return response.data;
      } else {
        return {};
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
      return {};
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 10,
              right: 10,
              left: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Home()),
                    );
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                      color: Color(0xffE08008),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      CupertinoIcons.arrow_left,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Pengumuman',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      'Jumat, 7 Maret 2023',
                      style: GoogleFonts.poppins(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 30),
            width: MediaQuery.of(context).size.width,
            height: 40,
            // decoration: BoxDecoration(
            //   border: Border.all(
            //     color: Color(0xffB7B7B7),
            //     width: 1,
            //   ),
            //   borderRadius: BorderRadius.circular(10),
            // ),
            child: TextField(
              decoration: InputDecoration(
                label: Text(
                  'Pencarian',
                  style: GoogleFonts.poppins(
                    color: Colors.grey,
                  ),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0xff8F4552),
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.only(left: 10),
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(8.0), // Menentukan padding ikon
                  child: Icon(Icons.search),
                ),
              ),
            ),
          ),
          FutureBuilder(
            future: fetchPengumuman(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (!snapshot.hasError && snapshot.hasData) {
                Map<String, dynamic> data = snapshot.data!;
                return Column(
                  children: [
                    for(var item in data['data'])
                    Container(
                      padding: const EdgeInsets.only(right: 20, left: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(255, 71, 71, 71).withOpacity(0.3),
                                spreadRadius: 3,
                                blurRadius: 2,
                                offset: const Offset(0, 3),
                              ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                    ),
                                    child: Text(
                                      'Pengumuman',
                                      style: GoogleFonts.poppins(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Padding(padding: EdgeInsets.only(top: 10)),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Text(
                                          'Hari Ini, 7 Maret 2023',
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 1),
                                      Text(
                                        'Belum Dilihat',
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 10,
                                            top: 5,
                                          ),
                                          child: Text(
                                            'Hari ini, Ananda Fatih Farhat adalah siswa tercepata dalam menyelesaikan hafalan.',
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Container(
                                margin: const EdgeInsets.only(left: 10),
                                alignment: Alignment.centerLeft,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    // ignore: deprecated_member_use
                                    primary: const Color(0xffE08008),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Selengkapnya(id: item['id'].toString())),
                                    );
                                  },
                                  child: Text(
                                    'Selengkapnya >',
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    )
                  ],
                );          
              } else {
                return Text('Belum ada pengumuman');
              }
            }
          ),
          
        ],
      ),
    );
  }
}
