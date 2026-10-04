import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'core/widgets/auth_gate.dart';
import 'services/auth_service.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const KidsPlatformApp());
}

class KidsPlatformApp extends StatelessWidget {
  const KidsPlatformApp({super.key});
  @override Widget build(BuildContext context) => MaterialApp(
    title: 'منصة الأطفال',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
    home: AuthGate(authenticatedBuilder: (_) => const ParentHomePlaceholder()),
  );
}

class ParentHomePlaceholder extends StatelessWidget {
  const ParentHomePlaceholder({super.key});
  @override Widget build(BuildContext context) => Directionality(
    textDirection: TextDirection.rtl,
    child: Scaffold(
      appBar: AppBar(
        title: const Text('حساب ولي الأمر'),
        actions: [IconButton(onPressed: () => AuthService().signOut(), icon: const Icon(Icons.logout))],
      ),
      body: const Center(child: Text('تم تسجيل الدخول. الخطوة التالية: إضافة ملف الطفل.')),
    ),
  );
}
