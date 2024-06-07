// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'authentication.dart';
import 'main.dart';

final auth = Authentication();

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController1 = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();
  bool _isVisible = false;
  bool _isObscure1 = true;
  bool _isObscure2 = true;
  String returnVisibilityString = "";

  bool returnVisibility(String password1, String password2, String username) {
    if (password1 != password2) {
      returnVisibilityString = "Passwords do not match";
    } else if (username == "") {
      returnVisibilityString = "Username cannot be empty";
    } else if (password1 == "" || password2 == "") {
      returnVisibilityString = "Password fields can't be empty";
    } else if (!auth.isPasswordCompliant(password1)) {
      returnVisibilityString = "Not password compliant";
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(40, 38, 56, 1),
      body: SingleChildScrollView(
        reverse: true,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 60,
              width: 200,
            ),

            // Signup Text
            Center(
              child: Container(
                height: 200,
                width: 400,
                alignment: Alignment.center,
                child: Text(
                  "Signup",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 20,
            ),

            // Wrong password text
            Visibility(
              visible: _isVisible,
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(10),
                child: Text(
                  returnVisibilityString,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              ),
            ),

            // Signup Info
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.white,
              ),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    onTap: () {
                      setState(() {
                        _isVisible = false;
                      });
                    },
                    controller: usernameController, // Controller for Username
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Username",
                      contentPadding: EdgeInsets.all(20),
                    ),
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  TextFormField(
                    onTap: () {
                      setState(() {
                        _isVisible = false;
                      });
                    },
                    controller: passwordController1, // Controller for Password
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Password",
                      contentPadding: EdgeInsets.all(20),
                      // Adding the visibility icon to toggle visibility of the password field
                      suffixIcon: IconButton(
                        icon: Icon(
                            _isObscure1 ? Icons.visibility_off : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _isObscure1 = !_isObscure1;
                          });
                        },
                      ),
                    ),
                    obscureText: _isObscure1,
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  TextFormField(
                    onTap: () {
                      setState(() {
                        _isVisible = false;
                      });
                    },
                    controller: passwordController2, // Controller for Password
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Re-enter Password",
                      contentPadding: EdgeInsets.all(20),
                      // Adding the visibility icon to toggle visibility of the password field
                      suffixIcon: IconButton(
                        icon: Icon(
                            _isObscure2 ? Icons.visibility_off : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _isObscure2 = !_isObscure2;
                          });
                        },
                      ),
                    ),
                    obscureText: _isObscure2,
                  ),
                ],
              ),
            ),

            // Signup Submit button
            Container(
              width: double.infinity,
              height: 70,
              padding: EdgeInsets.only(top: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                child: Text("Submit", style: TextStyle(color: Colors.white)),
                onPressed: () async {
                  if (kDebugMode) {
                    print(
                        "Username: ${usernameController.text}\npassword: ${passwordController1.text}\nretry password ${passwordController2.text}");
                  }

                  if (usernameController.text != "" &&
                      passwordController1.text == passwordController2.text &&
                      passwordController2.text != "" &&
                      auth.isPasswordCompliant(passwordController1.text)) {
                    if (!auth.checkUserRepeat(usernameController.text)) {
                      auth.insertCredentials(
                          usernameController.text, passwordController1.text);

                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => MyApp()),
                        (Route<dynamic> route) => false,
                      );
                    } else {
                      setState(() {
                        returnVisibilityString = "Username already exists";
                        _isVisible = true;
                      });
                    }
                  } else {
                    setState(() {
                      _isVisible = returnVisibility(passwordController1.text,
                          passwordController2.text, usernameController.text);
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
