import Testing
@testable import VLErrorKit

/// Lines displayed by the description view of PageView
@Suite("Description lines")
struct DescriptionLinesTests
{
 @Test("Without description nor error, there is no line")
 func noLine()
 {
  #expect(TestContext(.fatal, "Title").descriptionLines == [])
 }

 @Test("A single line description gives one line")
 func singleLine()
 {
  #expect(TestContext(.fatal, "Title", description: "Details").descriptionLines == [ "Details" ])
 }

 @Test("The description is split on new lines, empty lines are kept")
 func split()
 {
  let context = TestContext(.fatal, "Title", description: "First\n\nSecond\n")

  #expect(context.descriptionLines == [ "First", "", "Second", "" ])
 }

 @Test("A description taken from the error is not repeated")
 func descriptionFromError()
 {
  let context = TestContext(.fatal, "Title", error: SampleError())

  #expect(context.descriptionLines == [ "sample failure" ])
 }

 @Test("The error description is added after a different description, separated by two empty lines")
 func errorAppended()
 {
  let context = TestContext(.fatal, "Title", description: "First\nSecond", error: SampleError())

  #expect(context.descriptionLines == [ "First", "Second", "", "", "sample failure" ])
 }

 @Test("The error description is not added when it is already the last line")
 func errorAlreadyLast()
 {
  let context = TestContext(.fatal, "Title", description: "First\nsample failure", error: SampleError())

  #expect(context.descriptionLines == [ "First", "sample failure" ])
 }
}
