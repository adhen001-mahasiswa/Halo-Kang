import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/mock_service.dart';
import '../models/tukang.dart';
import '../widgets/tukang_card.dart';

class TukangListScreen extends StatelessWidget {
  final String category;

  const TukangListScreen({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<MockService>(context, listen: false);

    final allTukangs = service.getTukangs();

    final tukangs = category == 'All'
        ? allTukangs
        : allTukangs
            .where((t) =>
                t.expertise.toLowerCase().contains(category.toLowerCase()))
            .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFDFD0B8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFDFD0B8),
        elevation: 0,
        title: Text(
          category == 'All' ? 'Semua Tukang' : 'Tukang $category',
          style: const TextStyle(
            color: Color(0xFF222831),
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF222831)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: tukangs.isEmpty
            ? [
                const Center(
                  child: Text(
                    'Tidak ada tukang tersedia',
                    style: TextStyle(color: Colors.black54),
                  ),
                )
              ]
            : tukangs
                .map(
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
                )
                .toList(),
      ),
    );
  }
}
