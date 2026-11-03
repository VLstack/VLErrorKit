import Testing
@testable import VLErrorKit

@Suite("Context type matching")
struct IsEqualTests
{
 private let context = TestContext(.fatal, "Title")

 @Test("Non strict: a nil target matches")
 func nilTargetNonStrict()
 {
  #expect(context.isEqual(nil))
 }

 @Test("Strict: a nil target does not match")
 func nilTargetStrict()
 {
  #expect(!context.isEqual(nil, strict: true))
 }

 @Test("The same type matches", arguments: [ false, true ])
 func sameType(_ strict: Bool)
 {
  #expect(context.isEqual(.fatal, strict: strict))
 }

 @Test("Another type does not match", arguments: [ false, true ])
 func otherType(_ strict: Bool)
 {
  #expect(!context.isEqual(.load, strict: strict))
 }
}
