import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:messages/models/userModel.dart';
import 'package:messages/widget/contoller/userController.dart';
import 'loginpages.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final TextEditingController _isim = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _sifre = TextEditingController();
  final TextEditingController _telefon = TextEditingController();

  UserController? userController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    userController = Get.find(tag: 'auth');
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _sifre.dispose();
    _isim.dispose();
    _telefon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 74, 74, 74),
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
                  children: [
                    SizedBox(
                      height: size.height / 20,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: size.width / 1.0,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.red,
                        ),
                        iconSize: 40,
                        onPressed: () => Get.to(const LoginPage()),
                      ),
                    ),
                    SizedBox(
                      height: size.height / 60,
                    ),
                    SizedBox(
                      width: size.width / 1.4,
                      child: const Text(
                        "Kayıt Ol",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                    ),
                    SizedBox(
                      width: size.width / 1.4,
                      child: const Text(
                        "Lütfen bilgileri doldurunuz!",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height / 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(50, 10, 50, 0),
                      child: TextFormField(
                        key: const ValueKey('isim'),
                        validator: (isim) {
                          if (isim!.isEmpty) {
                            return "Lütfen isim giriniz.";
                          } else if (isim.length < 3) {
                            return "İki karakterden fazla giriniz.";
                          }
                          return null;
                        },
                        style: const TextStyle(color: Colors.yellow),
                        controller: _isim,
                        cursorColor: Colors.red,
                        decoration: InputDecoration(
                          label: const Text(
                            "İsim",
                            style: TextStyle(
                              color: Colors.yellow,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              width: 4,
                              color: Colors.red,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              width: 2,
                              color: Colors.red,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              width: 2,
                              color: Colors.yellow,
                            ),
                          ),
                          prefixIcon: const Icon(
                            Icons.people,
                            color: Colors.yellow,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(50, 10, 50, 0),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.yellow),
                        controller: _telefon,
                        cursorColor: Colors.yellow,
                        key: const ValueKey('Telefon'),
                        validator: (telefon) {
                          if (telefon!.isEmpty) {
                            return "Lütfen telefon numarası giriniz.";
                          } else if (telefon.length < 10) {
                            return "telefon numarasını tam giriniz.";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: const Text(
                            "Telefon",
                            style: TextStyle(
                              color: Colors.yellow,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              width: 2,
                              color: Colors.red,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              width: 2,
                              color: Colors.red,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              width: 2,
                              color: Colors.yellow,
                            ),
                          ),
                          prefixIcon: const Icon(
                            Icons.phone,
                            color: Colors.yellow,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(50, 10, 50, 0),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.yellow),
                        controller: _email,
                        key: const ValueKey('Email'),
                        validator: (email) {
                          if (email!.isEmpty ||
                              !email.contains('@gmail') &&
                                  !email.contains('@hotmail') &&
                                  !email.contains('@outlook')) {
                            return "Geçerli e mail giriniz.";
                          }
                          return null;
                        },
                        cursorColor: Colors.yellow,
                        decoration: InputDecoration(
                          label: const Text(
                            "Email",
                            style: TextStyle(
                              color: Colors.yellow,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              width: 2,
                              color: Colors.red,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              width: 2,
                              color: Colors.red,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              width: 2,
                              color: Colors.yellow,
                            ),
                          ),
                          prefixIcon: const Icon(
                            Icons.mail,
                            color: Colors.yellow,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(50, 10, 50, 0),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.red),
                        controller: _sifre,
                        cursorColor: Colors.yellow,
                        key: const ValueKey('Şifre'),
                        validator: (password) {
                          if (password!.isEmpty) {
                            return "Lütfen şifre giriniz.";
                          } else if (password.length < 6) {
                            return "Lütfen 6 karakterden fazla giriniz";
                          }

                          return null;
                        },
                        decoration: InputDecoration(
                          label: const Text(
                            "Şifre",
                            style: TextStyle(
                              color: Colors.yellow,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              width: 2,
                              color: Colors.red,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              width: 2,
                              color: Colors.red,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              width: 2,
                              color: Colors.yellow,
                            ),
                          ),
                          prefixIcon: const Icon(
                            Icons.password,
                            color: Colors.yellow,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height / 20,
                    ),
                    customButton(size),
                    SizedBox(height: size.height / 40),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget customButton(Size size) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          if (_formKey.currentState!.validate()) {
            UserModel userModel = UserModel();
            userModel.telefon = _telefon.text;
            userModel.isim = _isim.text;
            userModel.email = _email.text;
            userController!.createUser(
              userModel,
              _sifre.text,
            );

            Get.rawSnackbar(
              titleText: const Icon(Icons.add_task),
              messageText:
                  const Center(child: Text("Kayıt İşleminiz Başarılı ")),
              duration: const Duration(seconds: 3),
              borderRadius: 20,
              backgroundColor: const Color.fromARGB(255, 19, 156, 23),
              snackPosition: SnackPosition.TOP,
            );

            Get.to(() => const LoginPage());
          }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.red,
                  Colors.red,
                ]),
          ),
          height: size.height / 20,
          width: size.width / 1.9,
          child: Center(
            child: Text(
              'KAYIT OL',
              style: GoogleFonts.bebasNeue(color: Colors.black, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }

  Widget field(
    Size size,
    String hintText,
    IconData icon,
    TextEditingController cont,
  ) {
    return SizedBox(
      height: size.height / 15,
      width: size.width / 1.4,
      child: TextField(
        controller: cont,
        decoration: InputDecoration(
            prefixIcon: Icon(icon),
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )),
      ),
    );
  }
}
