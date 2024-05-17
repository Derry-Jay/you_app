import '../../extensions/extensions.dart';

class Reply extends Object {
  final int status;
  final String message;
  Reply(this.status, this.message);
  bool get isSuccess =>
      status == 200 || RegExp(r'[sS]uccess').hasMatch(message);
  factory Reply.fromMap(Map<String, Object?> json) {
    final message = json['message'];
    final msg = message is List?
        ? (List<String>.from(message ?? [])
            .map<String>((String e) => e.firstLetterCapitalized)
            .join(' / '))
        : message.string;
    return Reply(
        (json['status_code'] ?? json['statusCode']).string.toInt(), msg);
  }

  @override
  String toString() {
    // TODO: implement toString
    return message;
  }
}
