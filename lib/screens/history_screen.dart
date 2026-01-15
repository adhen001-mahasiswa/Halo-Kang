import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Dummy data (di aplikasi asli, ambil dari Firestore/API)
    final List<Map<String, dynamic>> sample = [
      {
        'title': 'Servis AC - Sari AC',
        'date': '2025-12-01',
        'price': 120000,
        'status': 'Selesai',
      },
      {
        'title': 'Perbaikan Listrik - Budi',
        'date': '2025-11-20',
        'price': 90000,
        'status': 'Selesai',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Layanan'),
      ),
      body: ListView.builder(
        itemCount: sample.length,
        itemBuilder: (context, index) {
          final item = sample[index];

          final String title = item['title'] as String;
          final String date = item['date'] as String;
          final int price = item['price'] as int;
          final String status = item['status'] as String;

          return ListTile(
            title: Text(title),
            subtitle: Text(date),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('Rp $price'),
                Text(
                  status,
                  style: TextStyle(
                    color: status == 'Selesai' ? Colors.green : Colors.orange,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
