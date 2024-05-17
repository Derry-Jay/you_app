import '../../utils/enums.dart';

class Field {
  final FieldType type;
  final String name, hint;
  Field(this.name, this.type, this.hint);

  @override
  bool operator ==(Object other) =>
      other is Field && other.name == name && other.type == type;

  @override
  // TODO: implement hashCode
  int get hashCode => name.hashCode + type.hashCode;
}
