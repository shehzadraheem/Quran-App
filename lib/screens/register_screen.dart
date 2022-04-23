import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quran_yt/constants/constants.dart';
import 'package:flutter_quran_yt/controllers/registrationController.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../widgets/decoration_widget.dart';

class RegisterScreen extends StatelessWidget {

  RegisterController  _registrationController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: height * 0.3,
                    decoration: BoxDecoration(
                      color: Constants.kPrimary,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(70),
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.person,
                        size: 90,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Positioned(
                    bottom: 40,
                    right: 30,
                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Form(
                      key: _registrationController.formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              // The validator receives the text that the user has entered.
                              controller:
                                  _registrationController.nameController,
                              onSaved: (value) {
                                _registrationController.name = value!;
                              },
                              validator: (value) {
                                return _registrationController
                                    .validName(value!);
                              },
                              decoration: DecorationWidget(
                                  context,
                                  "User Name",
                                  Icons.person),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              autocorrect: false,
                              keyboardType: TextInputType.emailAddress,
                              // The validator receives the text that the user has entered.
                              controller:
                                  _registrationController.emailController,
                              onSaved: (value) {
                                _registrationController.email = value!;
                              },
                              validator: (value) {
                                return _registrationController
                                    .validEmail(value!);
                              },
                              decoration: DecorationWidget(
                                  context, "Email", Icons.email),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                                obscureText: true,
                                controller:
                                    _registrationController.passwordController,
                                onSaved: (value) {
                                  _registrationController.password = value!;
                                },
                                validator: (value) {
                                  return _registrationController
                                      .validPassword(value!);
                                },
                                decoration: DecorationWidget(
                                    context, "Password", Icons.vpn_key)),
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 5,
                                primary: Constants.kPrimary,
                                onPrimary: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 10),
                                textStyle: const TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'CormorantGaramond'),
                              ),
                              child: _registrationController.isLoading.value
                                  ? SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 3,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      ),
                                    )
                                  : FittedBox(
                                      child: Obx(
                                        () => _registrationController
                                                .isLoading.value
                                            ? Center(
                                                child:
                                                    CircularProgressIndicator(color: Colors.white,),
                                              )
                                            : Text(
                                                'Register',
                                              ),
                                      ),
                                    ),
                              onPressed: () {
                                _registrationController.registration();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text('Already have an account ? '),
                  TextButton(
                    onPressed: () {
                      // FirebaseServices op = FirebaseServices();
                      // op.signOut();
                      Get.offAllNamed('/login');
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                          color: Constants.kPrimary, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


}

