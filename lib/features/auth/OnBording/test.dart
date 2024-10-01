import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'dart:async';

import '../screens/signInScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xff6759FF),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/home.png'),
              const SizedBox(height: 20),
              const Text(
                'Home Services',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();
  int currentPageIndex = 0;

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => SignInScreen()),
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('$assetName', width: width);
  }

  Widget _buildTitle(String text, {String? highlight}) {
    if (highlight != null && text.contains(highlight)) {
      List<String> parts = text.split(highlight);
      return RichText(
        text: TextSpan(
          style: const TextStyle(
              fontSize: 28.0, fontWeight: FontWeight.w700, color: Colors.black),
          children: [
            TextSpan(text: parts[0]),
            TextSpan(
              text: highlight,
              style: const TextStyle(color: Color(0xff6759FF)),
            ),
            TextSpan(text: parts.length > 1 ? parts[1] : ''),
          ],
        ),
      );
    }
    return Text(
      text,
      style: const TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
          fontSize: 28.0, fontWeight: FontWeight.w700, color: Colors.black),
      bodyTextStyle: TextStyle(fontSize: 16.0, color: Colors.grey),
      bodyPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      imagePadding:
      EdgeInsets.only(top: 50.0,bottom: 0),
      imageAlignment: Alignment.center,
      pageColor: Colors.white,
    );

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Stack(
            children: [
              IntroductionScreen(
                key: introKey,
                globalBackgroundColor: Colors.white,
                pages: [
                  PageViewModel(
                    titleWidget: _buildTitle(
                      "  Comprehensive Home\n Services at Your Doorstep",
                      highlight: " Your Doorstep",
                    ), // Highlighted text
                    body:
                    "Whether it's cleaning, maintenance, or repairs, our Home Services Program brings skilled professionals directly to your home.",
                    image: _buildImage('images/2.png'),
                    decoration: pageDecoration,
                  ),
                  PageViewModel(
                    titleWidget: _buildTitle("Expert Solutions \n for Your Home",
                        highlight: "Expert Solutions"), // Highlighted text
                    body:
                    "From appliance repairs to deep cleaning, we cover all aspects of home care.",
                    image: _buildImage('images/3.png'),
                    decoration: pageDecoration,
                  ),
                  PageViewModel(
                    titleWidget: _buildTitle("Your Home,\n Our Priority",
                        highlight: "Our Priority"),
                    // Highlighted text
                    body:
                    "Experience hassle-free home services with our trusted network of professionals.",
                    image: _buildImage('images/4.png'),
                    decoration: pageDecoration,
                  ),
                ],

                onDone: () => _onIntroEnd(context),
                showSkipButton: false,
                showNextButton: false,
                done: GestureDetector(
                  onTap: () => _onIntroEnd(context),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue.withOpacity(0.1),
                      border: Border.all(color: const Color(0xff6759FF), width: 2),
                    ),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Color(0xff6759FF),
                      size: 30,
                    ),
                  ),
                ),

                dotsDecorator: const DotsDecorator(
                  size: Size(10.0, 10.0),
                  color: Colors.grey,
                  activeSize: Size(22.0, 10.0),
                  activeColor: Color(0xff6759FF),
                  activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                ),
                onChange: (index) {
                  setState(() {
                    currentPageIndex = index;
                  });
                },
              ),
              // Skip button in the top-right corner
              Positioned(
                top: 40, // Adjust to your UI needs
                right: 20,
                child: GestureDetector(
                  onTap: () => _onIntroEnd(context), // Skip functionality
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      color: Color(0xff6759FF),
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              // Back arrow with circular button, visible only after the 1st page
              if (currentPageIndex > 0)
                Positioned(
                  bottom: 25,
                  left: 44,
                  child: GestureDetector(
                    onTap: () {
                      if (introKey.currentState != null) {
                        introKey.currentState!.previous();
                      }
                    },
                    child: Container(
                      width: 50, // Adjust size
                      height: 50,

                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue.withOpacity(0.1), // Circle background
                        border: Border.all(color: Color(0xff6759FF), width: 2),
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Color(0xff6759FF),
                        size: 30,
                      ),
                    ),
                  ),
                ),
              // Next arrow with circular button, visible unless on the last page
              if (currentPageIndex < 2)
                Positioned(
                  bottom: 25,
                  right: 44,
                  child: GestureDetector(
                    onTap: () {
                      if (introKey.currentState != null) {
                        introKey.currentState!.next();
                      }
                    },

                    child: Container(
                      width: 50, // Adjust size
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xff6759FF)
                            .withOpacity(0.1), // Circle background
                        border: Border.all(color: const Color(0xff6759FF), width: 2),
                      ),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Color(0xff6759FF),
                        size: 30,
                      ),
                    ),
                  ),
                ),

            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Center(
        child: Text(""),
      ),
    );
  }
}