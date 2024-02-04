import 'package:flutter_test/flutter_test.dart';

// import 'package:conductor/conductor.dart';

void main() {
  // a test to make sure the tests are running
  group("Math Check", () {
    test(
      "2+2=4",
      () => {
        expect(
          2 + 2,
          4,
        ),
      },
    );
  });
}
