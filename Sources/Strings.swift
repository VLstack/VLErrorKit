import VLstackNamespace

extension VLstack.DataError
{
 public struct Strings: Sendable
 {
  let defaultAlertTitle: String
  let defaultAlertMessage: String

  init(defaultAlertTitle: String,
       defaultAlertMessage: String)
  {
   self.defaultAlertTitle = defaultAlertTitle
   self.defaultAlertMessage = defaultAlertMessage
  }
 }
}
