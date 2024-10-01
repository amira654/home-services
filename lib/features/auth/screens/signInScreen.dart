import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/features/auth/screens/signUpScreen.dart';

import '../../../LogIn with google/google_auth.dart';
import '../../../forgetpassword/forgetpassword.dart';
import '../../../phone_auth/phone_login.dart';
import '../services/authentication.dart';
import '../widgets/snackbar.dart';
import 'homeScreen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      isLoading = true;
    });
    String res = await AuthMethod().loginUser(
        email: emailController.text, password: passwordController.text);

    if (res == "success") {
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    } else {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, res);
    }
  }

  bool visible = true;

  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(
                top: 60.0,
                left: 24.0,
                bottom: 24.0,
                right: 24.0,
              ),
              child: Column(
                children: [
                  Text(
                    "Sign In",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Hi! Welcome back,you'v been missed",
                    style: TextStyle(
                        fontWeight: FontWeight.w400, color: Colors.grey),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                ],
              ),
            ),
            Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 24.0,
                  bottom: 24.0,
                  right: 24.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Email"),
                    TextFormField(
                      style: const TextStyle(fontSize: 10),
                      controller: emailController,
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
                        prefixIcon: const Icon(
                          Icons.email,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text("Password"),
                    TextFormField(
                      style: const TextStyle(fontSize: 10),
                      controller: passwordController,
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
                        prefixIcon: const Icon(
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
                    // MyButtons(onTap: loginUser, text: "Log In"),

                    const SizedBox(height: 25),
                    ElevatedButton(
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          print(emailController.text);
                          print(passwordController.text);
                          FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text)
                              .then((value) {
                            var e = value.user!.email;
                            print(e);
                            print(value.user!.uid);
                            print('Login sucess');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              ),
                            );
                          }).catchError((error) {
                            print(error.toString());
                          });
                        }
                      },
                      child: Text(
                        "sign in",
                        style: TextStyle(fontSize: 19, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff6759FF),
                        minimumSize: Size(double.infinity,
                            50), // Set minimum width and height
                      ),
                    ),
                    const SizedBox(
                      height: 30,
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
                          "Or sign in with",
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
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Color(0xff6759FF),
                              fontSize: 18,
                              decoration: TextDecoration.underline,
                              decorationColor: Color(0xff6759FF),
                            ),
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
