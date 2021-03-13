import 'lib/src/application.dart';

void main() async {
  final app = await ApplicationFactory().create();

  app.greet();
}
