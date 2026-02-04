import 'package:flutter/material.dart';
import '../models/tukang.dart';

class CheckoutScreen extends StatefulWidget {
  final Tukang tukang;

  const CheckoutScreen({super.key, required this.tukang});

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
        title: const Text(
          "Checkout",
          style: TextStyle(
            color: Color(0xFF222831),
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF222831)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _summaryCard(),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Metode Pembayaran",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF222831),
                ),
              ),
            ),
            const SizedBox(height: 8),
            _paymentTile("Virtual Account", "va"),
            _paymentTile("E-Wallet", "ewallet"),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Pembayaran berhasil (mock)")),
                  );
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF222831),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  "Bayar Sekarang",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.tukang.name,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              const Text("Tanggal: 2026-02-06"),
            ],
          ),
          Text("Rp ${widget.tukang.priceFrom.toInt()}"),
        ],
      ),
    );
  }

  Widget _paymentTile(String title, String value) {
    return RadioListTile(
      value: value,
      groupValue: paymentMethod,
      onChanged: (val) {
        setState(() {
          paymentMethod = val!;
        });
      },
      title: Text(title),
      activeColor: const Color(0xFF222831),
    );
  }
}
