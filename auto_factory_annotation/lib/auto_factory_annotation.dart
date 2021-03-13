import 'dart:async';

/// Builds a factory shared part and so makes class injectable
class Injectable {
  const Injectable();
}

/// Same as Component(), but the class instance is cached
class Singleton {
  const Singleton();
}

/// Creates a provier. should implement the ProviderBase<T> abstract class
class Provider {
  const Provider();
}

abstract class ProviderBase<T> {
  FutureOr<T> provide();
}

class ProvidedBy {
  final Type provider;
  const ProvidedBy(this.provider);
}
