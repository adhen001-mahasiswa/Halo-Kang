import 'package:flutter/material.dart';
import '../models/tukang.dart';
import '../widgets/primary_button.dart';

class ProfileScreen extends StatelessWidget {
  final Tukang tukang;

  const ProfileScreen({super.key, required this.tukang});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tukang.name)),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Tombol Chat
            Expanded(
              child: OutlinedButton(
                onPressed: () => _openChat(context),
                child: const Text('Chat'),
              ),
            ),
            const SizedBox(width: 12),

            // Tombol Booking
            Expanded(
              child: PrimaryButton(
                text: 'Pesan Sekarang',
                onPressed: () => Navigator.pushNamed(
                  context,
                  '/booking',
                  arguments: {'tukang': tukang},
                ),
              ),
            ),
          ],
        ),
      ),

      body: ListView(
        children: [
          // Header Info Tukang
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 40,
                  child: Icon(Icons.person, size: 40),
                ),
                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tukang.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 18),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '${tukang.expertise} • ${tukang.distanceKm} km',
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.star,
                              color: Colors.amber, size: 16),
                          const SizedBox(width: 6),
                          Text('${tukang.rating} (${tukang.reviews})'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Tentang
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Tentang',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(tukang.bio),
          ),

          const SizedBox(height: 16),

          // Ulasan
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Ulasan',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),

          const ListTile(
            title: Text('Rina'),
            subtitle: Text('Cepat & rapi, recommended'),
            trailing: Text('5.0'),
          ),

          const ListTile(
            title: Text('Dedi'),
            subtitle: Text('Harga sesuai'),
            trailing: Text('4.5'),
          ),
        ],
      ),
    );
  }

  void _openChat(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Fitur chat belum diimplementasi.')),
    );
  }
}
