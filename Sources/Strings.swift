import VLstackNamespace

extension VLstack.DataError
{
 public struct Strings: Sendable
 {
  package let defaultAlertTitle: String
  package let defaultAlertMessage: String

  public init(defaultAlertTitle: String,
              defaultAlertMessage: String)
  {
   self.defaultAlertTitle = defaultAlertTitle
   self.defaultAlertMessage = defaultAlertMessage
  }
 }
}
