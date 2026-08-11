import 'dart:math';

class ExplorerIdGenerator {
  ExplorerIdGenerator._();

  static const List<String> _suffixes = [
    'DELTA',
    'OMEGA',
    'SIGMA',
    'ALPHA',
    'NOVA',
    'ORION',
    'ATLAS',
    'ANUBIS',
  ];

  static String generate() {
    final random = Random();
    final number = 100 + random.nextInt(900);
    final suffix = _suffixes[random.nextInt(_suffixes.length)];
    return 'TX-$number-$suffix';
  }
}
