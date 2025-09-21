import Foundation
import VLstackNamespace

extension VLstack.DataError
{
 /// Represents a simple error description in VLErrorKit.
 /// Conforms to Identifiable, Hashable, and Equatable.
 package struct Description: Identifiable, Hashable, Equatable
 {
  /// Unique identifier for this description instance.
  package let id = UUID()

  /// Text value of the error description.
  package let value: String

  /// Hashes the description using its unique id and value.
  package func hash(into hasher: inout Hasher)
  {
   hasher.combine(id)
   hasher.combine(value)
  }
 }
}
