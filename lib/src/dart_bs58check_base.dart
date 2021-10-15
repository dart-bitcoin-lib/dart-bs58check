import 'dart:typed_data';

import 'package:dart_bs58check/src/utils/base_x.dart';
import 'package:pointycastle/api.dart';

/// SHA256 digest
Uint8List _sha256(Uint8List data) {
  return Digest('SHA-256').process(data);
}

/// hash twice with sha256
Uint8List _hash256(Uint8List data) {
  return _sha256(_sha256(data));
}

/// base converter
final BaseX _base58 =
    BaseX('123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz');

/// Encode Data
String encode(Uint8List payload) {
  Uint8List hash = _hash256(payload);
  Uint8List combine = Uint8List.fromList(
      [payload, hash.sublist(0, 4)].expand((i) => i).toList(growable: false));
  return _base58.encode(combine);
}

/// Decode Raw Data
Uint8List decodeRaw(Uint8List buffer) {
  Uint8List payload = buffer.sublist(0, buffer.length - 4);
  Uint8List checksum = buffer.sublist(buffer.length - 4);
  Uint8List newChecksum = _hash256(payload);
  if (checksum[0] != newChecksum[0] ||
      checksum[1] != newChecksum[1] ||
      checksum[2] != newChecksum[2] ||
      checksum[3] != newChecksum[3]) {
    throw ArgumentError("Invalid checksum");
  }
  return payload;
}

/// Decode Data
Uint8List decode(String data) {
  final buf = _base58.decode(data);
  return decodeRaw(buf);
}
