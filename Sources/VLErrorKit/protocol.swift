extension VLDataError
{
 /// Marker protocol for types that can be used as a context in VLDataError.
 /// Constrains conforming types to Hashable, Equatable, and Sendable.
 public protocol ContextType: Hashable, Equatable, Sendable {}
}
