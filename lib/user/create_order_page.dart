import 'package:flutter/material.dart';
import '../models/order_model.dart';
import '../models/order_item_model.dart';
import 'user_order_status_page.dart';

class CreateOrderPage extends StatelessWidget {
  const CreateOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final order = OrderModel(
      id: 'ORD-001',
      customerName: 'User',
      items: [
        OrderItemModel(name: 'Servis AC', quantity: 1, price: 150000),
        OrderItemModel(name: 'Cuci AC', quantity: 2, price: 75000),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Buat Pesanan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Detail Pesanan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...order.items.map(
              (item) => ListTile(
                title: Text(item.name),
                subtitle: Text('${item.quantity} x Rp ${item.price}'),
                trailing: Text('Rp ${item.total}'),
              ),
            ),
            const Divider(),
            Text(
              'Total: Rp ${order.totalPrice}',
              style: const TextStyle(fontSize: 16),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => UserOrderStatusPage(order: order),
                    ),
                  );
                },
                child: const Text('Kirim Pesanan'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
