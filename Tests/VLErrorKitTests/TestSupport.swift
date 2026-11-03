import Foundation
@testable import VLErrorKit

/// Context type used by all the tests
enum TestContextType: VLDataError.ContextType
{
 case fatal
 case load
}

typealias TestContext = VLDataError.Context<TestContextType>

/// Error with a known localized description
struct SampleError: LocalizedError
{
 let message: String

 init(_ message: String = "sample failure")
 {
  self.message = message
 }

 var errorDescription: String? { message }
}
