import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meditransparency/data/constants/styles.dart';
import 'package:meditransparency/data/dataflow/devicestorage.dart';
import 'package:meditransparency/data/dataflow/models/loginmodel.dart';
import 'package:meditransparency/utils/widgets/button.dart';
import 'package:meditransparency/data/constants/colors.dart';
import 'package:meditransparency/utils/widgets/inputfields/inputtextfield.dart';
import 'package:meditransparency/utils/widgets/loader.dart';

import '../../../data/dataflow/integration_apis.dart';
import '../../widgets/inputfields/inputpassfield.dart';
import '../../widgets/reusable_text.dart';
import 'package:flutter_svg/svg.dart';

import '../../widgets/toastmsg.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  bool _passwordVisible = true;
  bool _isloading = false;
  var _errmsg = '';
  var _iserr = false;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
      if (_googleSignIn.currentUser != null) {
        print('User Data:');
        print('Display Name: ${_googleSignIn.currentUser!.displayName}');
        print('Email: ${_googleSignIn.currentUser!.email}');
        print('Photo URL: ${_googleSignIn.currentUser!.photoUrl}');
        setState(() {
          _iserr = true;
          _errmsg = _googleSignIn.currentUser!.email;
        });
      }
    } catch (error) {
      print('Error signing in: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(25),
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              text(
                "Sign In",
                ui.blackclr,
                35.0,
                FontWeight.w500,
              ),
              SizedBox(
                height: 25,
              ),
              text("Sign in using your phone number or by a given social login",
                  ui.greyclr, 15, FontWeight.w500,
                  align: TextAlign.center),
              _iserr
                  ? SizedBox(
                      height: 20,
                    )
                  : SizedBox(
                      height: 0,
                    ),
              text(_errmsg, ui.errclr, 15, FontWeight.w500,
                  align: TextAlign.center),
              SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  text(
                    "Phone Number",
                    ui.greyclr,
                    15,
                    FontWeight.w500,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: SizedBox(
                    height: 50,
                    child: Inputnumfield('', context, () {},
                        controller: _phoneController, autofocus: true)),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  text(
                    "Password",
                    ui.greyclr,
                    15,
                    FontWeight.w500,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: SizedBox(
                  height: 50,
                  child:
                      Inputpassfield('Password', _passwordVisible, context, () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  }, controller: _passwordController),
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap:_isloading? (){} : (){
                      final snackBar = SnackBar(
                          content: Text('Forgot password is Disabled for Doctors'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    child: text(
                      "Forget Password ?",
                      ui.primarylightclr,
                      15,
                      FontWeight.w500,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              _isloading
                  ? loading()
                  : nextorcontinuebtn(
                      context: context,
                      tex: 'Next',
                      style: fontstyles().style,
                      function: () async {
                        if (RegExp(r'^[0-9]{10}$')
                                .hasMatch(_phoneController.text) &&
                            _passwordController.text.length >= 6) {
                          // Process data
                          _errmsg = '';
                          _iserr = false;
                          _isloading = true;
                          setState(() {});
                          final response = await login_in(
                              _phoneController.text, _passwordController.text);
                          // print("response is :" + response.toString());
                          if (response['success'] == false) {
                            setState(() {
                              _isloading = false;
                              _errmsg = response['msg'];
                              _iserr = true;
                            });
                            // Toastmsg(msg: response['msg']);
                          } else {
                            LoginResponse loginResponse =
                                LoginResponse.fromJson(response);
                            StorageManager.saveData(
                                'token', loginResponse.token);
                            StorageManager.readData('token').then((value)async {
                              print("stored token was :" + value);

                              final doctor = await doctordetails();
                              print("doctor details are :" + doctor.toString());


                              StorageManager.saveData(
                                'doctor_basic_info', doctor);

                                
                              Navigator.pushReplacementNamed(
                                  context, '/choosehospital');
                            });
                          }
                          _isloading = false;
                          setState(() {});
                          // print('Phone Number: ${_phoneController.text}');
                          // print('Password: ${_passwordController.text}');
                          // setState(() {});
                        } else {
                          _errmsg =
                              'Password too short or Invalid Phone Number';
                          _iserr = true;
                          setState(() {});
                        }
                      }),
              _isloading ? SizedBox(height: 150) : 
              Column(
                children: [
              Padding(
              padding: const EdgeInsets.only(top: 45.0),
              child: Row(children: <Widget>[
                Expanded(
                    child: Divider(
                  color: ui.greyclr,
                  thickness: 1.5,
                )),
                Text(
                  " Or sign in with ",
                  style: TextStyle(color: Colors.black38),
                ),
                Expanded(
                    child: Divider(
                  color: ui.greyclr,
                  thickness: 1.5,
                )),
              ]),
                            ),
                            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    child: SvgPicture.asset(
                      'assets/svgs/google.svg',
                    ),
                    onTap: () {
                      _handleSignIn();
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SvgPicture.asset(
                    'assets/svgs/facebook.svg',
                  ),
                ],
              ),
                            ),
                            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  text(
                    "Don’t have an account? ",
                    ui.blackclr,
                    12,
                    FontWeight.w500,
                  ),
                  InkWell(
                    child: text(
                      " Sign Up",
                      ui.primarylightclr,
                      12,
                      FontWeight.w500,
                    ),
                    onTap: () {
                      final snackBar = SnackBar(
                          content: Text('Signup is not Allowed for Doctors'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                  )
                ],
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
}
