import 'dart:async';

import 'package:auto_factory_annotation/auto_factory_annotation.dart';

part 'name_provider.g.dart';

@Provider()
class NameProvider implements ProviderBase<String> {
  @override
  FutureOr<String> provide() {
    return 'Provided';
  }
}
