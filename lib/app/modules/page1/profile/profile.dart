// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:walikelas_ummar/app/core/all/user_client.dart';
import 'package:walikelas_ummar/app/core/authentication/authenticate_client.dart';
import 'package:walikelas_ummar/app/modules/page%20interface/login/login.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Body(),
      ),
    );
  }
}

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  // @override
  // void initState() {
  //   super.initState();
  //   fetchUsers();
  // }

  final AuthenticateApi _api = AuthenticateApi();
  final UserApi userApi = UserApi();

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

  // function for api logout
  void logoutUsers() async{
    String token = await getToken() ?? '';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Dalam Proses'),
        backgroundColor: Colors.blue.shade300,
      ),
    );

    try{
      // final response = await _api.logout(token);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear();
      preferences.setBool("checked", true);

      // if (response.statusCode == 200) {
      //   SharedPreferences preferences = await SharedPreferences.getInstance();
      //   await preferences.clear();

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Berhasil logout'),
            backgroundColor: Colors.green.shade300,
          ),
        );
      // } else {
      //    ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(
      //       content: Text('Error: ${response.data['message']}'),
      //       backgroundColor: Colors.red.shade300,
      //     ),
      //   );
      // }
    } catch (e){
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red.shade300,
        ),
      );
    }
  }

  // function for api fetch data user
  Future<Map<String, dynamic>> fetchUsers() async{
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

  // function for api update data
  void updateUsers (String name, String? phone, String address, String image) async{
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Dalam Proses'),
        backgroundColor: Colors.blue.shade300,
      ),
    );

    try {
      String token = await getToken() ?? '';
      String telp = phone ?? "0";
      final response = await userApi.updateData(
        token, name, telp, address, image
      );

      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${response.data['message']}'),
            backgroundColor: Colors.green.shade300,
          ),
        );
      } else {
         ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${response.data['message']}'),
            backgroundColor: Colors.red.shade300,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red.shade300,
        ),
      );
    }
  }

  String nama = 'Budiono';
  String name = 'Budiono';


  Future<void> _pickFile() async {
    final selectedFile = await FilePicker.platform.pickFiles();
    if (selectedFile == null || selectedFile.files.isEmpty) {
      // User tidak memilih file
      return;
    }

    final filePath = selectedFile.files.first.path;
    if (filePath == null) {
      // Path file null
      return;
    }

    setState(() {});

    // Lakukan proses upload file ke server di sini
  }

  @override
  Widget build(BuildContext context) {
    return
    FutureBuilder(
      future: fetchUsers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if(snapshot.hasData) {
          Map<String, dynamic>? userData = snapshot.data;
          return LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return Column(children: [
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
                      horizontal: constraints.maxWidth * 0.1,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Profil Wali Kelas',
                              style: TextStyle(
                                color: Color.fromARGB(255, 5, 5, 5),
                                fontWeight: FontWeight.w700,
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 75),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person,
                              size: 150,
                              color: Colors.grey.shade500,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    color: const Color(0xffD9D9D9),
                    child: Container(
                      height: constraints.maxHeight *
                          0.6, // Menggunakan proporsi tinggi responsif
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
                            padding: const EdgeInsets.only(top: 30, left: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/logos/person.png',
                                      width: 20,
                                      height: 20,
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Nama',
                                          style: GoogleFonts.poppins(
                                            color: const Color.fromARGB(255, 7, 7, 7),
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              userData!['data']['name'] ?? '',
                                              style: GoogleFonts.poppins(
                                                color: Colors.grey,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(width: 20),
                                            GestureDetector(
                                              onTap: () {
                                                showModalBottomSheet(
                                                  context: context,
                                                  shape: const RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(30),
                                                      topRight: Radius.circular(30),
                                                    ),
                                                  ),
                                                  builder: (BuildContext context) {
                                                    String editedNama = "";

                                                    return Container(
                                                      height: 300,
                                                      padding:
                                                          const EdgeInsets.all(20),
                                                      child: Column(
                                                        children: [
                                                          const Text(
                                                            'Edit Nama',
                                                            style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                            ),
                                                          ),
                                                          const SizedBox(height: 20),
                                                          TextField(
                                                            decoration:
                                                                InputDecoration(
                                                              labelText: 'Nama',
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(10),
                                                              ),
                                                            ),
                                                            onChanged: (value) {
                                                              editedNama = value;
                                                            },
                                                          ),
                                                          const SizedBox(height: 20),
                                                          ElevatedButton(
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(10),
                                                              ),
                                                              primary: Colors.orange,
                                                            ),
                                                            onPressed: () {
                                                              setState(() {
                                                                updateUsers(
                                                                  editedNama, 
                                                                  userData['data']['phone'], 
                                                                  userData['data']['address'], 
                                                                  userData['data']['profile_image']
                                                                );
                                                              });
                                                              Navigator.pop(context);
                                                            },
                                                            child: const Text(
                                                              'Simpan',
                                                              style: TextStyle(
                                                                color: Colors.white,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              child: const Icon(
                                                Icons.edit,
                                                color: Colors.orange,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Align(
                                  // alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(20),
                                          ),
                                        ),
                                        context: context,
                                        builder: (BuildContext context) {
                                          return SizedBox(
                                            height: 200,
                                            child: Padding(
                                              padding: const EdgeInsets.only(top: 50),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceAround,
                                                children: [
                                                  Column(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          // Mengaktifkan kamera
                                                          ImagePicker()
                                                              .getImage(
                                                            source:
                                                                ImageSource.camera,
                                                          )
                                                              .then((pickedFile) {
                                                            if (pickedFile == null)
                                                              // ignore: curly_braces_in_flow_control_structures
                                                              return;
                                                            setState(() {});
                                                          });
                                                        },
                                                        child: Image.asset(
                                                          'assets/pop/kamera.png',
                                                          width: 50,
                                                          height: 50,
                                                        ),
                                                      ),
                                                      const Text('Kamera'),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: _pickFile,
                                                        child: Image.asset(
                                                          'assets/pop/file.png',
                                                          width: 50,
                                                          height: 50,
                                                        ),
                                                      ),
                                                      const Text('File'),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.grey.shade300,
                                          ),
                                          child: Icon(
                                            Icons.person,
                                            size: 30,
                                            color: Colors.grey.shade400,
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: Container(
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.orange),
                                            child: const Padding(
                                              padding: EdgeInsets.all(5.0),
                                              child: Icon(
                                                Icons.camera_alt,
                                                size: 15,
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
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15, left: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/logos/phone.png',
                                      width: 20,
                                      height: 20,
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Telephone',
                                          style: GoogleFonts.poppins(
                                            color: const Color.fromARGB(255, 7, 7, 7),
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              userData['data']['phone'] ?? '+62',
                                              style: GoogleFonts.poppins(
                                                color: Colors.grey,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(width: 20),
                                            GestureDetector(
                                              onTap: () {
                                                showModalBottomSheet(
                                                  context: context,
                                                  shape: const RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(30),
                                                      topRight: Radius.circular(30),
                                                    ),
                                                  ),
                                                  builder: (BuildContext context) {
                                                    String editedTelp = userData['data']['phone'] ?? '0';

                                                    return Container(
                                                      height: 300,
                                                      padding:
                                                          const EdgeInsets.all(20),
                                                      child: Column(
                                                        children: [
                                                          const Text(
                                                            'Edit Telephon',
                                                            style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                            ),
                                                          ),
                                                          const SizedBox(height: 20),
                                                          TextField(
                                                            decoration:
                                                                InputDecoration(
                                                              labelText: 'Telephon',
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(10),
                                                              ),
                                                            ),
                                                            onChanged: (value) {
                                                              editedTelp = value;
                                                            },
                                                          ),
                                                          const SizedBox(height: 20),
                                                          ElevatedButton(
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(10),
                                                              ),
                                                              primary: Colors.orange,
                                                            ),
                                                            onPressed: () {
                                                              setState(() {
                                                                updateUsers(
                                                                  userData['data']['name'], 
                                                                  editedTelp, 
                                                                  userData['data']['address'], 
                                                                  userData['data']['profile_image']
                                                                );
                                                              });
                                                              Navigator.pop(context);
                                                            },
                                                            child: const Text(
                                                              'Simpan',
                                                              style: TextStyle(
                                                                color: Colors.white,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              child: const Icon(
                                                Icons.edit,
                                                color: Colors.orange,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15, left: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/logos/home.png',
                                      width: 20,
                                      height: 20,
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Alamat',
                                          style: GoogleFonts.poppins(
                                            color: const Color.fromARGB(255, 7, 7, 7),
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              userData['data']['address'] ?? '',
                                              style: GoogleFonts.poppins(
                                                color: Colors.grey,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(width: 20),
                                            GestureDetector(
                                              onTap: () {
                                                showModalBottomSheet(
                                                  context: context,
                                                  shape: const RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(30),
                                                      topRight: Radius.circular(30),
                                                    ),
                                                  ),
                                                  builder: (BuildContext context) {
                                                    String editedAlamat = userData['data']['address'];

                                                    return Container(
                                                      height: 300,
                                                      padding:
                                                          const EdgeInsets.all(20),
                                                      child: Column(
                                                        children: [
                                                          const Text(
                                                            'Edit Alamat',
                                                            style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                            ),
                                                          ),
                                                          const SizedBox(height: 20),
                                                          TextField(
                                                            decoration:
                                                                InputDecoration(
                                                              labelText: 'Alamat',
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(10),
                                                              ),
                                                            ),
                                                            onChanged: (value) {
                                                              editedAlamat = value;
                                                            },
                                                          ),
                                                          const SizedBox(height: 20),
                                                          ElevatedButton(
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(10),
                                                              ),
                                                              primary: Colors.orange,
                                                            ),
                                                            onPressed: () {
                                                              setState(() {
                                                                updateUsers(
                                                                  userData['data']['name'], 
                                                                  userData['data']['phone'], 
                                                                  editedAlamat, 
                                                                  userData['data']['profile_image']
                                                                );
                                                              });
                                                              Navigator.pop(context);
                                                            },
                                                            child: const Text(
                                                              'Simpan',
                                                              style: TextStyle(
                                                                color: Colors.white,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              child: const Icon(
                                                Icons.edit,
                                                color: Colors.orange,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 24,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: constraints.maxWidth *
                                0.8, // Menggunakan proporsi lebar responsif
                            child: Container(
                              height: 30,
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Color(0xff8F4552),
                                    width: 2.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15, left: 37),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        logoutUsers();
                                      },
                                      child: Text(
                                        'Log Out',
                                        style: GoogleFonts.poppins(
                                          color: const Color(0xff8F4552),
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ]);
          });
        } else {
          return const Text('Tidak ada data');
        }
      },
    );
  }
}
