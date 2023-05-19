import 'package:auto_factory/src/generator.dart';
import 'package:path/path.dart' as path;
import 'package:source_gen_test/source_gen_test.dart';

Future<void> main() async {
  initializeBuildLogTracking();

  testAnnotatedElements(
    await initializeLibraryReaderForDirectory(
      path.join('test', 'sources'),
      '_sync.dart',
    ),
    InjectableGenerator(),
  );
}
