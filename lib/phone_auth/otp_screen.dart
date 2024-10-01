import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../features/auth/screens/homeScreen.dart';

class OTPScreen extends StatefulWidget {
  final String verificationId;
  const OTPScreen({super.key, required this.verificationId});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController otpController = TextEditingController();
  bool isLoadin = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const Text(
                "OTP Verification",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "We need to register your phone number by using a one-time OTP code verification.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: otpController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "+207123456789",
                    labelText: "Enter the Phone Number",
                  ),
                ),
              ),
              const SizedBox(height: 20),
              isLoadin
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                  style:
                  ElevatedButton.styleFrom(backgroundColor: Color(0xff6759FF)),
                  onPressed: () async {
                    setState(() {
                      isLoadin = true;
                    });
                    try {
                      final credential = PhoneAuthProvider.credential(
                        verificationId: widget.verificationId,
                        smsCode: otpController.text,
                      );
                      await FirebaseAuth.instance
                          .signInWithCredential(credential);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    } catch (e) {
                      print(e);
                    }
                    setState(() {
                      isLoadin = false;
                    });
                  },
                  child: const Text(
                    "Send Code",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}