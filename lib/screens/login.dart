import 'dart:developer';

import 'package:fire2023/screens/homescreen.dart';
import 'package:fire2023/screens/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final emailCotroller = TextEditingController();
  final passControler = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;

  Future login() async {
    if (_formkey.currentState!.validate()) {
      await auth
          .signInWithEmailAndPassword(
              email: emailCotroller.text, password: passControler.text)
          .then((value) {
        log("Login Successfully");
        Get.to(() => HomeScreen());
      }).onError((error, stackTrace) {
        log(error.toString());
      });
    }
  }

  signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    log("credential: " + credential.toString());

    // Once signed in, return the UserCredential
    // return await FirebaseAuth.instance.signInWithCredential(credential);
    auth.signInWithCredential(credential).then((value) {
      if (auth.currentUser != null) {
        Get.to(() => HomeScreen());
        log("Sign in successfully");
      }
      log("value" + value.toString());
      Get.to(() => HomeScreen());
    }).onError((error, stackTrace) {
      log("eror :" + error.toString());
    });
  }

//   signInWithFacebook() async {
//   // Trigger the sign-in flow
//   final LoginResult loginResult = await FacebookAuth.instance.login();

//   // Create a credential from the access token
//   final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken.token);

//   // Once signed in, return the UserCredential
//   // return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
// }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkey,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: double.infinity,
              ).pOnly(bottom: 10),
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
                        login();
                      },
                      child: "Login".text.make())
                  .pOnly(bottom: 30),
              "Don't havean account? SignUp".text.purple400.make().onTap(() {
                Get.to(SignUpScreen());
              }),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        signInWithGoogle();
                      },
                      child: "Google".text.make()),
                  ElevatedButton(
                      onPressed: () {}, child: "Facebook".text.make()),
                  ElevatedButton(onPressed: () {}, child: "Apple".text.make()),
                ],
              )
            ]).px(30),
      ),
    );
  }
}
