import 'package:flutter/material.dart';
import 'package:flutter_quran_yt/constants/constants.dart';
import 'package:flutter_quran_yt/controllers/loginController.dart';
import 'package:flutter_quran_yt/controllers/registrationController.dart';
import 'package:flutter_quran_yt/widgets/decoration_widget.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({Key? key}) : super(key: key);

   LoginController _loginController = Get.put(LoginController());

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
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 38, left: 8, right: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Form(
                      key: _loginController.formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: TextFormField(
                              autocorrect: false,
                              keyboardType: TextInputType.emailAddress,
                              // The validator receives the text that the user has entered.
                              controller:
                              _loginController.emailController,
                              onSaved: (value) {
                                _loginController.email = value!;
                              },
                              validator: (value) {
                                return _loginController.validEmail(value!);
                              },
                              decoration: DecorationWidget(context, "Enter Email", Icons.email),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: TextFormField(
                              obscureText: true,
                              controller:
                              _loginController.passwordController,
                              onSaved: (value) {
                                _loginController.password = value!;
                              },
                              validator: (value) {
                                return _loginController
                                    .validPassword(value!);
                              },
                              decoration: DecorationWidget(context, "Enter Password", Icons.vpn_key),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            height: 40,
                            child: TextButton(
                              onPressed: () {
                                //Get.toNamed('/forgetPassword');
                              },
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color: Constants.kPrimary,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
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
                                child: FittedBox(
                                  child: Obx(
                                        () => _loginController
                                        .isLoading.value
                                        ? Center(
                                      child: CircularProgressIndicator(color: Colors.white,),
                                    )
                                        : Text(
                                      'Login',
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  _loginController.login();
                                },
                              ),
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
                  const Text('Don\'t have an account ? '),
                  TextButton(
                    onPressed: () {
                      Get.offNamed('/register');
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(color: Constants.kPrimary),
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
