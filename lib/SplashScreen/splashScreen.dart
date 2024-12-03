import 'dart:async';

import 'package:flutter/material.dart';
import 'package:icpc2024/Hompage/homepage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  // Timer to navigate to home page
  startTimer() async {
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()), // Replace with your home page
      );
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Opacity(
            opacity: 1.0, // Value between 0.0 (fully transparent) and 1.0 (fully opaque)
            child: Image.asset(
              "assets/logo/background.jpg",
              fit: BoxFit.fill,
            ),
          ),

          // Centered content (Logo in the middle)
          Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    // "assets/logo/1.1 Logo Transparent.png",
                    "assets/images/Artboard 1 (4).png",
                    width: 350,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            bottom: 0, // position it at the bottom of the screen
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height: 250,
              color: Colors.transparent, // Transparent background for the bottom bar
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Image.asset("assets/logo/ICPC_logo.png", height: 40),
                      Image.asset("assets/images/icpclogo.png", height: 50),
                      SizedBox(
                        width: 15,
                      ),
                      Image.asset("assets/logo/tx6venon.png", height: 40),
                      SizedBox(
                        width: 15,
                      ),
                      Image.asset("assets/logo/IMG_20241019_112133_465.jpg", height: 40),
                      SizedBox(
                        width: 15,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/logo/ict-division-logo-6C8E3F498E-seeklogo.com.png", height: 40),
                      SizedBox(
                        width: 15,
                      ),
                      Image.asset("assets/logo/Bangladesh_Computer_Council_Logo.svg.png", height: 40),
                      SizedBox(
                        width: 15,
                      ),
                      Image.asset("assets/logo/DBBL-Logo.png", height: 40),
                      SizedBox(
                        width: 15,
                      ),
                      Image.asset("assets/images/cpcLogo.png", height: 30),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),

        ],



      ),

      // bottomNavigationBar: Container(
      //   width: double.maxFinite,
      //   height: 150,
      //   color: Colors.transparent,
      //   child: Column(
      //     children: [
      //       SizedBox(
      //         height: 15,
      //       ),
      //
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           // Image.asset("assets/logo/ICPC_logo.png", height: 40),
      //           SizedBox(
      //             width: 15,
      //           ),
      //           Image.asset("assets/logo/tx6venon.png", height: 40),
      //           SizedBox(
      //             width: 15,
      //           ),
      //           Image.asset("assets/logo/IMG_20241019_112133_465.jpg", height: 40),
      //           SizedBox(
      //             width: 15,
      //           ),
      //
      //         ],
      //       ),
      //       SizedBox(
      //         height: 20,
      //       ),
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           Image.asset("assets/logo/ict-division-logo-6C8E3F498E-seeklogo.com.png", height: 40),
      //           SizedBox(
      //             width: 15,
      //           ),
      //           Image.asset("assets/logo/Bangladesh_Computer_Council_Logo.svg.png", height: 40),
      //           SizedBox(
      //             width: 15,
      //           ),
      //           Image.asset("assets/logo/DBBL-Logo.png", height: 40),
      //         ],
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}
