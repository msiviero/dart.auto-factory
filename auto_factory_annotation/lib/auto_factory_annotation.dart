import 'dart:async';

/// Builds a factory shared part and so makes class injectable
class Injectable {
  final bool asyncMode;
  const Injectable({this.asyncMode = false});
}

/// Same as Component(), but the class instance is cached
class Singleton {
  final bool asyncMode;
  const Singleton({this.asyncMode = false});
}

/// Creates a provier. should implement the ProviderBase<T> abstract class
class Provider {
  final bool asyncMode;
  const Provider({this.asyncMode = false});
}

abstract class ProviderBase<T> {
  FutureOr<T> provide();
}

class ProvidedBy {
  final Type provider;
  const ProvidedBy(this.provider);
}
