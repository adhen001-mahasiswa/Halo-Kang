import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDFD0B8),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF222831)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
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

          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 60),

                // Maskot kecil (opsional, nanti bisa diganti image asset)
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Color(0xFF222831),
                  child: Icon(Icons.person, color: Colors.white, size: 40),
                ),

                const SizedBox(height: 16),

                const Text(
                  "Sign Up!",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 30),

                // Card putih
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    children: [
                      _buildInput("Username", Icons.person_outline),
                      const SizedBox(height: 16),
                      _buildInput("Password", Icons.lock_outline,
                          obscure: true),
                      const SizedBox(height: 16),
                      _buildInput("Confirm Password", Icons.lock_outline,
                          obscure: true),
                      const SizedBox(height: 16),
                      _buildInput("Email", Icons.email_outlined),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          // Untuk MVP: setelah register balik ke login
                          Navigator.pushReplacementNamed(context, '/role');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF222831),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 80,
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text("Sign Up"),
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

  Widget _buildInput(String hint, IconData icon, {bool obscure = false}) {
    return TextField(
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: const Color(0xFFF5F5F5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
