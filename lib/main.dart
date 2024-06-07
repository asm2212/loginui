import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'signup_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'SanFrancisco',
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: const Color.fromRGBO(40, 38, 56, 1),
        body: LoginScreen(),
        bottomNavigationBar: BottomAppBar(
            color: Colors.transparent,
            elevation: 0,
            child: Container(
              padding: EdgeInsets.all(20),
              child: Text(
                "Company name, Inc",
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            )),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: const Color.fromRGBO(40, 38, 56, 1),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Container(
                  height: 400,
                  width: 200,
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.center,
                  child: Text(
                    "Successful login!",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  )),
            ),
            Container(
              height: 100,
              width: 570,
              padding: EdgeInsets.all(20),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  child: Text("Logout", style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp()),
                      (Route<dynamic> route) => false,
                    );
                  }),
            )
          ],
        ));
  }
}
