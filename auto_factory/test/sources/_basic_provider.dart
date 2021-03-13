import 'package:auto_factory_annotation/auto_factory_annotation.dart';

import '_basic_third_dep.dart';

@Provider()
class ThirdDependencyProvider implements ProviderBase<ThirdDependency> {
  @override
  Future<ThirdDependency> provide() async {
    return ThirdDependency();
  }
}
