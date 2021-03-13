import 'package:auto_factory_annotation/auto_factory_annotation.dart';

import 'provider/provider.dart';
import 'service/hello_service.dart';

part 'application.g.dart';

@AutoFactory()
class Application {
  final HelloService helloService;
  final String providedName;

  Application(
    this.helloService,
    @Provided(StringDependencyProvider) this.providedName,
  );

  void greet() {
    final name = helloService.who('John Doe');
    print('Hello $name + $providedName');
  }
}
