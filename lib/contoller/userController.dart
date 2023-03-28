import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messages/pages/loginpages.dart';
import 'package:messages/models/userModel.dart';
import 'package:messages/pages/kategori.dart';

class UserController extends GetxController {
  final emailController = TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Rx selectedindex = 0.obs;

  Future<User?> createUser(
    UserModel userModel,
    String password,
  ) async {
    try {
      User? user = (await _firebaseAuth
          .createUserWithEmailAndPassword(
        email: userModel.email!,
        password: password,
      )
          .then((value) async {
        userModel.userId = value.user!.uid;
        await _firestore.collection("kullanici").doc(userModel.userId).set({
          "telefon": userModel.telefon,
          "isim": userModel.isim,
          "email": userModel.email,
          "token": userModel.token,
        });
        _firebaseAuth.currentUser!.sendEmailVerification();
        return null;
      }));

      debugPrint("KULLANICI KAYIT EDİLDİ");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  baglantial(
    UserModel userModel,
  ) async {
    await _firestore.collection("kullanici").doc(userModel.userId).get(
          userModel.telefon as GetOptions?,
        );
  }

  Future<User?> logIn(String email, String password) async {
    try {
      User? user = (await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;

      if (user != null && _firebaseAuth.currentUser!.emailVerified) {
        debugPrint("Login Succesfull.");
        Get.offAll(() => const KategoriPage());
        return user;
      } else {
        await _firebaseAuth.signOut();
        Get.rawSnackbar(
          onTap: (snack) {},
          snackStyle: SnackStyle.GROUNDED,
          titleText: const Icon(Icons.notification_important),
          messageText: const Center(child: Text("Mailinizi Onaylamalısınız !")),
          duration: const Duration(seconds: 3),
          borderRadius: 20,
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      Get.rawSnackbar(
        titleText: const Icon(Icons.notification_important),
        messageText:
            const Center(child: Text("Şifre/Kullanıcı adı kontrol ediniz ")),
        duration: const Duration(seconds: 3),
        borderRadius: 20,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.TOP,
      );

      return null;
    }
    return null;
  }

  logOut() async {
    try {
      Get.rawSnackbar(
        titleText: const Icon(Icons.all_inclusive_sharp),
        messageText: const Center(child: Text("Tekrardan görüşmek dileğiyle ")),
        duration: const Duration(seconds: 3),
        borderRadius: 20,
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.TOP,
      );
      await _firebaseAuth
          .signOut()
          .then((value) => Get.offAll(() => const LoginPage()));
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
