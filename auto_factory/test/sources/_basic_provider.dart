import 'package:auto_factory_annotation/auto_factory_annotation.dart';
import 'package:source_gen_test/source_gen_test.dart';

import '_basic_fourth_dep.dart';
import '_basic_second_provider.dart';
import '_basic_third_dep.dart';
import '_fifth_dep.dart';

@ShouldGenerate('''
class ThirdDependencyProviderFactory {
  static final ThirdDependencyProviderFactory _singleton =
      ThirdDependencyProviderFactory._internal();

  factory ThirdDependencyProviderFactory() {
    return _singleton;
  }

  ThirdDependencyProviderFactory._internal();

  ThirdDependencyProvider _objectInstance?;

  Future<ThirdDependencyProvider> create() async {

    _objectInstance ??= ThirdDependencyProvider(
    );

    return _objectInstance!;
  }
}
''')
@Provider()
class ThirdDependencyProvider implements ProviderBase<ThirdDependency> {
  final FourthDep fourthDep;
  final FifthDep fifthDep;

  ThirdDependencyProvider(
    this.fourthDep,
    @ProvidedBy(FifthDepProvider) this.fifthDep,
  );

  @override
  Future<ThirdDependency> provide() async {
    return ThirdDependency();
  }
}
