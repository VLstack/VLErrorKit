import SwiftUI

extension VLDataError
{
 /// Appearance of an error page, like `ButtonStyle`: the style draws the whole page,
 /// PageView provides the parts to place (symbol, title, description, actions, dismiss button)
 @MainActor
 public protocol PageStyle
 {
  associatedtype Body: View
  typealias Configuration = VLDataError.PageStyleConfiguration
  @ViewBuilder func makeBody(configuration: Self.Configuration) -> Self.Body
 }

 /// What a page style receives to draw one error page
 public struct PageStyleConfiguration
 {
  /// SF Symbol of the context, hidden from VoiceOver
  public let symbol: VLDataError.StyleContent
  /// Title of the context
  public let title: VLDataError.StyleContent
  /// Description lines, already aligned; `nil` when there is no description
  public let description: VLDataError.StyleContent?
  /// Actions given to PageView, as provided (empty when there are none)
  public let actions: VLDataError.StyleContent
  /// Dismiss button; `nil` unless enabled with `.error(dismissEnabled: true)`
  public let dismissButton: VLDataError.DismissButton?
  /// Text alignment requested for the description
  public let alignment: TextAlignment
 }

 internal struct AnyPageStyle: VLDataError.PageStyle
 {
  private let makeBodyClosure: (Configuration) -> AnyView

  internal init<S: VLDataError.PageStyle>(_ style: S)
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
 /// Sets the style of the error pages in this view hierarchy
 public func errorPageStyle<S: VLDataError.PageStyle>(_ style: S) -> some View
 {
  self.environment(\.errorPageStyle, VLDataError.AnyPageStyle(style))
 }
}
