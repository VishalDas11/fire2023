import 'dart:developer';

import 'package:fire2023/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final auth = FirebaseAuth.instance;

  Future logout() async {
    await auth.signOut().then((value) {
      Get.to((LoginScreen));
      log("Logout Scccessfully");
    }).onError((error, stackTrace) {
      log('error: ' + error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "HomeScreen".text.make(),
        actions: [
          GestureDetector(
              onTap: () {
                Get.to(() => LoginScreen());
              },
              child: Icon(Icons.logout))
          // Icon(Icons.logout_outlined).onTap(() {
          //   logout();
          // }).px(20)
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: ["Welocome To HomeSceen".text.make().centered()],
      ),
    );
  }
}
