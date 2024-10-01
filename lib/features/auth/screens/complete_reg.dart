import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/features/auth/screens/signInScreen.dart';

class CompleteReg extends StatefulWidget {
  const CompleteReg({super.key});

  @override
  State<CompleteReg> createState() => _CompleteRegState();
}

class _CompleteRegState extends State<CompleteReg> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  var formkey = GlobalKey<FormState>();
  String dropdownValue = 'Male';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(
                top: 0.0,
                left: 30.0,
                bottom: 24.0,
                right: 24.0,
              ),
              child: Column(
                children: [
                  Text(
                    "Complete Your Profile",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Don't worry.only you can see your personal",
                    style: TextStyle(
                        fontWeight: FontWeight.w400, color: Colors.grey),
                  ),
                  Text(
                    "data.No one else will be able to see it.",
                    style: TextStyle(
                        fontWeight: FontWeight.w400, color: Colors.grey),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage(
                        'https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG-Image.png'),
                  ),
                  SizedBox(
                    height: 10,
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
                    const Text("Name"),
                    TextFormField(
                      style: const TextStyle(fontSize: 10),
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: "Enter Your Username",
                        labelText: "your name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text("phoneNumber"),
                    TextFormField(
                      controller: phone,
                      style: const TextStyle(fontSize: 10),
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: "Enter Your phoneNumber",
                        labelText: "your phone",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text("Gender"),
                    DropdownButton(
                      isExpanded: true,
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_drop_down_sharp),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.black),
                      underline: Container(
                        height: 2,
                        color: Color(0xff6759FF),
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>['Male', 'Female', 'Other']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignInScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff6759FF),
                        minimumSize: const Size(double.infinity,
                            50), // Set minimum width and height
                      ),
                      child: const Text(
                        "Complete",
                        style: TextStyle(fontSize: 19, color: Colors.white),
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
}
