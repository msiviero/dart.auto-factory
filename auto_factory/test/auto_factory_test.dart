import 'package:auto_factory/src/provider_generator.dart';
import 'package:path/path.dart' as path;
import 'package:source_gen_test/source_gen_test.dart';

Future<void> main() async {
  initializeBuildLogTracking();

  testAnnotatedElements(
    await initializeLibraryReaderForDirectory(
      path.join('test', 'sources'),
      '_basic.dart',
    ),
    FactoryGenerator(),
  );

  testAnnotatedElements(
    await initializeLibraryReaderForDirectory(
      path.join('test', 'sources'),
      '_caching.dart',
    ),
    CachingFactoryGenerator(),
  );
}
