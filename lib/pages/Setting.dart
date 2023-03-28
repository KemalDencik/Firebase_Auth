import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:messages/models/userModel.dart';
import 'package:messages/widget/contoller/userController.dart';
import 'package:messages/widget/setting.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  UserController? userController;
  File? _photo;
  FirebaseAuth auth = FirebaseAuth.instance;
  String? indirme;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    userController = Get.put(UserController(), tag: 'auth');
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => baglantiala());
  }

  baglantiala() async {
    String baglanti = (await FirebaseStorage.instance
        .ref()
        .child('resimler')
        .child(auth.currentUser!.uid)
        .child('profilresmi.png')
        .getDownloadURL());

    setState(() {
      indirme = baglanti;
    });
  }

  kameradanyukle() async {
    // ignore: deprecated_member_use
    var alinandosya = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      _photo = File(alinandosya!.path);
    });

    Reference referansyol = FirebaseStorage.instance
        .ref()
        .child('resimler')
        .child(auth.currentUser!.uid)
        .child('profilresmi.png');

    UploadTask yukleme = referansyol.putFile(_photo!);
    String url = await (await yukleme.whenComplete(
      () {},
    ))
        .ref
        .getDownloadURL();
    setState(() {
      indirme = url;
    });
  }

  galeridenyukle() async {
    // ignore: deprecated_member_use
    var alinandosya = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _photo = File(alinandosya!.path);
    });
    Reference referansyol = FirebaseStorage.instance
        .ref()
        .child('resimler')
        .child(auth.currentUser!.uid)
        .child('profilresmi.png');

    UploadTask yukleme = referansyol.putFile(_photo!);
    String url = await (await yukleme.whenComplete(
      () {},
    ))
        .ref
        .getDownloadURL();
    setState(() {
      indirme = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 92, 92, 92),
          title: const Text(
            "Ayarlar",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 32,
              ),
              indirme == null
                  ? const CircleAvatar(
                      radius: 55,
                      backgroundColor: Color.fromARGB(255, 163, 162, 162),
                      child: Text("resim yok"))
                  : ClipOval(
                      child: Image.network(
                        indirme!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
              Center(
                child: MaterialButton(
                  color: Colors.red,
                  child: const Text("resim yükle"),
                  onPressed: () {
                    _showPicker(context);
                  },
                ),
              ),
              const SettingWid(
                text: ("isim"),
                icon: Icons.person,
              ),
              const SettingWid(
                text: ("telefon"),
                icon: Icons.numbers,
              ),
              const SettingWid(
                text: ("email"),
                icon: Icons.email,
              ),
              Row(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 50, right: 100, left: 50),
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black,
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset:
                                  Offset(2, 2), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 92, 92, 92),
                        ),
                        child: Row(
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Icon(
                                Icons.account_circle,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Düzenle",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50, right: 30),
                    child: InkWell(
                      onTap: () async {
                        await userController!.logOut();
                      },
                      child: Container(
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black,
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset:
                                  Offset(2, 2), // changes position of shadow
                            ),
                          ],
                          color: const Color.fromARGB(255, 92, 92, 92),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "çıkış",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Gallery'),
                  onTap: () {
                    galeridenyukle();
                    Get.back();
                  }),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  kameradanyukle();
                  Get.back();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
