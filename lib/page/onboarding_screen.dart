import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel/model/onboarding.dart';
import 'package:travel/page/login.dart';
import 'package:travel/main.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<StatefulWidget> createState() => _OnboardingState();
}

class _OnboardingState extends State<OnboardingScreen> {
  PageController? _controller;
  int currentIndex = 0;
  double percentage = 1 / 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: PageView.builder(
                controller: _controller,
                itemCount: contentsList.length,
                onPageChanged: (int index) {
                  if (index >= currentIndex) {
                    setState(() {
                      currentIndex = index;
                      percentage += 1 / 3;
                    });
                  } else {
                    setState(() {
                      currentIndex = index;
                      percentage -= 1 / 3;
                    });
                  }
                },
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: currentIndex == 0 || currentIndex == 2
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              contentsList[index].title,
                              style: const TextStyle(
                                fontFamily: "SF-Pro",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w600,
                                fontSize: 28.0,
                                letterSpacing: 0.24,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              contentsList[index].description,
                              style: const TextStyle(
                                fontFamily: "SF-Pro",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                                fontSize: 18.0,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 12),
                          ],
                        ),
                      ),
                      Image(image: AssetImage(contentsList[index].image))
                    ],
                  );
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: List.generate(
                            contentsList.length,
                            (index) => buildDot(index, context),
                          ),
                        ),
                        const SizedBox(height: 10),
                        CupertinoButton(
                          onPressed: () {
                            goToLogin(context);
                          },
                          child: const Text(
                            "Skip",
                            style: TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                        )
                      ],
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        if (currentIndex == 2) {
                          goToLogin(context);
                        } else{
                          _controller!.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            height: 55,
                            width: 55,
                            child: CircularProgressIndicator(
                              value: percentage,
                              backgroundColor: const Color(0xffbae2ff),
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                Color(0xff5cbbff),
                              ),
                            ),
                          ),
                          const CircleAvatar(
                            backgroundColor: Color(0xff5cbbff),
                            child: Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }
  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  AnimatedContainer buildDot(int index, BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      height: 8,
      width: currentIndex == index ? 24 : 8,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currentIndex == index ? Colors.black45 : Colors.black12,
      ),
    );
  }
}
void goToLogin(BuildContext context){
  Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) =>  const Login(),
        transitionDuration:
        const Duration(milliseconds: 600),
        transitionsBuilder: (_, a, __, c) =>
            FadeTransition(opacity: a, child: c),
      ));
}