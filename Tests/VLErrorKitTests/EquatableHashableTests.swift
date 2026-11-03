import SwiftUI
import Testing
@testable import VLErrorKit

/// Equality and hash compare type, symbol, title and description
///
/// The symbol variant and the underlying error are ignored: current choice, still to be confirmed (TODO point 7)
@Suite("Context equality and hash")
struct EquatableHashableTests
{
 private let reference = TestContext(.fatal, "Title", systemImage: "trash", description: "Details")

 @Test("Same values are equal, with the same hash")
 func sameValues()
 {
  let other = TestContext(.fatal, "Title", systemImage: "trash", description: "Details")

  #expect(reference == other)
  #expect(reference.hashValue == other.hashValue)
 }

 @Test("Another type is not equal")
 func otherType()
 {
  #expect(reference != TestContext(.load, "Title", systemImage: "trash", description: "Details"))
 }

 @Test("Another title is not equal")
 func otherTitle()
 {
  #expect(reference != TestContext(.fatal, "Other", systemImage: "trash", description: "Details"))
 }

 @Test("Another description is not equal")
 func otherDescription()
 {
  #expect(reference != TestContext(.fatal, "Title", systemImage: "trash", description: "Other"))
  #expect(reference != TestContext(.fatal, "Title", systemImage: "trash"))
 }

 @Test("Another symbol is not equal")
 func otherSymbol()
 {
  #expect(reference != TestContext(.fatal, "Title", systemImage: "xmark", description: "Details"))
 }

 @Test("Only the symbol variant differs: still equal, same hash")
 func otherVariant()
 {
  let other = TestContext(.fatal, "Title", systemImage: "trash", symbolVariant: .fill, description: "Details")

  #expect(reference == other)
  #expect(reference.hashValue == other.hashValue)
 }

 @Test("Only the underlying error differs: still equal, same hash")
 func otherError()
 {
  let other = TestContext(.fatal, "Title", systemImage: "trash", description: "Details", error: SampleError())

  #expect(reference == other)
  #expect(reference.hashValue == other.hashValue)
 }

 @Test("Equal contexts are deduplicated in a set")
 func set()
 {
  let other = TestContext(.fatal, "Title", systemImage: "trash", symbolVariant: .fill, description: "Details")

  #expect(Set([ reference, other ]).count == 1)
 }
}
