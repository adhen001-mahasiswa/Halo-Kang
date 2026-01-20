import 'package:flutter/material.dart';
import 'create_order_page.dart';

class UserHomePage extends StatelessWidget {
  const UserHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HALOOKANG'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Buat Pesanan'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CreateOrderPage()),
            );
          },
        ),
      ),
    );
  }
}
