import 'package:auto_factory_annotation/auto_factory_annotation.dart';
import 'package:source_gen_test/annotations.dart';

import '_fifth_dep.dart';

@ShouldGenerate('''
class FifthDepProviderFactory {
  static final FifthDepProviderFactory _singleton =
      FifthDepProviderFactory._internal();

  factory FifthDepProviderFactory() {
    return _singleton;
  }

  FifthDepProviderFactory._internal();

  FifthDepProvider _objectInstance?;

  Future<FifthDepProvider> create() async {

    _objectInstance ??= FifthDepProvider(
    );

    return _objectInstance!;
  }
}
''')
@Provider(asyncMode: true)
class FifthDepProvider implements ProviderBase<FifthDep> {
  @override
  Future<FifthDep> provide() async {
    return FifthDep();
  }
}
