import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/tukang.dart';
import '../models/order_firestore_model.dart';

class FirebaseService {
  FirebaseFirestore get _db => FirebaseFirestore.instance;

  // ======================
  // MITRA
  // ======================
  Stream<List<Tukang>> getTukangs() {
    return _db.collection('mitra').snapshots().map(
      (snapshot) {
        return snapshot.docs.map((doc) {
          return Tukang.fromMap(doc.id, doc.data());
        }).toList();
      },
    );
  }

  Stream<List<Tukang>> getTukangsByCategory(String category) {
    return _db
        .collection('mitra')
        .where('expertise', isEqualTo: category)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => Tukang.fromMap(doc.id, doc.data()))
              .toList(),
        );
  }

  // ======================
// UPDATE ORDER STATUS
// ======================
  Future<void> updateOrderStatus(String orderId, String status) async {
    await _db.collection('orders').doc(orderId).update({
      'status': status,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // ======================
// ORDERS (REALTIME)
// ======================
  Stream<List<OrderFirestoreModel>> getOrders() {
    return _db.collection('orders').snapshots().map(
      (snapshot) {
        return snapshot.docs
            .map(
              (doc) => OrderFirestoreModel.fromMap(
                doc.id,
                doc.data(),
              ),
            )
            .toList();
      },
    );
  }

  Stream<QuerySnapshot> getOrdersByStatus(
    String mitraId,
    String status,
  ) {
    return _db
        .collection('orders')
        .where('mitraId', isEqualTo: mitraId)
        .where('status', isEqualTo: status)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<void> createOrder(Map<String, dynamic> data) async {
    await _db.collection('orders').add(data);
  }

  // ======================
  // USERS
  // ======================
  Future<void> saveUser(String uid, Map<String, dynamic> data) async {
    await _db.collection('users').doc(uid).set(data);
  }
}
