import 'package:auto_factory_annotation/auto_factory_annotation.dart';

import 'provider/provider.dart';
import 'service/hello_service.dart';

part 'application.g.dart';

@AutoFactory()
class Application {
  final HelloService helloService;
  final String aString;

  Application(
    this.helloService,
    @Provided(StringDependencyProvider) this.aString,
  );

  void greet() {
    final name = helloService.who('John Doe');
    print('Hello $name');
    print('A string $aString');
  }
}
