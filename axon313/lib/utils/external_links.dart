import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/company.dart';

Future<bool> openExternal(Uri uri) async {
  try {
    if (kIsWeb) {
      return await launchUrl(uri, webOnlyWindowName: '_blank');
    }
    return await launchUrl(uri, mode: LaunchMode.externalApplication);
  } catch (_) {
    return false;
  }
}

Uri whatsAppUri(String text) {
  return Uri.https('wa.me', '/${Company.whatsAppPhone}', {'text': text});
}

Uri mailUri({required String subject, required String body}) {
  return Uri(
    scheme: 'mailto',
    path: Company.email,
    query:
        'subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}',
  );
}
