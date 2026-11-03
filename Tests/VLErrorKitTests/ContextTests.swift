import SwiftUI
import Testing
@testable import VLErrorKit

@Suite("Context default values")
struct ContextTests
{
 @Test("Without symbol, the info circle symbol is used")
 func defaultSymbol()
 {
  let context = TestContext(.fatal, "Title")

  #expect(context.systemImage == "info")
  #expect(context.symbolVariant == .circle)
 }

 @Test("With a symbol but no variant, the variant is none")
 func symbolWithoutVariant()
 {
  let context = TestContext(.fatal, "Title", systemImage: "trash")

  #expect(context.systemImage == "trash")
  #expect(context.symbolVariant == .none)
 }

 @Test("With a symbol and a variant, both are kept")
 func symbolWithVariant()
 {
  let context = TestContext(.fatal, "Title", systemImage: "trash", symbolVariant: .fill)

  #expect(context.systemImage == "trash")
  #expect(context.symbolVariant == .fill)
 }

 @Test("A variant without symbol is ignored")
 func variantWithoutSymbol()
 {
  let context = TestContext(.fatal, "Title", symbolVariant: .fill)

  #expect(context.systemImage == "info")
  #expect(context.symbolVariant == .circle)
 }

 @Test("A given description is kept, even with an error")
 func givenDescription()
 {
  let context = TestContext(.fatal, "Title", description: "Details", error: SampleError())

  #expect(context.description == "Details")
 }

 @Test("Without description, the error description is used")
 func descriptionFromError()
 {
  let context = TestContext(.fatal, "Title", error: SampleError())

  #expect(context.description == "sample failure")
 }

 @Test("Without description nor error, the description is nil")
 func noDescription()
 {
  let context = TestContext(.fatal, "Title")

  #expect(context.description == nil)
  #expect(context.error == nil)
 }

 @Test("The title and the underlying error are kept")
 func titleAndError()
 {
  let context = TestContext(.fatal, "Title", error: SampleError())

  #expect(context.title == "Title")
  #expect(context.error is SampleError)
 }
}
