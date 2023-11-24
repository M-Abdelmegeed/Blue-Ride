import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../firebase/firebase_auth_services.dart';
import '../style/colors.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _asuEmailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _asuEmailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'Signup Page',
          style: TextStyle(color: Colors.white),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_sharp,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(15, 75, 0, 0),
            child: Text(
              "Sign Up",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w300),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _firstNameController,
                    decoration: InputDecoration(
                      labelText: 'First Name',
                      labelStyle: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: InputDecoration(
                      labelText: 'Last Name',
                      labelStyle: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _asuEmailController,
                    decoration: InputDecoration(
                      labelText: 'ASU Email',
                      labelStyle: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@eng.asu.edu')) {
                        return 'Please enter a valid ASU email address';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a password';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      labelStyle: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty || value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30),
                  Container(
                    height: 40,
                    child: Material(
                      borderRadius: BorderRadius.circular(20),
                      shadowColor: AppColors.primaryColor,
                      color: Color.fromARGB(255, 0, 0, 0),
                      elevation: 7,
                      child: InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            _signUp();
                          } else {
                            print("Your data is incorrect or missing");
                          }
                          print('Submitted!');
                        },
                        child: Center(
                          child: Text(
                            'Submit',
                            style: TextStyle(
                                color: AppColors.secondaryColor,
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
            ),
          ),
        ],
      ),
    );
  }

  void _signUp() async {
    String firstName = _firstNameController.text;
    String lastName = _lastNameController.text;
    String asuEmail = _asuEmailController.text;
    String password = _passwordController.text;

    try {
      User? user = await _auth.signUpWithEmailAndPassword(
          asuEmail, password, firstName, lastName);

      if (user != null) {
        print("User is successfully created!");
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        print("Some error happened");
      }
    } catch (e) {
      print("An error has occurred: " + e.toString());
    }
  }
}
