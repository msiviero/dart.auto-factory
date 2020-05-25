import 'package:auto_factory_annotation/auto_factory_annotation.dart';

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
