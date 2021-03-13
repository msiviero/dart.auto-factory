import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import './provider_generator.dart';

/// Provider called by build runner
Builder autoFactoryProviderBuilder(BuilderOptions options) => SharedPartBuilder(
      [
        ProviderGenerator(),
        FactoryGenerator(),
        CachingFactoryGenerator(),
      ],
      'auto_factory',
    );
