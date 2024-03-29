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

/// Should be implemented by every provider concrete class
abstract class ProviderBase<T> {
  Future<T> provide();
}

/// Marks that a is provided by a provider, specifying the type
class ProvidedBy {
  final Type provider;
  const ProvidedBy(this.provider);
}
