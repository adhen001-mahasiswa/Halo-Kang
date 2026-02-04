import 'package:flutter/material.dart';
import '../models/tukang.dart';

class BookingScreen extends StatefulWidget {
  final Tukang tukang;

  const BookingScreen({super.key, required this.tukang});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    final tukang = widget.tukang;

    return Scaffold(
      backgroundColor: const Color(0xFFDFD0B8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFDFD0B8),
        elevation: 0,
        title: Text(
          'Booking - ${tukang.name}',
          style: const TextStyle(
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
            _infoCard("Layanan", tukang.expertise),
            _infoCard(
              "Estimasi Harga",
              "Mulai dari Rp ${tukang.priceFrom.toInt()}",
            ),
            _inputField("Alamat lengkap"),
            _inputField("Catatan (opsional)", maxLines: 3),
            const SizedBox(height: 12),

            /// PILIH TANGGAL & JAM
            Row(
              children: [
                Expanded(
                  child: _outlineButton(
                    selectedDate == null
                        ? "Pilih Tanggal"
                        : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                    _pickDate,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _outlineButton(
                    selectedTime == null
                        ? "Pilih Jam"
                        : selectedTime!.format(context),
                    _pickTime,
                  ),
                ),
              ],
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/checkout',
                    arguments: {'tukang': tukang},
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF222831),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  "Lanjut ke Pembayaran",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ===== DATE PICKER =====
  Future<void> _pickDate() async {
    final result = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );

    if (result != null) {
      setState(() {
        selectedDate = result;
      });
    }
  }

  /// ===== TIME PICKER =====
  Future<void> _pickTime() async {
    final result = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (result != null) {
      setState(() {
        selectedTime = result;
      });
    }
  }

  Widget _infoCard(String title, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
          Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
          Text(value),
        ],
      ),
    );
  }

  Widget _inputField(String hint, {int maxLines = 1}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: TextField(
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _outlineButton(String text, VoidCallback onPressed) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        side: const BorderSide(color: Color(0xFF222831)),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Color(0xFF222831)),
      ),
    );
  }
}
