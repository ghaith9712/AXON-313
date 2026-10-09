import 'package:flutter/material.dart';

import '../data/company.dart';
import '../theme/app_colors.dart';
import '../utils/external_links.dart';
import '../utils/formatting.dart';
import '../widgets/axon_card.dart';
import '../widgets/directional_value.dart';
import '../widgets/page_banner.dart';
import '../widgets/page_scroll.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _message = TextEditingController();
  bool _sending = false;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _phone.dispose();
    _message.dispose();
    super.dispose();
  }

  Future<void> _send({required bool email}) async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _sending = true);
    final body = buildInquiryMessage(
      name: _name.text,
      email: _email.text,
      phone: _phone.text,
      message: _message.text,
    );
    final uri = email
        ? mailUri(subject: 'استفسار من ${Company.name}', body: body)
        : whatsAppUri(body);
    final opened = await openExternal(uri);
    if (!mounted) return;
    setState(() => _sending = false);
    if (!opened) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تعذر فتح تطبيق التواصل على هذا الجهاز.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PageScroll(
      children: [
        const SizedBox(height: 8),
        const PageBanner(
          eyebrow: 'تواصل',
          title: 'تواصل معنا',
          subtitle: 'صف المشروع باختصار، ونرد خلال أوقات العمل.',
        ),
        const SizedBox(height: 24),
        LayoutBuilder(
          builder: (context, constraints) {
            final stacked = constraints.maxWidth < 800;
            final form = AxonCard(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'رسالة جديدة',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _name,
                      decoration: const InputDecoration(
                        labelText: 'الاسم الكامل',
                      ),
                      validator: _required,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'البريد الإلكتروني',
                      ),
                      validator: (value) {
                        final text = value?.trim() ?? '';
                        if (text.isEmpty || !text.contains('@')) {
                          return 'أدخل بريداً صحيحاً';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _phone,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: 'رقم الهاتف (اختياري)',
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _message,
                      minLines: 4,
                      maxLines: 6,
                      decoration: const InputDecoration(
                        labelText: 'صف مشروعك أو استفسارك',
                        alignLabelWithHint: true,
                      ),
                      validator: _required,
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        FilledButton.icon(
                          onPressed: _sending
                              ? null
                              : () => _send(email: false),
                          icon: const Icon(Icons.chat_outlined),
                          label: const Text('إرسال عبر واتساب'),
                        ),
                        OutlinedButton.icon(
                          onPressed: _sending ? null : () => _send(email: true),
                          icon: const Icon(Icons.mail_outline),
                          label: const Text('إرسال بالبريد'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
            final facts = const AxonCard(
              child: Column(
                children: [
                  _ContactRow(
                    icon: Icons.place_outlined,
                    title: 'موقعنا',
                    value: Company.city,
                  ),
                  _ContactRow(
                    icon: Icons.call_outlined,
                    title: 'اتصل بنا',
                    value: Company.phoneDisplay,
                    ltr: true,
                  ),
                  _ContactRow(
                    icon: Icons.mail_outline,
                    title: 'البريد الإلكتروني',
                    value: Company.email,
                    ltr: true,
                  ),
                  _ContactRow(
                    icon: Icons.schedule_outlined,
                    title: 'أوقات العمل',
                    value: Company.hours,
                  ),
                ],
              ),
            );
            if (stacked) {
              return Column(
                children: [form, const SizedBox(height: 16), facts],
              );
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: form),
                const SizedBox(width: 16),
                Expanded(child: facts),
              ],
            );
          },
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          children: [
            TextButton(
              onPressed: () => openExternal(Uri.parse(Company.facebook)),
              child: const Text('فيسبوك'),
            ),
            TextButton(
              onPressed: () => openExternal(Uri.parse(Company.twitter)),
              child: const Text('تويتر'),
            ),
            TextButton(
              onPressed: () => openExternal(Uri.parse(Company.instagram)),
              child: const Text('إنستغرام'),
            ),
          ],
        ),
      ],
    );
  }
}

String? _required(String? value) {
  if (value == null || value.trim().isEmpty) return 'هذا الحقل مطلوب';
  return null;
}

class _ContactRow extends StatelessWidget {
  const _ContactRow({
    required this.icon,
    required this.title,
    required this.value,
    this.ltr = false,
  });

  final IconData icon;
  final String title;
  final String value;
  final bool ltr;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: AppColors.green),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.labelLarge
                      ?.copyWith(color: AppColors.muted),
                ),
                DirectionalValue(value: value, ltr: ltr),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
