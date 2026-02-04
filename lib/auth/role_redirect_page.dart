import 'package:flutter/material.dart';

class RoleRedirectPage extends StatefulWidget {
  const RoleRedirectPage({super.key});

  @override
  State<RoleRedirectPage> createState() => _RoleRedirectPageState();
}

class _RoleRedirectPageState extends State<RoleRedirectPage> {
  @override
  void initState() {
    super.initState();

    // Simulasi cek role user (nanti bisa diganti Firebase / database)
    Future.delayed(const Duration(seconds: 2), () {
      // Default arahkan ke user home (HomeScreen)
      Navigator.pushReplacementNamed(context, '/');
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
