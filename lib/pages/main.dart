import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../firebase_options.dart';
import 'signup.dart';
import 'homepage.dart';
import '../style/colors.dart';
import '../firebase/firebase_auth_services.dart';
import './profile.dart';
import './orderHistory.dart';
import './routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blue Ride',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Campus Cruise'),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/activity': (context) => new orderHistory(),
        '/routes': (context) => new Routes(),
        '/profile': (context) => new Profile(),
        '/signup': (BuildContext context) => new SignupPage(),
        '/home': (BuildContext context) => new HomePage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController _asuEmailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void dispose() {
    _asuEmailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(15, 75, 0, 0),
                  child: Text(
                    "Welcome to Blue Ride!",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w300),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 5, left: 20, right: 20),
            child: Column(children: [
              TextField(
                controller: _asuEmailController,
                decoration: InputDecoration(
                    labelText: 'ASU Email',
                    labelStyle: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primaryColor))),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primaryColor))),
                obscureText: true,
              ),
              SizedBox(
                height: 5.0,
              ),
              Container(
                  alignment: Alignment(1, 0),
                  padding: EdgeInsets.only(top: 15, left: 20),
                  child: InkWell(
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontFamily: 'Roboto',
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ))
            ]),
          ),
          SizedBox(
            height: 45,
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            height: 40,
            child: Material(
              borderRadius: BorderRadius.circular(20),
              shadowColor: const Color.fromARGB(255, 11, 130, 209),
              color: AppColors.primaryColor,
              elevation: 7,
              child: GestureDetector(
                onTap: () {
                  _login();
                  print("Walahi dost");
                },
                child: Center(
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            height: 40,
            child: Material(
              borderRadius: BorderRadius.circular(20),
              shadowColor: AppColors.primaryColor,
              color: AppColors.backgroundColor,
              elevation: 7,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: Center(
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _login() async {
    String asuEmail = _asuEmailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(asuEmail, password);

    if (user != null) {
      print("Successful Login!");
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Login Failed'),
              content: Text('Incorrect email or password. Please try again.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('OK'),
                ),
              ],
            );
          });
      print("Some error happened");
    }
  }
}
