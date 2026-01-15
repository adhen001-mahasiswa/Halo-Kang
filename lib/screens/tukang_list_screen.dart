import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/mock_service.dart';
import '../widgets/tukang_card.dart';

class TukangListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final service = Provider.of<MockService>(context, listen: false);
    final tukangs = service.getTukangs();

    return Scaffold(
      appBar: AppBar(title: Text('Daftar Tukang')),
      body: ListView(
        children: tukangs.map((t) => TukangCard(
          tukang: t,
          onView: () => Navigator.pushNamed(context, '/profile', arguments: {'tukang': t}),
          onBook: () => Navigator.pushNamed(context, '/booking', arguments: {'tukang': t}),
        )).toList(),
      ),
    );
  }
}
