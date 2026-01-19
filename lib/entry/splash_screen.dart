import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 6), () {
      Navigator.pushReplacementNamed(context, '/');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDFD0B8),
      body: Stack(
        children: [
          Positioned(
            top: -150,
            right: -150,
            child: Container(
              width: 300,
              height: 300,
              decoration: const BoxDecoration(
                color: Color(0xFF222831),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -180,
            left: -180,
            child: Container(
              width: 350,
              height: 350,
              decoration: const BoxDecoration(
                color: Color(0xFF222831),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Center(
            child: Image.asset(
              'assets/images/haloo-kang-logo.png',
              width: 300,
            ),
          ),
        ],
      ),
    );
  }
}
