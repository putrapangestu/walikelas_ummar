import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:walikelas_ummar/app/core/all/agenda_client.dart';
import 'package:walikelas_ummar/app/modules/home/home.dart';
import 'package:walikelas_ummar/app/modules/page2/agenda/agendaLanjutan/agendaLanjutan.dart';

import '../../../color/app_color.dart';

class Agenda extends StatefulWidget {
  const Agenda({super.key});

  @override
  State<Agenda> createState() => _AgendaState();
}

class _AgendaState extends State<Agenda> {
  final AgendaApi _api = AgendaApi();

  // get preferences token
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    return token;
  }

  // function for api fetch data agenda
  Future<Map<String, dynamic>> fetchAgenda() async{
    try {
      String token = await getToken() ?? '';

      final response = await _api.fetchAgenda(token);

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
                      MaterialPageRoute(builder: (context) => const Home()),
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
        body: LayoutBuilder(
          builder: (context, constraints) {
          return FutureBuilder(
            future: fetchAgenda(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting)
              {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if(!snapshot.hasError && snapshot.hasData) {
                Map<String, dynamic> data = snapshot.data!;
                return ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 36),
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    for(var item in data['data'])
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3), // Atur posisi bayangan
                          ),
                        ],
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: Colors.white,
                      ),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 23, vertical: 17),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['judul'],
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
                                  ' : ${item["hari"]}',
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
                                  ' : ${item["tanggal"]}',
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
                                  ' : ${item["tempat"]} ',
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    color: Colors.grey.shade400,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AgendaLanjutan(id: item['id'].toString()),
                                  ),
                                );
                              },
                              child: Container(
                                height: 28,
                                width: 130,
                                decoration: BoxDecoration(
                                    color: AppColor.secondPrimary,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        'Selengkapnya',
                                        style: GoogleFonts.poppins(
                                          fontSize: 13,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    const Icon(
                                      Icons.chevron_right,
                                      color: Colors.white,
                                      size: 20,
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Text('Tidak ada agenda yang terdaftar');
              }
            },
          );
        }
      )
    );
  }
}
