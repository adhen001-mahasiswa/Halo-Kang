import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<User?> register({
    required String email,
    required String password,
    required String role,
    String? name,
  }) async {
    // 1. BUAT USER AUTH
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = credential.user;
    if (user == null) return null;

    // 2. SIMPAN DATA USER KE FIRESTORE
    await _db.collection('users').doc(user.uid).set({
      'uid': user.uid,
      'email': email,
      'role': role,
      'name': name ?? '',
      'createdAt': FieldValue.serverTimestamp(),
    });

    return user;
  }

  Future<User?> login({
    required String email,
    required String password,
  }) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential.user;
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  User? get currentUser => _auth.currentUser;

  Future<String?> getUserRole(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    return doc.data()?['role'];
  }
}
