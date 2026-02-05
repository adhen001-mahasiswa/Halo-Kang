import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MitraRegisterPage extends StatefulWidget {
  const MitraRegisterPage({super.key});

  @override
  State<MitraRegisterPage> createState() => _MitraRegisterPageState();
}

class _MitraRegisterPageState extends State<MitraRegisterPage> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descController = TextEditingController();

  String selectedExpertise = 'AC';
  bool isLoading = false;

  final List<String> expertiseList = [
    'AC',
    'Ledeng',
    'Listrik',
    'Bangunan',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Sebagai Mitra')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _input(nameController, 'Nama Mitra'),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: selectedExpertise,
              items: expertiseList
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() => selectedExpertise = value!);
              },
              decoration: const InputDecoration(
                labelText: 'Bidang Keahlian',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            _input(priceController, 'Harga Jasa', isNumber: true),
            const SizedBox(height: 12),
            _input(descController, 'Deskripsi'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: isLoading ? null : _submit,
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Simpan & Masuk Dashboard'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _input(
    TextEditingController controller,
    String label, {
    bool isNumber = false,
  }) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Future<void> _submit() async {
    if (nameController.text.trim().isEmpty ||
        priceController.text.trim().isEmpty ||
        descController.text.trim().isEmpty) {
      _snack('Semua field wajib diisi');
      return;
    }

    final price = int.tryParse(priceController.text.trim());
    if (price == null) {
      _snack('Harga harus berupa angka');
      return;
    }

    setState(() => isLoading = true);

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        _snack('User belum login');
        return;
      }

      final db = FirebaseFirestore.instance;

      // 🔥 SIMPAN DATA MITRA
      await db.collection('mitra').doc(user.uid).set({
        'uid': user.uid,
        'name': nameController.text.trim(),
        'expertise': selectedExpertise,
        'price': price,
        'description': descController.text.trim(),
        'isActive': true,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // 🔥 UPDATE ROLE USER
      await db.collection('users').doc(user.uid).update({
        'role': 'mitra',
      });

      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/mitra-home');
    } catch (e) {
      debugPrint('MITRA REGISTER ERROR: $e');
      _snack(e.toString());
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  void _snack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
