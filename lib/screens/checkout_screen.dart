import 'package:flutter/material.dart';
import '../widgets/primary_button.dart';

class CheckoutScreen extends StatelessWidget {
  final Map<String, dynamic> order;
  CheckoutScreen({required this.order});

  @override
  Widget build(BuildContext context) {
    final price = order['priceEstimate'] ?? 0;
    return Scaffold(
      appBar: AppBar(title: Text('Checkout')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: Text(order['tukangName'] ?? ''),
                subtitle: Text('Tanggal: ${order['schedule'].toString().split('T').first}'),
                trailing: Text('Rp ${price.toInt()}'),
              ),
            ),
            SizedBox(height:12),
            Align(alignment: Alignment.centerLeft, child: Text('Metode Pembayaran', style: TextStyle(fontWeight: FontWeight.w700))),
            RadioListTile(value: 'va', groupValue: 'va', onChanged: (v){}, title: Text('Virtual Account')),
            RadioListTile(value: 'ewallet', groupValue: 'va', onChanged: (v){}, title: Text('E-Wallet')),
            Spacer(),
            PrimaryButton(text: 'Bayar Sekarang', onPressed: () {
              // In mock: mark as paid
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Pembayaran sukses (mock). Pesanan: ${order['id']}')));
              Navigator.popUntil(context, (route) => route.isFirst);
            }),
          ],
        ),
      ),
    );
  }
}
