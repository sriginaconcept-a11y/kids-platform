import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import 'auth_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key, required this.authenticatedBuilder, this.authService});
  final WidgetBuilder authenticatedBuilder;
  final AuthService? authService;

  @override
  Widget build(BuildContext context) {
    final service = authService ?? AuthService();
    return StreamBuilder<User?>(
      stream: service.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        if (snapshot.data == null) return const AuthScreen();
        return Builder(builder: authenticatedBuilder);
      },
    );
  }
}
