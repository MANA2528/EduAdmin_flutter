import 'package:flutter/material.dart';
import 'package:flutter_application_1/intro_screenpage/HomePage.dart';
import 'package:flutter_application_1/intro_screenpage/intro_page1.dart';
import 'package:flutter_application_1/intro_screenpage/intro_page2.dart';
import 'package:flutter_application_1/intro_screenpage/intro_page3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _controller = PageController();
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        PageView(
          controller: _controller,
          onPageChanged: (index) {
            setState(() {
              onLastPage =
                  (index == 2); // Check if we're on the last page (index 2)
            });
          },
          children: [
            IntroPage1(),
            IntroPage2(),
            IntroPage3(),
          ],
        ),
        Container(
          alignment: Alignment(0, 0.75),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                  if (onLastPage) {
                    // Handle action when on last page, such as navigating out of onboarding
                  } else {
                    _controller.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeIn);
                  }
                },
                child: Text(onLastPage ? 'Done' : 'Next'),
              ),
              SmoothPageIndicator(controller: _controller, count: 3),
            ],
          ),
        ),
      ],
    ));
  }
}
