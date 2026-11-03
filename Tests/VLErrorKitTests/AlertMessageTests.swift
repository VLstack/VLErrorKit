import Testing
@testable import VLErrorKit

/// Message displayed by the alert: the title, then the description lines after an empty line
@Suite("Alert message")
struct AlertMessageTests
{
 @Test("Without description nor error, the message is the title")
 func titleOnly()
 {
  #expect(TestContext(.fatal, "Title").alertMessage == "Title")
 }

 @Test("The description follows the title after an empty line")
 func withDescription()
 {
  let context = TestContext(.fatal, "Title", description: "First\nSecond")

  #expect(context.alertMessage == "Title\n\nFirst\nSecond")
 }

 @Test("The underlying error follows a different description")
 func withDescriptionAndError()
 {
  let context = TestContext(.fatal, "Title", description: "Details", error: SampleError())

  #expect(context.alertMessage == "Title\n\nDetails\n\n\nsample failure")
 }
}
