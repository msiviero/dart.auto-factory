import 'lib/src/application.dart';

void main() {
  final app = ApplicationFactory().get();

  app.greet();
}
