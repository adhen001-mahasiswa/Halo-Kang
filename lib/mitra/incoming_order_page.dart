import 'package:flutter/material.dart';
import 'order_detail_page.dart';

class IncomingOrderPage extends StatelessWidget {
  const IncomingOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> orders = [
      {
        'id': 'ORD001',
        'customer': 'Silvia Putri',
        'total': 25000,
        'status': 'Menunggu',
      },
      {
        'id': 'ORD002',
        'customer': 'Andi',
        'total': 40000,
        'status': 'Menunggu',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesanan Masuk'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Card(
            elevation: 3,
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              title: Text(order['customer']),
              subtitle: Text('Total: Rp ${order['total']}'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderDetailPage(order: order),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
