
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../common/common.dart';

class LoginController extends GetxController{

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

   TextEditingController emailController = TextEditingController();
   TextEditingController passwordController = TextEditingController();

  var email = '';
  var password = '';
  var isLoading = false.obs;
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  String? validEmail(String value) {
    if (!GetUtils.isEmail(value.trim())) {
      return "Please Provide Valid Email";
    }
    return null;
  }

  String? validPassword(String value) {
    if (value.length < 6) {
      return "Password must be of 6 characters";
    }
    return null;
  }

  Future<void> login() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    isLoading.value = true;

    formKey.currentState!.save();

    try {
      await _auth
          .signInWithEmailAndPassword(
          email: email.trim(), password: password.trim())
          .then((value) async {
        if (value != null) {
          User? user = FirebaseAuth.instance.currentUser;
          if (!user!.emailVerified) {
            snackMessage('please verify email first');
            return;
          }
          Get.offAllNamed('/main');
        } else {
           snackMessage("User not found");
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        snackMessage("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        snackMessage("Wrong password provided for that user.");
      }
    } catch (e) {
      print(e);
    }
    isLoading.value = false;
  }

}