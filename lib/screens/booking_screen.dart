import 'package:flutter/material.dart';
import '../models/tukang.dart';
import '../screens/checkout_screen.dart';

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
              "Rp ${tukang.priceFrom.toInt()}",
            ),
            _inputField("Alamat lengkap"),
            _inputField("Catatan (opsional)", maxLines: 3),
            const SizedBox(height: 12),

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
                  if (selectedDate == null || selectedTime == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Pilih tanggal dan jam terlebih dahulu'),
                      ),
                    );
                    return;
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CheckoutScreen(
                        tukang: tukang,
                        date: selectedDate!,
                        time: selectedTime!,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF222831),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text("Lanjut ke Pembayaran"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickDate() async {
    final result = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (result != null) setState(() => selectedDate = result);
  }

  Future<void> _pickTime() async {
    final result = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (result != null) setState(() => selectedTime = result);
  }

  Widget _infoCard(String title, String value) => Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            Text(value),
          ],
        ),
      );

  Widget _inputField(String hint, {int maxLines = 1}) => Container(
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

  Widget _outlineButton(String text, VoidCallback onPressed) =>
      OutlinedButton(onPressed: onPressed, child: Text(text));
}
