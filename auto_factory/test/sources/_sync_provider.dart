import 'package:auto_factory_annotation/auto_factory_annotation.dart';

@Provider()
class ThirdDependencyProvider implements ProviderBase<String> {
  @override
  String provide() {
    return 'aString';
  }
}
