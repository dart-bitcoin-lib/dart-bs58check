import 'dart:typed_data';

import 'package:pointycastle/api.dart';

typedef ChecksumFn = Uint8List Function(Uint8List arg0);

/// SHA256 digest
Uint8List sha256(Uint8List data) {
  return Digest('SHA-256').process(data);
}

/// hash twice with sha256
Uint8List hash256(Uint8List data) {
  return sha256(sha256(data));
}
