// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:walikelas_ummar/app/core/all/agenda_client.dart';
import 'package:walikelas_ummar/app/modules/page2/agenda/agenda.dart';

import '../../../../color/app_color.dart';

class AgendaLanjutan extends StatefulWidget {
  const AgendaLanjutan({super.key, required this.id});

  final String id;
  @override
  State<AgendaLanjutan> createState() => _AgendaLanjutanState();
}

class _AgendaLanjutanState extends State<AgendaLanjutan> {
  final AgendaApi _api = AgendaApi();

  // get preferences token
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    return token;
  }

  Future<Map<String, dynamic>> fetchDetailAgenda() async{
    try {
      String token = await getToken() ?? '';

      final response = await _api.fetchDetailAgenda(token, widget.id);

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
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 100,
        title: Padding(
          padding: const EdgeInsets.only(top: 26, bottom: 40),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Agenda',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(top: 26, left: 20, bottom: 40),
          child: SizedBox(
            width: 30,
            height: 30,
            child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Agenda()),
                  );
                },
                child: Ink(
                  decoration: ShapeDecoration(
                      color: AppColor.secondPrimary,
                      shape: const CircleBorder()),
                  child: const Icon(
                    CupertinoIcons.arrow_left,
                    color: Colors.white,
                    size: 18,
                  ),
                )),
          ),
        ),
        elevation: 0,
      ),
      body: FutureBuilder(
        future: fetchDetailAgenda(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (!snapshot.hasError && snapshot.hasData) {
            Map<String, dynamic> data = snapshot.data!;
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              children: [
                Text(
                  data['data']['judul'],
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      'Hari',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.grey.shade400,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      ' : ${data['data']['hari']}',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.grey.shade400,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Tanggal',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.grey.shade400,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      ' : ${data['data']['tanggal']}',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.grey.shade400,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Tempat',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.grey.shade400,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      ' : ${data['data']['tempat']} ',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.grey.shade400,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  data['data']['deskripsi'],
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.only(right: 150),
                  child: Container(
                    height: 30,
                    width: 149,
                    decoration: BoxDecoration(
                      // ignore: deprecated_member_use
                      color: AppColor.secondPrimary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SizedBox(
                      width: 110,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
                            Icons.picture_as_pdf,
                            size: 15,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Download ',
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Text('Tidak ada data tentang agenda ini');
          }
        },
      )
    );
  }
}
