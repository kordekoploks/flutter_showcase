import 'package:uuid/uuid.dart';

class UuidHelper {
  static final Uuid _uuid = Uuid();

  /// Generate a new UUID v4
  static String generateUUID() {
    return _uuid.v4();
  }

  static String generateNumericUUID() {
    var uuid = Uuid();
    String uuidString = uuid.v4().replaceAll('-', '');
    String numericUUID = '';

    for (int i = 0; i < uuidString.length; i++) {
      numericUUID += (uuidString.codeUnitAt(i) % 10).toString();
    }

    return numericUUID.substring(0, 3);
  }
}
