import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDFD0B8),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF222831)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
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
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 60),
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Color(0xFF222831),
                  child: Icon(Icons.person, color: Colors.white, size: 40),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Sign Up!",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    children: [
                      _buildInput(
                        controller: nameController,
                        hint: "Username",
                        icon: Icons.person_outline,
                      ),
                      const SizedBox(height: 16),
                      _buildInput(
                        controller: emailController,
                        hint: "Email",
                        icon: Icons.email_outlined,
                      ),
                      const SizedBox(height: 16),
                      _buildInput(
                        controller: passwordController,
                        hint: "Password",
                        icon: Icons.lock_outline,
                        obscure: true,
                      ),
                      const SizedBox(height: 16),
                      _buildInput(
                        controller: confirmController,
                        hint: "Confirm Password",
                        icon: Icons.lock_outline,
                        obscure: true,
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: isLoading ? null : _handleRegister,
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
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text("Sign Up"),
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

  Future<void> _handleRegister() async {
    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmController.text.isEmpty ||
        nameController.text.isEmpty) {
      _showSnack('Semua field wajib diisi');
      return;
    }

    if (passwordController.text != confirmController.text) {
      _showSnack('Password tidak sama');
      return;
    }

    setState(() => isLoading = true);

    try {
      final auth = context.read<AuthService>();

      final user = await auth.register(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        role: 'user',
        name: nameController.text.trim(),
      );

      // ✅ REGISTER BENAR-BENAR BERHASIL
      if (!mounted) return;

      Navigator.of(context).pushNamedAndRemoveUntil(
        '/role',
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      // 🔥 KASUS PALING SERING (USER SEBENARNYA SUDAH ADA)
      if (e.code == 'email-already-in-use') {
        final currentUser = FirebaseAuth.instance.currentUser;

        if (currentUser != null && mounted) {
          Navigator.pushReplacementNamed(context, '/role');
          return;
        }
      }

      _showSnack(e.message ?? 'Register gagal');
    } catch (e) {
      _showSnack(e.toString());
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Widget _buildInput({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscure = false,
  }) {
    return TextField(
      controller: controller,
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
