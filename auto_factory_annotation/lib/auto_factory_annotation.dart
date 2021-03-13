import 'dart:async';

/// Builds a factory shared part and so makes class injectable
class AutoFactory {
  const AutoFactory();
}

/// Same as Component(), but the class instance is cached
class CachingFactory {
  const CachingFactory();
}

/// Creates a provier. should implement the ProviderBase<T> abstract class
class Provider {
  const Provider();
}

abstract class ProviderBase<T> {
  Future<T> provide();
}

class Provided {
  final Type provider;
  const Provided(this.provider);
}

typedef ProviderFn = FutureOr<Object> Function();
