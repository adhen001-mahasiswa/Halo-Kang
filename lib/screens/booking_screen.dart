import 'package:flutter/material.dart';
import '../models/tukang.dart';
import '../widgets/primary_button.dart';
import '../services/mock_service.dart';

class BookingScreen extends StatefulWidget {
  final Tukang tukang;
  BookingScreen({required this.tukang});

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  final addressCtrl = TextEditingController();
  final notesCtrl = TextEditingController();
  double priceEstimate = 0;

  @override
  void initState() {
    super.initState();
    priceEstimate = widget.tukang.priceFrom;
  }

  @override
  Widget build(BuildContext context) {
    final service = MockService();
    return Scaffold(
      appBar: AppBar(title: Text('Booking - ${widget.tukang.name}')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(title: Text('Layanan'), subtitle: Text(widget.tukang.expertise)),
            ListTile(title: Text('Estimasi Harga'), subtitle: Text('Rp ${priceEstimate.toInt()}')),
            TextField(controller: addressCtrl, decoration: InputDecoration(labelText: 'Alamat lengkap')),
            TextField(controller: notesCtrl, decoration: InputDecoration(labelText: 'Catatan (opsional)')),
            SizedBox(height:12),
            Row(
              children: [
                Expanded(child: OutlinedButton(onPressed: pickDate, child: Text(selectedDate == null ? 'Pilih Tanggal' : selectedDate!.toLocal().toString().split(' ')[0]))),
                SizedBox(width:8),
                Expanded(child: OutlinedButton(onPressed: pickTime, child: Text(selectedTime == null ? 'Pilih Jam' : selectedTime!.format(context)))),
              ],
            ),
            Spacer(),
            PrimaryButton(text: 'Lanjut ke Pembayaran', onPressed: () {
              if (addressCtrl.text.trim().isEmpty || selectedDate==null || selectedTime==null) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Lengkapi alamat, tanggal dan jam')));
                return;
              }
              final schedule = DateTime(
                selectedDate!.year, selectedDate!.month, selectedDate!.day,
                selectedTime!.hour, selectedTime!.minute
              );
              final order = service.createOrder(
                tukang: widget.tukang,
                schedule: schedule,
                address: addressCtrl.text,
                notes: notesCtrl.text,
                priceEstimate: priceEstimate,
              );
              Navigator.pushNamed(context, '/checkout', arguments: {'order': order});
            }),
          ],
        ),
      ),
    );
  }

  Future<void> pickDate() async {
    final d = await showDatePicker(context: context, initialDate: DateTime.now().add(Duration(days:1)), firstDate: DateTime.now(), lastDate: DateTime.now().add(Duration(days:365)));
    if (d != null) setState(() => selectedDate = d);
  }

  Future<void> pickTime() async {
    final t = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (t != null) setState(() => selectedTime = t);
  }
}
