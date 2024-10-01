import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/features/auth/screens/signInScreen.dart';

import '../../../LogIn with google/google_auth.dart';
import '../../../forgetpassword/forgetpassword.dart';
import '../../../phone_auth/phone_login.dart';
import 'complete_reg.dart';
import 'homeScreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool visible = true;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(
                top: 40.0,
                left: 24.0,
                bottom: 24.0,
                right: 24.0,
              ),
              child: Column(
                children: [
                  Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Fill your information below or register" ,
                    style: TextStyle(
                        fontWeight: FontWeight.w400, color: Colors.grey),
                  ),
                  Text("with your social account",style: TextStyle(
                      fontWeight: FontWeight.w400, color: Colors.grey),),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Form(
              key: formkey,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 24.0,
                  bottom: 24.0,
                  right: 24.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Name"),
                    TextFormField(
                      controller: name,
                      style: TextStyle(fontSize: 10),
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: "Enter Your Username",
                        labelText: "your name",
                        border:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text("Email"),
                    TextFormField(
                      style: TextStyle(fontSize: 10),
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "email adress must not be empty";
                        }
                        return null;
                      },
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: "example@gmail.com",
                        prefixIcon: Icon(
                          Icons.email,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text("Password"),
                    TextFormField(
                      style: TextStyle(fontSize: 10),
                      controller: password,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: visible,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "password must not be empty";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: Icon(
                          Icons.lock,
                        ),
                        suffixIcon: IconButton(
                            onPressed: () {
                              visible = !visible;
                              setState(() {});
                            },
                            icon: visible == true
                                ? Icon(
                              Icons.remove_red_eye,
                            )
                                : Icon(
                              Icons.visibility_off,
                            )),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: const ForgotPassword()),
                    const SizedBox(
                      height: 25,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          print(email.text);
                          print(password.text);

                          FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                              email: email.text, password: password.text)
                              .then((value) {
                            print(value.user!.email);
                            print(value.user!.uid);
                            print('Register sucess');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CompleteReg(),
                              ),
                            );
                          }).catchError((error) {
                            print(error.toString());
                          });
                        }
                      },
                      child: Text(
                        "sign up",
                        style: TextStyle(fontSize: 19, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff6759FF),
                        minimumSize: Size(double.infinity,
                            50), // Set minimum width and height
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          "Or sign up with",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, color: Colors.grey),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                      child: ElevatedButton(
                        style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white),
                        onPressed: () async {
                          await FirebaseServices().signInWithGoogle();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Image.asset(
                                "images/1.png",
                                height: 45,
                                width: 45,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              "Continue with Google",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    const PhoneAuthentication(),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account?",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignInScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "Sign in",
                            style: TextStyle(
                                color: Color(0xff6759FF),
                                fontSize: 18,
                                decoration: TextDecoration.underline),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
