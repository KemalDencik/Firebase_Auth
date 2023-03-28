import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:messages/widget/contoller/userController.dart';
import 'package:messages/pages/accont.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool sifre_goster = true;
  final TextEditingController _Email = TextEditingController();
  final TextEditingController _Sifre = TextEditingController();
  UserController? userController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    userController = Get.put(UserController(), tag: 'auth');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              width: size.width,
              height: size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("asset/images/kayitol.jpg"),
                    fit: BoxFit.cover),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 3,
                  sigmaY: 3,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 60,
                          child: Image.asset("asset/images/applogo.png")),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(50, 50, 50, 20),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.white),
                        controller: _Email,
                        key: const ValueKey('Email'),
                        validator: (email) {
                          if (email!.isEmpty || !email.contains('@')) {
                            return "Geçerli e mail giriniz.";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: const Text(
                            "E-mail",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              width: 2,
                              color: Colors.white,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              width: 2,
                              color: Colors.white,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              width: 2,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(50, 10, 50, 30),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.white),
                        controller: _Sifre,
                        obscureText: sifre_goster,
                        key: const ValueKey('Şifre'),
                        validator: (password) {
                          if (password!.isEmpty) {
                            return "Lütfen şifre giriniz.";
                          } else if (password.length < 6) {
                            return "Lütfen 6 karakterden fazla giriniz";
                          }
                          return null;
                        },
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          label: const Text(
                            "Şifre",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              width: 2,
                              color: Colors.white,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              width: 2,
                              color: Colors.white,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              width: 2,
                              color: Colors.white,
                            ),
                          ),
                          suffixIcon: IconButton(
                            onPressed: (() {
                              setState(() {
                                sifre_goster = !sifre_goster;
                              });
                            }),
                            icon: Icon(
                              sifre_goster ? Icons.remove_red_eye : Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            userController!.logIn(_Email.text, _Sifre.text);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Colors.red,
                                  Colors.red,
                                ]),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: size.height / 20,
                          width: size.width / 1.9,
                          child: Center(
                            child: Text(
                              'Giriş Yap',
                              style: GoogleFonts.bebasNeue(
                                  color: Colors.black, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => Get.to(() => const Account(),
                          transition: Transition.cupertino,
                          duration: Duration(milliseconds: 500)),
                      child: const Text(
                        "Kayıt ol",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
