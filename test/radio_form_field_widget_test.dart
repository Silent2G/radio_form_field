import 'package:custom_form_field/radio_form_field.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('RadioFormField has a list of T items', (tester) async {
    List<String> items = ["No codename", "Cupcake", "Donut", "Eclair", "Froyo"];
    await tester.pumpWidget(RadioFormField<String>(items: items));
  });
}
