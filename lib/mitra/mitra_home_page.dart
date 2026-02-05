import 'package:flutter/material.dart';
import 'incoming_order_page.dart';
import 'active_order_page.dart';
import 'mitra_history_page.dart';

class MitraHomePage extends StatelessWidget {
  const MitraHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // 🔥 BACK HP = KELUAR APP
      onWillPop: () async {
        return true; // true = exit app
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFDFD0B8),
        appBar: AppBar(
          automaticallyImplyLeading: false, // 🔥 HILANGKAN BACK ICON
          backgroundColor: const Color(0xFFDFD0B8),
          elevation: 0,
          title: const Text(
            'Halo, Mitra 👋',
            style: TextStyle(
              color: Color(0xFF222831),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Dashboard Mitra',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF222831),
                ),
              ),
              const SizedBox(height: 20),
              _menuCard(
                icon: Icons.inbox,
                title: 'Pesanan Masuk',
                subtitle: 'Pesanan baru dari pelanggan',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const IncomingOrderPage(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              _menuCard(
                icon: Icons.work,
                title: 'Pesanan Aktif',
                subtitle: 'Pesanan yang sedang dikerjakan',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ActiveOrderPage(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              _menuCard(
                icon: Icons.history,
                title: 'Riwayat Pekerjaan',
                subtitle: 'Pekerjaan yang telah diselesaikan',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const MitraHistoryPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 6),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: const Color(0xFF222831),
              child: Icon(icon, color: Colors.white, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
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
    );
  }
}
