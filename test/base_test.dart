import 'dart:typed_data';

import 'package:blake_hash/blake_hash.dart';
import 'package:convert/convert.dart';
import 'package:dart_bs58check/dart_bs58check.dart';
import 'package:test/test.dart';

Uint8List blake256x2(Uint8List buffer) {
  buffer = Blake256().update(buffer).digest();
  return Blake256().update(buffer).digest();
}

const bs58checkDiffChecksum = Base58CheckCodec(blake256x2);

void main() {
  test('custom checksum function (blake256x2)', () {
    const address = 'DsRLWShUQexhKE1yRdpe2kVH7fmULcEUFDk';
    final payload =
        hex.decode('073f0415e993935a68154fda7018b887c4e3fe8b4e10') as Uint8List;

    expect(bs58checkDiffChecksum.encode(payload), equals(address));
    expect(bs58checkDiffChecksum.decode(address), payload);
  });
}
