import SwiftUI

extension VLDataError
{
 /// Appearance of an inline error, like `ButtonStyle`: the style draws the whole row,
 /// InlineView decides whether to show it (target, strict) and provides the parts to place
 @MainActor
 public protocol InlineStyle
 {
  associatedtype Body: View
  typealias Configuration = VLDataError.InlineStyleConfiguration
  @ViewBuilder func makeBody(configuration: Self.Configuration) -> Self.Body
 }

 /// What an inline style receives to draw one inline error
 public struct InlineStyleConfiguration
 {
  /// SF Symbol of the context
  public let symbol: VLDataError.StyleContent
  /// Title of the context
  public let title: VLDataError.StyleContent
  /// Description of the context; `nil` when there is none
  public let description: VLDataError.StyleContent?
 }

 internal struct AnyInlineStyle: VLDataError.InlineStyle
 {
  private let makeBodyClosure: (Configuration) -> AnyView

  internal init<S: VLDataError.InlineStyle>(_ style: S)
  {
   makeBodyClosure = { AnyView(style.makeBody(configuration: $0)) }
  }

  internal func makeBody(configuration: Configuration) -> some View
  {
   makeBodyClosure(configuration)
  }
 }
}

extension View
{
 /// Sets the style of the inline errors in this view hierarchy
 public func errorInlineStyle<S: VLDataError.InlineStyle>(_ style: S) -> some View
 {
  self.environment(\.errorInlineStyle, VLDataError.AnyInlineStyle(style))
 }
}
