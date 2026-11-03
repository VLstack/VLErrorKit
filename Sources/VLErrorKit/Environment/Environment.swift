import SwiftUI

extension EnvironmentValues
{
 /// `nil` until `.errorPageStyle(_:)` is used: PageView then draws with `VLDataError.DefaultPageStyle`
 @Entry internal var errorPageStyle: VLDataError.AnyPageStyle? = nil
 /// `nil` until `.errorInlineStyle(_:)` is used: InlineView then draws with `VLDataError.DefaultInlineStyle`
 @Entry internal var errorInlineStyle: VLDataError.AnyInlineStyle? = nil
 @Entry internal var contextErrorDismissEnabled: Bool = false
}

extension View
{
 /// Enable or disable the dismiss button on the error page. Disabled by default:
 /// enable it when the error page is presented (sheet, full screen cover) with no other way to leave it.
 public func error(dismissEnabled state: Bool) -> some View
 {
  self.environment(\.contextErrorDismissEnabled, state)
 }
}
