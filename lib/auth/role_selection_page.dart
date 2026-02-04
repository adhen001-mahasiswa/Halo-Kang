import 'package:flutter/material.dart';

class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});

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
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),

            const Text(
              "Pilih Peran Anda",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFF222831),
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Masuk sebagai user atau mitra",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54),
            ),

            const SizedBox(height: 40),

            // Card USER
            _roleCard(
              title: "User",
              subtitle: "Pesan jasa tukang, service, dll",
              icon: Icons.person,
              onTap: () {
                Navigator.pushReplacementNamed(context, '/');
              },
            ),

            const SizedBox(height: 20),

            // Card MITRA
            _roleCard(
              title: "Mitra",
              subtitle: "Terima order dan kerjakan jasa",
              icon: Icons.handyman,
              onTap: () {
                Navigator.pushReplacementNamed(context, '/mitra-home');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _roleCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: const Color(0xFF222831),
                child: Icon(icon, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
