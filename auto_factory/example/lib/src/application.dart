import 'package:auto_factory_annotation/auto_factory_annotation.dart';

import 'provider/provider.dart';
import 'service/hello_service.dart';

part 'application.g.dart';

@Injectable()
class Application {
  final HelloService helloService;
  final String providedName;

  Application(
    this.helloService,
    @ProvidedBy(HelloServiceProvider) this.providedName,
  );

  void greet() {
    final name = helloService.who('John Doe');
    print('Hello $name');
    print('Hello $providedName');
  }
}
