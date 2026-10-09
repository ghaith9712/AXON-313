import '../state/cart_controller.dart';

String formatIqd(int amount) {
  final digits = amount.abs().toString();
  final buffer = StringBuffer();
  if (amount < 0) buffer.write('-');
  for (var i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) buffer.write(',');
    buffer.write(digits[i]);
  }
  buffer.write(' د.ع');
  return buffer.toString();
}

String buildOrderMessage({
  required CartController cart,
  required String name,
  required String phone,
  required String note,
}) {
  final buffer = StringBuffer()
    ..writeln('طلب جديد من تطبيق AXON-313')
    ..writeln('الاسم: ${name.trim()}')
    ..writeln('الهاتف: ${phone.trim()}');
  final trimmedNote = note.trim();
  if (trimmedNote.isNotEmpty) {
    buffer.writeln('ملاحظة: $trimmedNote');
  }
  buffer.writeln();
  for (final line in cart.lines) {
    final lineTotal = line.product.priceIqd * line.quantity;
    buffer.writeln(
      '• ${line.product.name} × ${line.quantity} = ${formatIqd(lineTotal)}',
    );
  }
  buffer
    ..writeln()
    ..writeln('المجموع: ${formatIqd(cart.total)}')
    ..writeln('الدفع والتوصيل يُؤكدان عبر واتساب.');
  return buffer.toString().trim();
}

String buildInquiryMessage({
  required String name,
  required String email,
  required String phone,
  required String message,
}) {
  final buffer = StringBuffer()
    ..writeln('استفسار من تطبيق AXON-313')
    ..writeln('الاسم: ${name.trim()}')
    ..writeln('البريد: ${email.trim()}');
  final trimmedPhone = phone.trim();
  if (trimmedPhone.isNotEmpty) {
    buffer.writeln('الهاتف: $trimmedPhone');
  }
  buffer
    ..writeln()
    ..writeln(message.trim());
  return buffer.toString().trim();
}
