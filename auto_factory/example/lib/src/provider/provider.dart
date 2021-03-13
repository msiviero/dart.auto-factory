import 'package:auto_factory_annotation/auto_factory_annotation.dart';

part 'provider.g.dart';

@Provider()
class StringDependencyProvider implements ProviderInterface<String> {
  @override
  Future<String> provide() async {
    return 'A string';
  }
}
