import 'package:flutter/material.dart';
import 'incoming_order_page.dart';

class MitraHomePage extends StatelessWidget {
  const MitraHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDFD0B8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFDFD0B8),
        elevation: 0,
        title: const Text(
          'Halo, Mitra 👋',
          style: TextStyle(
            color: Color(0xFF222831),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
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
            const SizedBox(height: 16),

            // CARD PESANAN MASUK
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const IncomingOrderPage(),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    )
                  ],
                ),
                child: Row(
                  children: const [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Color(0xFF222831),
                      child: Icon(
                        Icons.inbox,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pesanan Masuk',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Lihat dan kelola pesanan dari pelanggan',
                            style: TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.black45,
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
}
