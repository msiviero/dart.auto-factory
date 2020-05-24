import 'package:auto_factory/annotations.dart';

import 'service/hello_service.dart';

part 'application.g.dart';

@AutoFactory()
class Application {
  HelloService helloService;

  Application(this.helloService);

  void greet() {
    final name = helloService.who('John Doe');
    print('Hello $name');
  }
}
