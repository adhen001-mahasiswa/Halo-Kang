import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/tukang.dart';

class CheckoutScreen extends StatefulWidget {
  final Tukang tukang;
  final DateTime date;
  final TimeOfDay time;

  const CheckoutScreen({
    super.key,
    required this.tukang,
    required this.date,
    required this.time,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String paymentMethod = "va";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDFD0B8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFDFD0B8),
        elevation: 0,
        title: const Text("Checkout"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _summaryCard(),
            const SizedBox(height: 16),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Metode Pembayaran",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            _paymentTile("cod", "cash on delivery"),
            _paymentTile("E-Wallet (Pending)", "ewallet"),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _handlePayment,
                child: const Text("Bayar Sekarang"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handlePayment() async {
    final user = FirebaseAuth.instance.currentUser!;
    final db = FirebaseFirestore.instance;

    await db.collection('orders').add({
      'userId': user.uid,
      'mitraId': widget.tukang.uid,
      'mitraName': widget.tukang.name,
      'expertise': widget.tukang.expertise,
      'price': widget.tukang.priceFrom.toInt(),
      'date': '${widget.date.day}/${widget.date.month}/${widget.date.year}',
      'time': widget.time.format(context),
      'paymentMethod': paymentMethod,
      'paymentStatus': 'pending', // 🔥 penting buat narasi
      'status': 'pending',
      'createdAt': FieldValue.serverTimestamp(),
    });

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Pembayaran pending (mock). Pesanan berhasil dibuat.',
        ),
      ),
    );

    Navigator.popUntil(context, (route) => route.isFirst);
  }

  Widget _summaryCard() => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.tukang.name),
            Text('Rp ${widget.tukang.priceFrom.toInt()}'),
          ],
        ),
      );

  Widget _paymentTile(String title, String value) => RadioListTile(
        value: value,
        groupValue: paymentMethod,
        onChanged: (val) => setState(() => paymentMethod = val!),
        title: Text(title),
      );
}
