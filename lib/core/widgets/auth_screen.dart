import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../services/auth_service.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  @override State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _service = AuthService();
  bool _registerMode = false, _loading = false, _obscure = true;
  String? _error;

  @override void dispose() { _email.dispose(); _password.dispose(); super.dispose(); }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() { _loading = true; _error = null; });
    try {
      if (_registerMode) {
        await _service.register(email: _email.text, password: _password.text);
      } else {
        await _service.signIn(email: _email.text, password: _password.text);
        await _service.ensureUserDocument();
      }
    } on FirebaseAuthException catch (e) {
      setState(() => _error = _message(e));
    } catch (_) {
      setState(() => _error = 'حدث خطأ غير متوقع. حاول مرة أخرى.');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _reset() async {
    final email = _email.text.trim();
    if (!email.contains('@')) { setState(() => _error = 'اكتب بريدك الإلكتروني أولاً.'); return; }
    try {
      await _service.sendPasswordReset(email);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم إرسال رابط إعادة تعيين كلمة المرور.')),
      );
    } on FirebaseAuthException catch (e) { setState(() => _error = _message(e)); }
  }

  String _message(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-credential':
      case 'wrong-password':
      case 'user-not-found': return 'البريد الإلكتروني أو كلمة المرور غير صحيحة.';
      case 'email-already-in-use': return 'هذا البريد مستخدم بالفعل.';
      case 'invalid-email': return 'البريد الإلكتروني غير صحيح.';
      case 'weak-password': return 'كلمة المرور ضعيفة. استخدم 6 أحرف على الأقل.';
      case 'too-many-requests': return 'محاولات كثيرة. انتظر قليلًا ثم حاول مجددًا.';
      case 'network-request-failed': return 'تعذر الاتصال بالإنترنت.';
      default: return e.message ?? 'تعذر إتمام العملية.';
    }
  }

  @override Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 440),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Form(
                      key: _formKey,
                      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                        const Icon(Icons.family_restroom, size: 64),
                        const SizedBox(height: 16),
                        Text(_registerMode ? 'إنشاء حساب ولي الأمر' : 'دخول ولي الأمر',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineSmall),
                        const SizedBox(height: 24),
                        TextFormField(
                          controller: _email,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(labelText: 'البريد الإلكتروني', border: OutlineInputBorder()),
                          validator: (v) => v == null || !v.contains('@') ? 'أدخل بريدًا صحيحًا' : null,
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _password,
                          obscureText: _obscure,
                          decoration: InputDecoration(
                            labelText: 'كلمة المرور', border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                              onPressed: () => setState(() => _obscure = !_obscure),
                              icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
                            ),
                          ),
                          validator: (v) => v == null || v.length < 6 ? 'كلمة المرور 6 أحرف على الأقل' : null,
                        ),
                        if (!_registerMode) Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(onPressed: _loading ? null : _reset, child: const Text('نسيت كلمة المرور؟')),
                        ),
                        if (_error != null) Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(_error!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
                        ),
                        const SizedBox(height: 16),
                        FilledButton(
                          onPressed: _loading ? null : _submit,
                          child: _loading
                              ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2))
                              : Text(_registerMode ? 'إنشاء الحساب' : 'تسجيل الدخول'),
                        ),
                        TextButton(
                          onPressed: _loading ? null : () => setState(() { _registerMode = !_registerMode; _error = null; }),
                          child: Text(_registerMode ? 'لدي حساب بالفعل' : 'إنشاء حساب جديد'),
                        ),
                      ]),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
