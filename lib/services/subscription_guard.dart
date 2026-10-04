import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SubscriptionGuard {
  Future<bool> isActive() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return false;

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    final data = doc.data();
    if (data == null || data['subscriptionActive'] != true) return false;

    final expires = data['subscriptionExpiresAt'];
    if (expires is Timestamp && expires.toDate().isBefore(DateTime.now())) {
      return false;
    }

    return true;
  }
}
