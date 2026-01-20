import 'package:flutter/material.dart';
import '/models/order_model.dart';

class UserOrderStatusPage extends StatelessWidget {
  final OrderModel order;

  const UserOrderStatusPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Status Pesanan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order ID: ${order.id}'),
            const SizedBox(height: 8),
            Text('Nama: ${order.customerName}'),
            const SizedBox(height: 8),
            const Text(
              'Status: Menunggu Konfirmasi',
              style: TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(height: 32),
            const Text(
              'Item Pesanan',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ...order.items.map(
              (item) => ListTile(
                title: Text(item.name),
                trailing: Text('Rp ${item.total.toInt()}'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
