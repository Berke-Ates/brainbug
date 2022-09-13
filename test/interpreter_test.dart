import 'package:brainbug/interpreter.dart';
import 'package:test/test.dart';

void main() {
  group('Interpreter', () {
    test('findBracketMatch() works with new lines', () {
      final Interpreter inter = Interpreter();
      inter.code = '[\n]';
      expect(inter.findBracketMatch(1), equals(0));
      expect(inter.findBracketMatch(0), equals(1));
    });

    test('findBracketMatch() works empty content', () {
      final Interpreter inter = Interpreter();
      inter.code = '[]';
      expect(inter.findBracketMatch(1), equals(0));
      expect(inter.findBracketMatch(0), equals(1));
    });
  });
}
