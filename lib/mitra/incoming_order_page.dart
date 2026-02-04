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
      backgroundColor: const Color(0xFFDFD0B8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFDFD0B8),
        elevation: 0,
        title: const Text(
          'Pesanan Masuk',
          style: TextStyle(
            color: Color(0xFF222831),
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF222831)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => OrderDetailPage(order: order),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 26,
                    backgroundColor: Color(0xFF222831),
                    child: Icon(
                      Icons.receipt_long,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order['customer'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Total: Rp ${order['total']}',
                          style: const TextStyle(color: Colors.black54),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Status: ${order['status']}',
                          style: const TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.black45,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
