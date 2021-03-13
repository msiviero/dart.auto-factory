import 'package:auto_factory_annotation/auto_factory_annotation.dart';

import '../service/hello_service.dart';

part 'provider.g.dart';

@Provider()
class StringDependencyProvider implements ProviderBase<String> {
  final HelloService helloService;

  StringDependencyProvider(this.helloService);

  @override
  Future<String> provide() async {
    return helloService.who('Provided Name');
  }
}
