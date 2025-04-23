import Foundation
import VLstackNamespace

extension VLstack.DataError
{
 package struct Description: Identifiable, Hashable, Equatable
 {
  package let id = UUID()
  package let value: String

  package func hash(into hasher: inout Hasher)
  {
   hasher.combine(id)
   hasher.combine(value)
  }
 }
}
