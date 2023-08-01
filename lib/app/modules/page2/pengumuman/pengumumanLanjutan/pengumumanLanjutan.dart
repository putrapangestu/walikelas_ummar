
// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:walikelas_ummar/app/core/all/pengumuman_client.dart';
import 'package:walikelas_ummar/app/modules/page2/pengumuman/pengumuman.dart';

class Selengkapnya extends StatefulWidget {
  const Selengkapnya({super.key, required this.id});

  final String id;

  @override
  State<Selengkapnya> createState() => _SelengkapnyaState();
}

class _SelengkapnyaState extends State<Selengkapnya> {
final PengumumanApi _api = PengumumanApi();

  // get preferences token
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    return token;
  }

  Future<Map<String, dynamic>> fetchDetailPengumuman() async{
    try {
      String token = await getToken() ?? '';

      final response = await _api.fetchDetailPengumuman(token, widget.id);

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
                      MaterialPageRoute(builder: (context) => const Pengumuman()),
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
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          FutureBuilder(
            future: fetchDetailPengumuman(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (!snapshot.hasError && snapshot.hasData) {
                Map<String, dynamic> data = snapshot.data!;
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(padding: EdgeInsets.only(left: 20)),
                          Text(
                            'Pengumuman',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(right: 80)),
                          Text(
                            'Hari Ini, 7 Maret 2023',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        'Apa itu shock depan upside down? USD pada dasarnya adalah suspensi telescopic yang dipasang terbalik, jadi bagian tabung yang lebih besar berada di atas, sementara tabung yang lebih kecil ada di bawah.',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            // ignore: deprecated_member_use
                            primary: Colors.orange,
                          ),
                          onPressed: () {},
                          child: SizedBox(
                            width: 110,
                            child: Row(
                              children: [
                                const Icon(Icons.picture_as_pdf),
                                Text(
                                  'Download File',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );          
              } else {
                return const Text('Belum ada pengumuman');
              }
            }
          ),
        ],
      ),
    );
  }
}
