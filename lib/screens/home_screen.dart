import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/mock_service.dart';
import '../models/tukang.dart';
import '../widgets/tukang_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<MockService>(context, listen: false);

    // Ambil data tukang
    final List<Tukang> tukangs = service.getTukangs();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Halo, User 👋',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/history'),
            icon: const Icon(Icons.history),
          ),
        ],
      ),

      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search Box
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/list'),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search, color: Colors.grey),
                        const SizedBox(width: 8),
                        Text(
                          'Cari tukang atau layanan...',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Category Section
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildCategory(context, Icons.ac_unit, 'AC'),
                      _buildCategory(context, Icons.electrical_services, 'Listrik'),
                      _buildCategory(context, Icons.plumbing, 'Ledeng'),
                      _buildCategory(context, Icons.format_paint, 'Cat'),
                      const SizedBox(width: 8),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                const Text(
                  'Tukang Terdekat',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
              ],
            ),
          ),

          // List Tukang
          ...tukangs.map(
            (t) => TukangCard(
              tukang: t,
              onView: () => Navigator.pushNamed(
                context,
                '/profile',
                arguments: {'tukang': t},
              ),
              onBook: () => Navigator.pushNamed(
                context,
                '/booking',
                arguments: {'tukang': t},
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Category Builder
  Widget _buildCategory(BuildContext context, IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                )
              ],
            ),
            padding: const EdgeInsets.all(14),
            child: Icon(icon, color: Theme.of(context).primaryColor),
          ),
          const SizedBox(height: 8),
          Text(label),
        ],
      ),
    );
  }
}
