import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import './generator.dart';

/// Provider called by build runner
Builder autoFactoryProviderBuilder(BuilderOptions options) => SharedPartBuilder(
      [
        ProviderGenerator(),
        InjectableGenerator(),
        SingletonFactoryGenerator(),
      ],
      'auto_factory',
    );
