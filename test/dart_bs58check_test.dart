import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:dart_bs58check/dart_bs58check.dart';
import 'package:test/test.dart';

import 'fixtures.dart';

void main() {
  if (fixtures.containsKey(FixtureEnum.valid)) {
    group('Valid', () {
      for (Fixture fixture in fixtures[FixtureEnum.valid]!) {
        test('decodes "${fixture.string}"', () {
          expect(hex.encode(bs58check.decode(fixture.string)), fixture.payload);
          expect(
              bs58check
                  .encode(Uint8List.fromList(hex.decode(fixture.payload!))),
              equals(fixture.string));
        });
      }
    });
    group('Invalid', () {
      for (Fixture fixture in fixtures[FixtureEnum.invalid]!) {
        test('"${fixture.string}" decoding throws "${fixture.exception}"', () {
          Uint8List? buffer;
          try {
            buffer = bs58check.decode(fixture.string);
          } catch (err) {
            expect((err as ArgumentError).message, fixture.exception);
          } finally {
            expect(buffer, null);
          }
        });
      }
    });
  }
}
