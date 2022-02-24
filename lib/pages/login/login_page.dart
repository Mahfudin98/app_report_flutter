// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:app_report/api/network.dart';
import 'package:app_report/pages/home/home_page.dart';
import 'package:app_report/theme/colors/light_colors.dart';
import 'package:app_report/widgets/top_container.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  var username, password;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  _showMsg(msg) {
    final snackBar = SnackBar(content: Text(msg));
    // ignore: deprecated_member_use
    _scaffoldKey.currentState!.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Column(
          children: [
            TopContainer(
              height: 100,
              width: width,
              child: Column(
                children: [
                  Text(
                    "Login",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Card(
                      elevation: 4.0,
                      color: LightColors.kDarkYellow,
                      margin: const EdgeInsets.only(top: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextFormField(
                                cursorColor: Colors.blue,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                  hintText: "Username",
                                ),
                                validator: (usernameValue) {
                                  if (usernameValue!.isEmpty) {
                                    return 'Masukan Username Kamu';
                                  }
                                  username = usernameValue;
                                  return null;
                                },
                              ),
                              const SizedBox(height: 12),
                              TextFormField(
                                cursorColor: Colors.blue,
                                keyboardType: TextInputType.text,
                                obscureText: _secureText,
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  suffixIcon: IconButton(
                                    onPressed: showHide,
                                    icon: Icon(_secureText
                                        ? Icons.visibility_off
                                        : Icons.visibility),
                                  ),
                                ),
                                validator: (passwordValue) {
                                  if (passwordValue!.isEmpty) {
                                    return 'Masukan Password Kamu';
                                  }
                                  password = passwordValue;
                                  return null;
                                },
                              ),
                              const SizedBox(height: 12),
                              SizedBox(
                                width: 100,
                                height: 45,
                                child: TextButton(
                                  child: Text(
                                    _isLoading ? 'Processing..' : 'Login',
                                    textDirection: TextDirection.ltr,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _login();
                                    }
                                  },
                                  style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    backgroundColor: Colors.blueAccent,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _login() async {
    setState(() {
      _isLoading = true;
    });

    var data = {
      'username': username,
      'password': password,
    };

    var res = await Network().auth(data);
    var body = json.decode(res.body);
    if (body['status'] == 'success') {
      final SharedPreferences localStorage = await _prefs;
      localStorage.setString('data', json.encode(body['data']));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } else {
      _showMsg(body['message']);
    }

    setState(() {
      _isLoading = false;
    });
  }
}
