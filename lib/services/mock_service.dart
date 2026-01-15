import 'package:intl/intl.dart';
import '../models/tukang.dart';

class MockService {
  final List<Map<String, dynamic>> _data = [
    {
      'id': 't1',
      'name': 'Budi Listrik',
      'expertise': 'Tukang Listrik',
      'rating': 4.9,
      'reviews': 320,
      'priceFrom': 75000,
      'distanceKm': 1.2,
      'avatarUrl': '',
      'bio': 'Berpengalaman 8 tahun instalasi & perbaikan listrik.'
    },
    {
      'id': 't2',
      'name': 'Sari AC',
      'expertise': 'Tukang AC',
      'rating': 4.8,
      'reviews': 210,
      'priceFrom': 120000,
      'distanceKm': 2.5,
      'avatarUrl': '',
      'bio': 'Pasang & servis AC. Cepat dan rapi.'
    },
    {
      'id': 't3',
      'name': 'Anton Plumbing',
      'expertise': 'Tukang Ledeng',
      'rating': 4.7,
      'reviews': 150,
      'priceFrom': 65000,
      'distanceKm': 0.8,
      'avatarUrl': '',
      'bio': 'Menangani kebocoran, instalasi pipa, saluran.'
    },
  ];

  List<Tukang> getTukangs() {
    return _data.map((m) => Tukang.fromMap(m)).toList();
  }

  Tukang? getById(String id) {
    final item = _data.firstWhere((e) => e['id'] == id, orElse: () => {});
    if (item.isEmpty) return null;
    return Tukang.fromMap(item);
  }

  Map<String, dynamic> createOrder({
    required Tukang tukang,
    required DateTime schedule,
    required String address,
    required String notes,
    required double priceEstimate,
  }) {
    final id = 'ORD${DateTime.now().millisecondsSinceEpoch}';
    final order = {
      'id': id,
      'tukangId': tukang.id,
      'tukangName': tukang.name,
      'schedule': schedule.toIso8601String(),
      'address': address,
      'notes': notes,
      'priceEstimate': priceEstimate,
      'status': 'pending',
      'createdAt': DateTime.now().toIso8601String(),
    };
    // In mock service we don't persist, return order object
    return order;
  }

  String formatCurrency(double value) {
    final format = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return format.format(value);
  }
}
