
import 'package:test/test.dart';
import '../lib/extensions/MapExtension.dart';

void main() {
  test('Test mergeIn method', (){
    final FIRST = 'first';
    final SECOND = 'second';
    final THIRD = 'third';

    Map<String, int> receiver = {
      FIRST: 1,
      SECOND: 2
    };

    Map<String, int> donner = {
      FIRST: 0,
      THIRD: 3
    };

    var merged = donner.mergeIn(receiver);

    expect(merged[FIRST]== 0, true);
    expect(merged[THIRD] , equals(3));

  });
}