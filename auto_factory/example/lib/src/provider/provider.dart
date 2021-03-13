import 'package:auto_factory_annotation/auto_factory_annotation.dart';

import '../service/hello_service.dart';
import 'name_provider.dart';

part 'provider.g.dart';

@Provider()
class HelloServiceProvider implements ProviderBase<String> {
  final HelloService helloService;
  final String who;

  HelloServiceProvider(
    this.helloService,
    @ProvidedBy(NameProvider) this.who,
  );

  @override
  Future<String> provide() async {
    return helloService.who(who);
  }
}
