import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:walikelas_ummar/app/core/authentication/authenticate_client.dart';
import 'package:walikelas_ummar/app/modules/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../forgotlogin/forgotlogin.dart';

class Login extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const Login({Key? key});

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
class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthenticateApi _api = AuthenticateApi();

  void dataUsers(String token, String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    prefs.setString('email', email);
    prefs.setString('password', password);
    // prefs.setString('name', userData['name']);
    // prefs.setString('username', userData['username']);
    // prefs.setString('email', userData['email']);
    // prefs.setString('image', userData['profile_image']);
    // prefs.setString('agama', userData['agama']);
    // prefs.setString('phone', userData['phone'] ?? '');
    // prefs.setString('address', userData['address']);

    // List<String> userJsonList = [jsonEncode(userData)];
    // prefs.setStringList("User", userJsonList);
  } 

  void loginUsers () async{
    final String email = emailController.text;
    final String password = passwordController.text;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Dalam Proses'),
        backgroundColor: Colors.blue.shade300,
      ),
    );

    try {
      final response = await _api.login(email, password);

      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (response.statusCode == 200) {
        String accessToken = response.data['data']['accessToken'];
        // Map<String, dynamic> user = response.data['data']['user'];
        dataUsers(accessToken, email, password);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
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
  
  Future<bool> checkLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('token') &&
        prefs.containsKey('email') &&
        prefs.containsKey('password');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: checkLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasData && snapshot.data!) {
          return Home();
        } else {
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
                          horizontal: constraints.maxWidth * 0.15,
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: constraints.maxHeight * 0.1,
                            ),
                            Image.asset(
                              'assets/images/logoummar.png',
                              width: constraints.maxWidth,
                              height: constraints.maxHeight * 0.3,
                              fit: BoxFit.contain,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      color: const Color(0xffD9D9D9),
                      child: Container(
                        height: constraints.maxHeight * 0.6,
                        width: constraints.maxWidth,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(50),
                            topLeft: Radius.circular(50),
                          ),
                          color: Color(0xffF9F9F9),
                        ),
                        child: Column(children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 50,
                              ),
                              Text(
                                'Assalamualaikum,',
                                style: GoogleFonts.poppins(
                                  fontSize: 24,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                'Silahkan masuk dengan akun anda,',
                                style: GoogleFonts.poppins(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: constraints.maxWidth * 0.75,
                                // height: 60,
                                decoration: BoxDecoration(
                                  color: const Color(0xffEFEFEF),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1.0,
                                  ),
                                ),
                                child: TextField(
                                  controller: emailController,
                                  decoration: const InputDecoration(
                                    hintText: 'Email',
                                    contentPadding: EdgeInsets.only(
                                      left: 10,
                                    ),
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              SizedBox(height: constraints.maxHeight * 0.02),
                            ],
                          ),
                          Container(
                            width: constraints.maxWidth * 0.75,
                            decoration: BoxDecoration(
                              color: const Color(0xffEFEFEF),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                            child: PasswordTextField(passwordController: passwordController),
                          ),
                          SizedBox(height: constraints.maxHeight * 0.02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 50),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ForgotLogin()),
                                      );
                                    },
                                    child: Text(
                                      'Lupa Password?',
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: constraints.maxHeight * 0.02),
                          GestureDetector(
                            onTap: () {
                              loginUsers();
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
                                  'Masuk',
                                  style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        }
      },
    );
  }
}

// ignore: use_key_in_widget_constructors
class PasswordTextField extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  final TextEditingController passwordController;
  PasswordTextField({required this.passwordController});

  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;


  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.passwordController,
      obscureText: _obscureText,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
          onPressed: _togglePasswordVisibility,
        ),
        hintText: 'Password',
        contentPadding: EdgeInsets.all(10),
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w500,
        ),
        border: InputBorder.none,
      ),
    );
  }
}
