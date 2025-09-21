import VLstackNamespace

extension VLstack.DataError
{
 /// Marker protocol for types that can be used as a context in VLstack.DataError.
 /// Constrains conforming types to Hashable, Equatable, and Sendable.
 public protocol ContextType: Hashable, Equatable, Sendable
 {
 }
}
