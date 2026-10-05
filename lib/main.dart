import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'core/widgets/auth_gate.dart';
import 'services/auth_service.dart';
import 'screens/child_profile_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const KidsPlatformApp());
}

class KidsPlatformApp extends StatelessWidget {
  const KidsPlatformApp({super.key});
  @override Widget build(BuildContext context) => MaterialApp(
    title: 'منصة الأطفال', debugShowCheckedModeBanner: false,
    theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
    home: const AuthGate(authenticatedBuilder: (_) => ParentHome()),
  );
}

class ParentHome extends StatefulWidget {
  const ParentHome({super.key});
  @override State<ParentHome> createState() => _ParentHomeState();
}

class _ParentHomeState extends State<ParentHome> {
  final _auth = AuthService();

  Stream<QuerySnapshot<Map<String, dynamic>>> _childrenStream(String uid) =>
      FirebaseFirestore.instance.collection('children')
        .where('parentId', isEqualTo: uid).snapshots();

  Future<void> _openChild({String? id, Map<String, dynamic>? data}) async {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => ChildProfileScreen(childId: id, initialData: data)));
  }

  Future<void> _deleteChild(String id) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('حذف ملف الطفل؟'),
        content: const Text('سيتم حذف ملف الطفل وتقدمه المرتبط به.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('إلغاء')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('حذف')),
        ],
      ));
    if (ok != true) return;
    try {
      await FirebaseFirestore.instance.collection('children').doc(id).delete();
    } on FirebaseException catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تعذر حذف الملف: \${e.message ?? e.code}')));
    }
  }

  @override Widget build(BuildContext context) {
    final user = _auth.currentUser;
    if (user == null) return const SizedBox.shrink();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('لوحة ولي الأمر'),
          actions: [IconButton(onPressed: _auth.signOut, icon: const Icon(Icons.logout))]),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: _childrenStream(user.uid),
          builder: (context, snapshot) {
            if (snapshot.hasError) return const Center(
              child: Text('تعذر تحميل ملفات الأطفال.'));
            if (snapshot.connectionState == ConnectionState.waiting)
              return const Center(child: CircularProgressIndicator());
            final children = snapshot.data?.docs ?? [];
            return Center(child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: ListView(padding: const EdgeInsets.all(20), children: [
                Text('مرحبًا بك', style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 4), Text(user.email ?? ''),
                const SizedBox(height: 20),
                Card(child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [
                  const CircleAvatar(radius: 26, child: Icon(Icons.family_restroom)),
                  const SizedBox(width: 14),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('ملفات الأطفال', style: Theme.of(context).textTheme.titleLarge),
                    Text('\${children.length} طفل مسجل'),
                  ])),
                  FilledButton.icon(onPressed: () => _openChild(),
                    icon: const Icon(Icons.person_add_alt_1), label: const Text('إضافة طفل')),
                ]))),
                const SizedBox(height: 20),
                if (children.isEmpty)
                  Card(child: Padding(padding: const EdgeInsets.all(28), child: Column(children: [
                    const Icon(Icons.child_care_outlined, size: 48),
                    const SizedBox(height: 12),
                    Text('لا يوجد طفل بعد', style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 8),
                    const Text('ابدأ بإضافة أول ملف طفل للانتقال إلى المرحلة التعليمية.',
                      textAlign: TextAlign.center),
                    const SizedBox(height: 18),
                    FilledButton.icon(onPressed: () => _openChild(),
                      icon: const Icon(Icons.add), label: const Text('إضافة أول طفل')),
                  ])))
                else ...children.map((doc) => Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.child_care)),
                    title: Text((doc.data()['name'] ?? 'بدون اسم').toString()),
                    subtitle: Text('سنة الميلاد: \${doc.data()['birthYear'] ?? '—'} • \${doc.data()['gender'] ?? 'غير محدد'}'),
                    trailing: Wrap(children: [
                      IconButton(onPressed: () => _openChild(id: doc.id, data: doc.data()),
                        icon: const Icon(Icons.edit_outlined)),
                      IconButton(onPressed: () => _deleteChild(doc.id),
                        icon: const Icon(Icons.delete_outline)),
                    ]),
                  ),
                )),
                const SizedBox(height: 12),
                Card(child: ListTile(
                  leading: const Icon(Icons.school_outlined),
                  title: const Text('المحتوى التعليمي'),
                  subtitle: const Text('سيظهر هنا محتوى الطفل بعد ربط الدروس بملفه.'),
                  trailing: const Icon(Icons.lock_outline))),
                Card(child: ListTile(
                  leading: const Icon(Icons.credit_card_outlined),
                  title: const Text('الاشتراك'),
                  subtitle: const Text('حالة الاشتراك ستظهر هنا عند تفعيل نظام الدفع.'),
                  trailing: const Chip(label: Text('غير مفعل')))),
              ]),
            ));
          },
        ),
      ),
    );
  }
}
