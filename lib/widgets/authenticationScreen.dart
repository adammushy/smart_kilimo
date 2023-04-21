// ignore_for_file: file_names
import 'dart:convert';

import 'package:agric/api.dart';
import 'package:agric/expert/dashboard.dart';
import 'package:agric/farmer/homescreen.dart';
import 'package:agric/widgets/custom_checkbox.dart';
import 'package:agric/widgets/profile_listtile.dart';
import 'package:agric/widgets/theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// *********** Login authentication starts here *****************
class AuthScreen extends StatefulWidget {
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController userNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool passwordVisible = false;
    void togglePassword() {
      setState(() {
        passwordVisible = !passwordVisible;
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/logo1.png',
                        width: 200,
                        height: 200,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Login',
                      style: heading2.copyWith(color: textBlack),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: textWhiteGrey,
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: TextFormField(
                          controller: userNumberController,
                          validator: (value) {
                            if (value!.length != 10)
                              return 'Mobile Number must be of 10 digit';
                            else if (value.length > 10) {
                              return 'mobile number should not exceed 10 digits';
                            } 
                            else
                              return null;
                          },
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: 'Phone Number',
                            hintStyle: heading6.copyWith(color: textGrey),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // CustomCheckbox(),
                    SizedBox(
                      width: 12,
                    ),
                    // Text('Remember me', style: regular16pt),
                  ],
                ),
                // SizedBox(
                //   height: 32,
                // ),
                Material(
                  borderRadius: BorderRadius.circular(14.0),
                  elevation: 0,
                  child: Container(
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          //// ALL LOGIN ARE HERE
                          // _submit();
                          if (_formKey.currentState!.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   const SnackBar(
                            //       content: Text('Processing Data')),
                            // );
                            // _addUserApi();

                            //  _checkifNumberExist();
                            _login();

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VerifyScreen(
                                        userNumberController.text)));
                          }

                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) =>
                          //             VerifyScreen(userNumberController.text)));
                        },
                        borderRadius: BorderRadius.circular(14.0),
                        child: Center(
                          child: Text(
                            'Continue',
                            style: heading5.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "",
                      style: regular16pt.copyWith(color: textGrey),
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) =>
                    //                 AgricExpertLoginScreen()));
                    //   },
                    //   child: Text(
                    //     'Login Here',
                    //     style: regular16pt.copyWith(color: primaryBlue),
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // String? validatePhonenum(String? value) {
// Tanzania Mobile number are of 10 digit only
  //   if (value!.length == 0)
  //     return 'Phone Field must not be empty';
  //   else if (value.length < 10)
  //     return 'Phone must be of 10 digits';
  //   else if (value.length > 10)
  //     return 'Phone must not exceed 10 digits';
  //   else
  //     return null;
  // }

  // void _submit() {
  //   if (_formKey.currentState!.validate()) {
  //  TODO SAVE DATA
  //     t_login();
  //   }
  // }
  // void t_login(){
  //   print("login");
  // }

  void _login() async {
    // setState(() {
    //   _isLoading = true;
    // });

    var data = {
      'phone': userNumberController.text,
      // 'username':userNumberController,
      'type': "farmer",
    };

    print(data);

    var res =
        await CallApi().posData(data, 'auth/farmer', context); //ADDED CONTEXT
    var body = json.decode(res.body);

    print("-----------------------------------------");
    print(res.body);

    if (res.body['continue'] == true) {
      final localStorage = await SharedPreferences.getInstance();
      // localStorage.setString("token", body['token']);
      // localStorage.setString("phone", json.encode(body['phone']));
      // String pnum = userNumberController.text;
      localStorage.setString('phone', userNumberController.text);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => VerifyScreen(userNumberController.text)));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AuthScreen()));
    }
  }
  // ignore: avoid_print
}

// ************** Login authentication finish here *************

//****************   Verification Screen starts here **********88 */

class VerifyScreen extends StatefulWidget {
  // String phone;
  String phone;

  VerifyScreen(this.phone);

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  TextEditingController verifyCodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/logo1.png',
                        width: 200,
                        height: 200,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Enter Code',
                      style: heading2.copyWith(color: textBlack),
                    ),
                  ],
                ),
                SizedBox(
                  height: 48,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: textWhiteGrey,
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: TextFormField(
                          controller: verifyCodeController,
                          validator: (value) {
                            if (value!.length == 0)
                              return 'Password Field must not be empty';
                            else if (value.length < 4)
                              return 'Password must be of 5 or more digit';
                            else
                              return null;
                          },
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: 'Verification Code',
                            hintStyle: heading6.copyWith(color: textGrey),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // CustomCheckbox(),
                    SizedBox(
                      width: 12,
                    ),
                    // Text('Remember me', style: regular16pt),
                  ],
                ),
                // SizedBox(
                //   height: 32,
                // ),
                Material(
                  borderRadius: BorderRadius.circular(14.0),
                  elevation: 0,
                  child: Container(
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          // _checkifNumberExist();
                          if (_formKey.currentState!.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   const SnackBar(
                            //       content: Text('Processing Data')),
                            // );
                            // _addUserApi();
                            _checkifNumberExist();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
                          }
                          // _sub

                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => HomeScreen()));
                        },
                        borderRadius: BorderRadius.circular(14.0),
                        child: Center(
                          child: Text(
                            'Login',
                            style: heading5.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? validatePassword(String? value) {
    if (value!.length == 0)
      return 'Password Field must not be empty';
    else if (value.length < 3)
      return 'code must be of 4 or more digit';
    else
      return null;
  }

  void _checkifNumberExist() async {
    // setState(() {
    //   _isLoading = true;
    // });
    print("check if number exist bra bra-----------------");

    // SharedPreferences localStorage_phonenumber =
    //     await SharedPreferences.getInstance();
    // var userJson_phonenumber =
    //     localStorage_phonenumber.getString('phone')!.replaceAll('"', '');
    // //var user_email = json.decode(userJson_email);
    // // print('-----------------------------------');
    // print(userJson_phonenumber);
    String my_number =
        widget.phone.toString().replaceAll(widget.phone.toString()[0], '255');
    var data = {
      'username': my_number,
      'password': verifyCodeController.text,

      // 'password_confirmation': confirmpasswordController.text,
    };
    print(data);
    var res = await CallApi().loginRequest(data, 'auth/login/');
    var body = json.decode(res.body);
    print("breach inside body");
    print(body);

    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString("token", body['token']);
    // localStorage.setString("refresh_token", body['refresh']);
    // localStorage.setString("user", json.encode(body['user']));

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
    print(body);
  }
}
// ***************** Verification code finish here ******************

// ****************** Expert Register Start here *******************

class Expert_Register_Screen extends StatefulWidget {
  @override
  State<Expert_Register_Screen> createState() => _Expert_Register_ScreenState();
}

class _Expert_Register_ScreenState extends State<Expert_Register_Screen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool passwordVisible = false;
    void togglePassword() {
      setState(() {
        passwordVisible = !passwordVisible;
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/logo2.png',
                        width: 200,
                        height: 200,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Agriculture Expert Register',
                      style: heading2.copyWith(color: textBlack),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: textWhiteGrey,
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: TextFormField(
                          controller: usernameController,
                          decoration: InputDecoration(
                            hintText: 'Expert Name or Company',
                            hintStyle: heading6.copyWith(color: textGrey),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: textWhiteGrey,
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle: heading6.copyWith(color: textGrey),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: textWhiteGrey,
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: TextFormField(
                          controller: phoneController,
                          decoration: InputDecoration(
                            hintText: 'Phone',
                            hintStyle: heading6.copyWith(color: textGrey),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: textWhiteGrey,
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: !passwordVisible,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: heading6.copyWith(color: textGrey),
                            suffixIcon: IconButton(
                              color: textGrey,
                              splashRadius: 1,
                              icon: Icon(passwordVisible
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined),
                              onPressed: togglePassword,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: textWhiteGrey,
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: !passwordVisible,
                          decoration: InputDecoration(
                            hintText: 'Confirm Password',
                            hintStyle: heading6.copyWith(color: textGrey),
                            suffixIcon: IconButton(
                              color: textGrey,
                              splashRadius: 1,
                              icon: Icon(passwordVisible
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined),
                              onPressed: togglePassword,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomCheckbox(),
                    SizedBox(
                      width: 12,
                    ),
                    Text('Remember me', style: regular16pt),
                  ],
                ),
                SizedBox(
                  height: 32,
                ),
                Material(
                  borderRadius: BorderRadius.circular(14.0),
                  elevation: 0,
                  child: Container(
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          _expertRegister();

                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => DashboardScreen()));
                        },
                        borderRadius: BorderRadius.circular(14.0),
                        child: Center(
                          child: Text(
                            'Register',
                            style: heading5.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Have an Account! ",
                      style: regular16pt.copyWith(color: textGrey),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AgricExpertLoginScreen()));
                      },
                      child: Text(
                        'Login Here',
                        style: regular16pt.copyWith(color: primaryBlue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _expertRegister() async {
    // setState(() {
    //   _isLoading = true;
    // });

    var data = {
      "username": usernameController.text,
      "email": emailController.text,
      "phone": phoneController.text,
      "type": "admin",
      "password": passwordController.text,
    };

    print(data);

    var res = await CallApi().posData(data, 'auth/register/user',
        context); // ADDED CONTEXT**********************************
    var body = json.decode(res.body);

    print(body);
    // print(res.bo);

    // if(res.statusCode == 200){

    // SharedPreferences localStorage = await SharedPreferences.getInstance();
    // // localStorage.setString("token", body['token']);
    // localStorage.setString("phone", json.encode(body['phone']));

    Navigator.push(context,
        MaterialPageRoute(builder: (context) => AgricExpertLoginScreen()));
    // }
    // ignore: avoid_print
  }
}
// ****************** Expert Register Finish here *******************

// ****************** Expert Login Start here *******************

class AgricExpertLoginScreen extends StatefulWidget {
  @override
  State<AgricExpertLoginScreen> createState() => _AgricExpertLoginScreenState();
}

class _AgricExpertLoginScreenState extends State<AgricExpertLoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool passwordVisible = false;
    void togglePassword() {
      setState(() {
        passwordVisible = !passwordVisible;
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/logo2.png',
                        width: 200,
                        height: 200,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Agriculture Expert Login',
                      style: heading2.copyWith(color: textBlack),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: textWhiteGrey,
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: 'Username',
                            hintStyle: heading6.copyWith(color: textGrey),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: textWhiteGrey,
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: !passwordVisible,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: heading6.copyWith(color: textGrey),
                            suffixIcon: IconButton(
                              color: textGrey,
                              splashRadius: 1,
                              icon: Icon(passwordVisible
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined),
                              onPressed: togglePassword,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomCheckbox(),
                    SizedBox(
                      width: 12,
                    ),
                    Text('Remember me', style: regular16pt),
                  ],
                ),
                SizedBox(
                  height: 32,
                ),
                Material(
                  borderRadius: BorderRadius.circular(14.0),
                  elevation: 0,
                  child: Container(
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          _expert_login();

                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => DashboardScreen()));
                        },
                        borderRadius: BorderRadius.circular(14.0),
                        child: Center(
                          child: Text(
                            'Login',
                            style: heading5.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Dont have an Account! ",
                      style: regular16pt.copyWith(color: textGrey),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Expert_Register_Screen()));
                      },
                      child: Text(
                        'Register Here',
                        style: regular16pt.copyWith(color: primaryBlue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _expert_login() async {
    // setState(() {
    //   _isLoading = true;
    // });

    var data = {
      'username': emailController.text,
      'password': passwordController.text,
    };

    print(data);

    var res = await CallApi().posData(
        data, 'auth/login/', context); //ADDED CONTEXT********************

    var body = json.decode(res.body);

    print(body);
    // print(res.bo);

    // if(res.statusCode == 200){
    print("here i am-----------1----1---1-----------");

    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString("token", body['token']);
    localStorage.setString("user", json.encode(body['user']));
    // print("here i am-----------------------------");
    // print(localStorage.getString('token'));

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DashboardScreen()));
    // }
    // ignore: avoid_print
  }
}

// ****************** Expert Login Finish here *******************
