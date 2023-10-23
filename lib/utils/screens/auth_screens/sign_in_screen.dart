import 'package:flutter/material.dart';
import 'package:meditransparency/data/constants/styles.dart';
import 'package:meditransparency/utils/widgets/button.dart';
import 'package:meditransparency/data/constants/colors.dart';
import 'package:meditransparency/utils/widgets/inputfields/inputtextfield.dart';

import '../../widgets/inputfields/inputpassfield.dart';
import '../../widgets/reusable_text.dart';
import 'package:flutter_svg/svg.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _passwordVisible = true;
  bool _isloading = false;
  var _errmsg = '';
  var _iserr = false;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
              _iserr? SizedBox(
                height: 30,
              ): SizedBox(
                height: 0,
              ),
              text(_errmsg,
                  ui.errclr, 15, FontWeight.w500,
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
                padding: const EdgeInsets.symmetric(vertical:8),
                child: SizedBox(
                  height: 50,
                  child: Inputnumfield('', context, (){
              
                  },
                  controller:_phoneController,
                  autofocus: true)
                ),
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
                padding: const EdgeInsets.symmetric(vertical:8),
                child: SizedBox(
                  height: 50,
                  child: Inputpassfield(
                              'Password', _passwordVisible, context, () {
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
                  text(
                    "Forget Password ?",
                    ui.primarylightclr,
                    15,
                    FontWeight.w500,
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              nextorcontinuebtn(
                  context: context,
                  tex: 'Next',
                  style: fontstyles().style,
                  function: () {
                    if (RegExp(r'^[0-9]{10}$')
                            .hasMatch(_phoneController.text) &&
                        _passwordController.text.length >= 6) {
                      // Process data
                      print('Phone Number: ${_phoneController.text}');
                      print('Password: ${_passwordController.text}');
                    }
                  }),
              Padding(
                padding: const EdgeInsets.only(top: 45.0),
                child: Row(children: <Widget>[
                  Expanded(
                      child: Divider(
                    color: ui.greyclr,
                    thickness: 1.5,
                  )),
                  Text(
                    " Or sign up with ",
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
                    SvgPicture.asset(
                      'assets/svgs/google.svg',
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
                      Colors.black,
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
                        final snackBar = SnackBar(content:Text('Signup is not Allowed for Doctors'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
