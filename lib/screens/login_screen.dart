import 'package:donation_app_igdtuw/screens/home_screen.dart';
import 'package:donation_app_igdtuw/screens/profileview.dart';
import 'homepagemain.dart';
import 'package:donation_app_igdtuw/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'homepagemain.dart';
import 'navbar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // form key
  final _formKey = GlobalKey<FormState>();

  // editing controller
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  final _auth = FirebaseAuth.instance;
  // string for displaying the error Message
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    //email field
    final emailField = Container(
      // decoration: BoxDecoration(
      //     color: Colors.white.withOpacity(0.2),
      //     //border: Border.all(color: Colors.red),
      //     borderRadius: BorderRadius.circular(5)
      // ),
      child:TextFormField(
          autofocus: false,
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value!.isEmpty) {
              return ("Please Enter Your Email");
            }
            // reg expression for email validation
            if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                .hasMatch(value)) {
              return ("Please Enter a valid email");
            }
            return null;
          },
          onSaved: (value) {
            emailController.text = value!;
          },
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withOpacity(0.2),
            // fillColor: Colors.white.withOpacity(0.2),
            // focusColor: Colors.white.withOpacity(0.2),
            errorBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
            // focusedErrorBorder:
            //     OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            errorStyle: TextStyle(color: Colors.white),
            prefixIcon: Icon(Icons.mail,color: Colors.white60,),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Email",
            hintStyle:  TextStyle(fontSize: 20.0, color: Colors.white70),
            border: OutlineInputBorder(
              //borderRadius: BorderRadius.circular(10),
            ),
          )),);

    //password field
    final passwordField = Container(
      // decoration: BoxDecoration(
      //     color: Colors.white.withOpacity(0.2),
      //     //border: Border.all(color: Colors.red),
      //     borderRadius: BorderRadius.circular(5)
      // ),
      child:TextFormField(
          autofocus: false,
          controller: passwordController,
          obscureText: true,
          validator: (value) {
            RegExp regex = new RegExp(r'^.{6,}$');
            if (value!.isEmpty) {
              return ("Password is required for login");
            }
            if (!regex.hasMatch(value)) {
              return ("Enter Valid Password(Min. 6 Character)");
            }
          },
          onSaved: (value) {
            passwordController.text = value!;
          },
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withOpacity(0.2),
            errorBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white60)),
            // focusedErrorBorder:
            // OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            errorStyle: TextStyle(color: Colors.white),
            prefixIcon: Icon(Icons.vpn_key,color: Colors.white70,),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Password",
            hintStyle:  TextStyle(fontSize: 20.0, color: Colors.white70),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          )),);

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(5),
      //color: Colors.redAccent,
      child: Container(
        decoration: BoxDecoration(gradient:LinearGradient(
          colors: [
            Colors.orangeAccent,
            Colors.redAccent,
          ],
        ),
            borderRadius: BorderRadius.circular(5)),
        child: MaterialButton(
            padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            minWidth: MediaQuery.of(context).size.width,
            onPressed: () {
              signIn(emailController.text, passwordController.text);
            },
            child: Container(
              // //padding: EdgeInsets.all(1.0),
              // decoration: BoxDecoration(gradient:LinearGradient(
              //   colors: [
              //     Colors.orangeAccent,
              //     Colors.redAccent,
              //   ],
              // ),
              //     borderRadius: BorderRadius.circular(5)),
              child: Text(
                "Login",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            )
        ),
      ),
    );

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/bg4.jpg'), fit: BoxFit.cover),
      ),
      child:Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            // decoration: BoxDecoration(
            // image: DecorationImage(
            // image: AssetImage('assets/bg4.jpg'), fit: BoxFit.cover),
            // ),
            child: SingleChildScrollView(
              child: Container(
                // decoration: BoxDecoration(
                //   image: DecorationImage(
                //       image: AssetImage('assets/bg4.jpg'), fit: BoxFit.cover),
                // ),
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(36.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 50,
                          child: Text('Welcome Back !',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                            ),
                          ),
                        ),
                        Text('Log in to continue',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                          ),
                        ),
                        SizedBox(height: 45),
                        emailField,
                        SizedBox(height: 25),
                        passwordField,
                        SizedBox(height: 35),
                        loginButton,
                        SizedBox(height: 30),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Don't have an account? ",style:TextStyle(color: Colors.red)),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegistrationScreen()));
                                },
                                child: Text(
                                  "SignUp",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              )
                            ])
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),);
  }

  // login function
  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
          Fluttertoast.showToast(msg: "Login Successful"),
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) =>
                  navMainPage()
              // viewprofile(),
              )),
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";

            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }
}