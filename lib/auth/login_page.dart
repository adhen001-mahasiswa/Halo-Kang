import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDFD0B8),
      body: Stack(
        children: [
          // Lingkaran dekorasi atas kanan
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

          // Konten utama
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 80),

                // Header capsule
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFB8A999),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Column(
                    children: [
                      Text(
                        "Haloo Kang!",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("Welcome"),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Card putih login
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),

                      TextField(
                        decoration: InputDecoration(
                          hintText: "Username",
                          prefixIcon: const Icon(Icons.person_outline),
                          filled: true,
                          fillColor: const Color(0xFFF5F5F5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Password",
                          prefixIcon: const Icon(Icons.lock_outline),
                          filled: true,
                          fillColor: const Color(0xFFF5F5F5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "forget password ?",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Button Login
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF222831),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 60,
                              vertical: 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            "Login",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      const Center(child: Text("Or")),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Section bawah
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  decoration: const BoxDecoration(
                    color: Color(0xFFB8A999),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        icon: const Icon(Icons.email_outlined),
                        label: const Text("Email"),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't Have account? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/register');
                            },
                            child: const Text(
                              "Sign Up?",
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
