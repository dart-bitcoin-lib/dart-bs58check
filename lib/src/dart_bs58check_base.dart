import 'dart:convert';
import 'dart:typed_data';

import 'package:dart_bs58check/src/converters/api.dart';

/// The canonical instance of [Base58CheckCodec].
const bs58check = Base58CheckCodec();

/// Base58 Check
class Base58CheckCodec extends Codec<Uint8List, String> {
  const Base58CheckCodec();

  @override
  Base58CheckDecoder get decoder => bs58CheckDecoder;

  @override
  Base58CheckEncoder get encoder => bs58CheckEncoder;
}
