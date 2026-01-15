import 'package:flutter/material.dart';
import '../models/tukang.dart';
import 'primary_button.dart';

class TukangCard extends StatelessWidget {
  final Tukang tukang;
  final VoidCallback onView;
  final VoidCallback onBook;

  const TukangCard({required this.tukang, required this.onView, required this.onBook, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical:8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            CircleAvatar(radius:30, backgroundColor: Colors.grey[200], child: Icon(Icons.person, size:30, color: Colors.grey[600])),
            SizedBox(width:12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(tukang.name, style: TextStyle(fontWeight: FontWeight.w600)),
                  SizedBox(height:4),
                  Text(tukang.expertise + ' • ${tukang.distanceKm} km', style: TextStyle(color: Colors.grey[600])),
                  SizedBox(height:8),
                  Row(
                    children: [
                      Icon(Icons.star, size:14, color: Colors.amber),
                      SizedBox(width:4),
                      Text('${tukang.rating} (${tukang.reviews})', style: TextStyle(fontSize:12)),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('Mulai dari', style: TextStyle(fontSize:12, color: Colors.grey[600])),
                Text('Rp ${tukang.priceFrom.toInt()}', style: TextStyle(fontWeight: FontWeight.w700)),
                SizedBox(height:8),
                SizedBox(
                  width:100,
                  child: PrimaryButton(text: 'Pesan', onPressed: onBook, small: true),
                ),
                SizedBox(height:6),
                TextButton(onPressed: onView, child: Text('Detail')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
