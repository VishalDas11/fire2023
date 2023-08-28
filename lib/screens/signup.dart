import 'dart:developer';

import 'package:fire2023/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailCotroller = TextEditingController();

  final passControler = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  final auth = FirebaseAuth.instance;

  Future signp() async {
    if (_formkey.currentState!.validate()) {
      auth
          .createUserWithEmailAndPassword(
              email: emailCotroller.text, password: passControler.text)
          .then((value) {
        log("value : " + value.toString());
        log("User Created Successfully");
        Get.to(() => LoginScreen());
      }).onError((error, stackTrace) {
        log(error.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: "Sign UP".text.make()),
      body: Form(
        key: _formkey,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
              )..pOnly(bottom: 10),
              TextFormField(
                controller: emailCotroller,
                decoration: InputDecoration(
                  hintText: "Enter Email ",
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: passControler,
                decoration: InputDecoration(
                  hintText: "Enter Password ",
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    signp();
                  },
                  child: "SignUp".text.make())
            ]),
      ).px(30),
    );
  }
}
