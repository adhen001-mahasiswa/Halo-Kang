import 'package:cloud_firestore/cloud_firestore.dart';

class OrderService {
  final _db = FirebaseFirestore.instance;

  /// CREATE ORDER (USER)
  Future<void> createOrder(Map<String, dynamic> data) async {
    await _db.collection('orders').add(data);
  }

  /// ORDERS FOR MITRA (REALTIME)
  Stream<QuerySnapshot> getOrdersForMitra(String mitraId) {
    return _db
        .collection('orders')
        .where('mitraId', isEqualTo: mitraId)
        .where('status', isEqualTo: 'pending')
        .snapshots();
  }

  /// ORDERS HISTORY (USER / MITRA)
  Stream<QuerySnapshot> getOrderHistory({
    required String field,
    required String uid,
  }) {
    return _db
        .collection('orders')
        .where(field, isEqualTo: uid)
        .where('status', isEqualTo: 'done')
        .snapshots();
  }

  /// UPDATE STATUS
  Future<void> updateStatus(String orderId, String status) async {
    await _db.collection('orders').doc(orderId).update({
      'status': status,
    });
  }
}
