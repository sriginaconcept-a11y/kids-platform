import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class ChildProfileScreen extends StatefulWidget {
  const ChildProfileScreen({super.key, this.childId, this.initialData});
  final String? childId;
  final Map<String, dynamic>? initialData;
  @override State<ChildProfileScreen> createState() => _ChildProfileScreenState();
}

class _ChildProfileScreenState extends State<ChildProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _birthYear = TextEditingController();
  String _gender = 'غير محدد';
  bool _saving = false;

  bool get editing => widget.childId != null;

  @override void initState() {
    super.initState();
    final d = widget.initialData;
    if (d != null) {
      _name.text = (d['name'] ?? '').toString();
      _birthYear.text = (d['birthYear'] ?? '').toString();
      _gender = (d['gender'] ?? 'غير محدد').toString();
    }
  }

  @override void dispose() { _name.dispose(); _birthYear.dispose(); super.dispose(); }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final user = AuthService().currentUser;
    if (user == null) return;
    setState(() => _saving = true);
    try {
      final ref = widget.childId == null
          ? FirebaseFirestore.instance.collection('children').doc()
          : FirebaseFirestore.instance.collection('children').doc(widget.childId);
      final data = <String, dynamic>{
        'parentId': user.uid,
        'name': _name.text.trim(),
        'birthYear': int.parse(_birthYear.text.trim()),
        'gender': _gender,
        'updatedAt': FieldValue.serverTimestamp(),
      };
      if (!editing) data['createdAt'] = FieldValue.serverTimestamp();
      await ref.set(data, SetOptions(merge: editing));
      if (mounted) Navigator.of(context).pop(true);
    } on FirebaseException catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تعذر حفظ ملف الطفل: \${e.message ?? e.code}')));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override Widget build(BuildContext context) => Directionality(
    textDirection: TextDirection.rtl,
    child: Scaffold(
      appBar: AppBar(title: Text(editing ? 'تعديل ملف الطفل' : 'إضافة طفل')),
      body: Center(child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520),
        child: SingleChildScrollView(padding: const EdgeInsets.all(20), child: Form(
          key: _formKey,
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Text(editing ? 'تعديل بيانات الطفل' : 'إنشاء ملف طفل جديد',
              style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            const Text('هذه البيانات خاصة بحساب ولي الأمر.'),
            const SizedBox(height: 24),
            TextFormField(
              controller: _name, decoration: const InputDecoration(
                labelText: 'اسم الطفل', border: OutlineInputBorder()),
              validator: (v) => v == null || v.trim().length < 2 ? 'أدخل اسم الطفل' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _birthYear, keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'سنة الميلاد', border: OutlineInputBorder()),
              validator: (v) {
                final year = int.tryParse(v?.trim() ?? '');
                final current = DateTime.now().year;
                return year == null || year < current - 20 || year > current
                    ? 'أدخل سنة ميلاد صحيحة' : null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _gender,
              decoration: const InputDecoration(labelText: 'الجنس', border: OutlineInputBorder()),
              items: const [
                DropdownMenuItem(value: 'غير محدد', child: Text('غير محدد')),
                DropdownMenuItem(value: 'ذكر', child: Text('ذكر')),
                DropdownMenuItem(value: 'أنثى', child: Text('أنثى')),
              ],
              onChanged: (v) => setState(() => _gender = v ?? 'غير محدد'),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _saving ? null : _save,
              icon: _saving
                  ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Icon(Icons.save_outlined),
              label: Text(_saving ? 'جارٍ الحفظ...' : 'حفظ ملف الطفل'),
            ),
          ]),
        )),
      )),
    ),
  );
}
