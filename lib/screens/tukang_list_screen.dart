import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/firebase_service.dart';
import '../models/tukang.dart';
import '../widgets/tukang_card.dart';

class TukangListScreen extends StatelessWidget {
  final String category;

  const TukangListScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<FirebaseService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Tukang $category'),
      ),
      body: StreamBuilder<List<Tukang>>(
        stream: service.getTukangsByCategory(category),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Tidak ada tukang'));
          }

          final tukangs = snapshot.data!;

          return ListView.builder(
            itemCount: tukangs.length,
            itemBuilder: (context, index) {
              final t = tukangs[index];
              return TukangCard(
                tukang: t,
                onView: () {
                  Navigator.pushNamed(
                    context,
                    '/profile',
                    arguments: {'tukang': t},
                  );
                },
                onBook: () {
                  Navigator.pushNamed(
                    context,
                    '/booking',
                    arguments: {'tukang': t},
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
