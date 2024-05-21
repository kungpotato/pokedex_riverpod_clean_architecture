import 'package:flutter_test/flutter_test.dart';

int add(int a, int b) {
  return a + b;
}

void main() {
  group('Calculator', () {
    test('adds two numbers', () {
      expect(add(2, 3), equals(5));
    });

    test('adds negative numbers', () {
      expect(add(-2, -3), equals(-5));
    });

    test('adds positive and negative numbers', () {
      expect(add(2, -3), equals(-1));
    });
  });
}
