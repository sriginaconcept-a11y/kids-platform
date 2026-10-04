import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  AuthService({FirebaseAuth? auth, FirebaseFirestore? firestore})
      : _auth = auth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  User? get currentUser => _auth.currentUser;
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<UserCredential> signIn({required String email, required String password}) =>
      _auth.signInWithEmailAndPassword(email: email.trim(), password: password);

  Future<UserCredential> register({required String email, required String password}) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email.trim(), password: password,
    );
    await ensureUserDocument(credential.user!);
    return credential;
  }

  Future<void> ensureUserDocument([User? suppliedUser]) async {
    final user = suppliedUser ?? _auth.currentUser;
    if (user == null) throw StateError('يجب تسجيل الدخول أولاً.');
    final ref = _firestore.collection('users').doc(user.uid);
    final snapshot = await ref.get();
    if (!snapshot.exists) {
      await ref.set({
        'role': 'parent',
        'email': user.email,
        'subscriptionActive': false,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } else {
      await ref.update({
        'email': user.email,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    }
  }

  Future<void> sendPasswordReset(String email) =>
      _auth.sendPasswordResetEmail(email: email.trim());

  Future<void> signOut() => _auth.signOut();
}
