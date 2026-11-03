import SwiftUI

extension VLDataError
{
 /// A part of an error view given to a style (symbol, title, description, actions).
 /// The style places it and can change its font and colors with the usual modifiers.
 public struct StyleContent: View
 {
  public let body: AnyView

  internal init<CONTENT: View>(_ content: CONTENT)
  {
   body = AnyView(content)
  }
 }
}
