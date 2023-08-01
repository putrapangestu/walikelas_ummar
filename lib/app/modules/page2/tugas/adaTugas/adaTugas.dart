// ignore_for_file: file_names
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:walikelas_ummar/app/modules/page2/tugas/adaTugas/detailSiswaMengerjakan/detailSiswaMengerjakan.dart';

import 'package:walikelas_ummar/app/modules/page2/tugas/tugas.dart';

import '../../../../color/app_color.dart';

class TugasSelesai extends StatelessWidget {
  const TugasSelesai({super.key});

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Tugas',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Kelas 5',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    color: const Color(0xff9F9F9F),
                  ),
                ),
              ],
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
                    MaterialPageRoute(
                      builder: (context) => Tugas(),
                    ),
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
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          Text(
            'Keterangan',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(left: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      width: 13.0,
                      height: 13.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xff00FF1C),
                      ),
                    ),
                    Text(
                      '  :  Sudah Selesai Semua',
                      style: GoogleFonts.poppins(
                        color: Colors.grey.shade400,
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      width: 13.0,
                      height: 13.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffFFC700),
                      ),
                    ),
                    Text(
                      '  :  Sudah Selesai Sebagian',
                      style: GoogleFonts.poppins(
                        color: Colors.grey.shade400,
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      width: 13.0,
                      height: 13.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '  :  Tidak Ada Yang Mengerjakan',
                      style: GoogleFonts.poppins(
                        color: Colors.grey.shade400,
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
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
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 15),
                              child: Icon(
                                Icons.list,
                                color: AppColor.primary,
                              ),
                            ),
                            Text(
                              'Tugas',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              CupertinoIcons.clock_fill,
                              size: 15,
                              color: Color(0xff00FF1C),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '1/03/2023',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                                color: const Color(0xff00FF1C),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, left: 20, bottom: 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Murajadah',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Container(
                      height: 41,
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.grey.shade400, // Warna border
                          width: 2.0, // Lebar border
                        ),
                      ),
                      child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Ayat 1 - 15',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                      )),
                  Container(
                      margin: const EdgeInsets.only(top: 10, left: 20, bottom: 10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Ziyadah',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                      )),
                  Container(
                      height: 41,
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.grey.shade400, // Warna border
                          width: 2.0, // Lebar border
                        ),
                      ),
                      child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Ayat 16 - 25',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                      )),
                  Container(
                      margin: const EdgeInsets.only(top: 10, left: 20, bottom: 10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Tilawah',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                      )),
                  Container(
                      height: 41,
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.grey.shade400, // Warna border
                          width: 2.0, // Lebar border
                        ),
                      ),
                      child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Ayat 16 - 25',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                      )),
                  Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 10),
                      child: Text(
                        'Jumlah Siswa yang di beri tugas',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade400,
                          fontSize: 18,
                        ),
                      )),
                  Container(
                    height: 41,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.grey.shade300, // Warna border
                        width: 2.0, // Lebar border
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Text(
                            '1',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              color: Colors.grey.shade400,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const DetailTugasSelesai()));
                            },
                            child: const Icon(
                              Icons.error_outline,
                              color: Color(0xff00FF1C),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
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
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 15),
                              child: Icon(
                                Icons.list,
                                color: AppColor.primary,
                              ),
                            ),
                            Text(
                              'Tugas',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              CupertinoIcons.clock_fill,
                              size: 15,
                              color: Color(0xffFFC700),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '1/03/2023',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                                color: const Color(0xffFFC700),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, left: 20, bottom: 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Murajadah',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Container(
                      height: 41,
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.grey.shade400, // Warna border
                          width: 2.0, // Lebar border
                        ),
                      ),
                      child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Ayat 1 - 15',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                      )),
                  Container(
                      margin: const EdgeInsets.only(top: 10, left: 20, bottom: 10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Ziyadah',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                      )),
                  Container(
                      height: 41,
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.grey.shade400, // Warna border
                          width: 2.0, // Lebar border
                        ),
                      ),
                      child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Ayat 16 - 25',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                      )),
                  Container(
                      margin: const EdgeInsets.only(top: 10, left: 20, bottom: 10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Tilawah',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                      )),
                  Container(
                      height: 41,
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.grey.shade400, // Warna border
                          width: 2.0, // Lebar border
                        ),
                      ),
                      child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Ayat 16 - 25',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                      )),
                  Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 10),
                      child: Text(
                        'Jumlah Siswa yang di beri tugas',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade400,
                          fontSize: 18,
                        ),
                      )),
                  Container(
                    height: 41,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.grey.shade300, // Warna border
                        width: 2.0, // Lebar border
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Text(
                            '16',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              color: Colors.grey.shade400,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: const Icon(
                            Icons.error_outline,
                            color: Color(0xffFFC700),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
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
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 15),
                              child: Icon(
                                Icons.list,
                                color: AppColor.primary,
                              ),
                            ),
                            Text(
                              'Tugas',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              CupertinoIcons.clock_fill,
                              size: 15,
                              color: Colors.black,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '1/03/2023',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, left: 20, bottom: 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Murajadah',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Container(
                      height: 41,
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.grey.shade400, // Warna border
                          width: 2.0, // Lebar border
                        ),
                      ),
                      child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Ayat 1 - 15',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                      )),
                  Container(
                      margin: const EdgeInsets.only(top: 10, left: 20, bottom: 10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Ziyadah',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                      )),
                  Container(
                      height: 41,
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.grey.shade400, // Warna border
                          width: 2.0, // Lebar border
                        ),
                      ),
                      child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Ayat 16 - 25',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                      )),
                  Container(
                      margin: const EdgeInsets.only(top: 10, left: 20, bottom: 10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Tilawah',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                      )),
                  Container(
                      height: 41,
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.grey.shade400, // Warna border
                          width: 2.0, // Lebar border
                        ),
                      ),
                      child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Ayat 16 - 25',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                      )),
                  Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 10),
                      child: Text(
                        'Jumlah Siswa yang di beri tugas',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade400,
                          fontSize: 18,
                        ),
                      )),
                  Container(
                    height: 41,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.grey.shade300, // Warna border
                        width: 2.0, // Lebar border
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Text(
                            '3',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              color: Colors.grey.shade400,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: const Icon(
                            Icons.error_outline,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
