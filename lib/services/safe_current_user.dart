import 'package:firebase_auth/firebase_auth.dart';

User requireCurrentUser() {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    throw StateError('المستخدم غير مسجل الدخول.');
  }
  return user;
}
