import SwiftUI

extension VLDataError
{
 /// SwiftUI ViewModifier that displays an alert for a given context error.
 /// The message shows the context title, then its description lines.
 /// - Parameters:
 ///   - title: Optional custom title for the alert. Defaults to a localized "Error".
 ///   - target: Optional target context to match before showing the alert.
 ///   - contextError: Binding to the context error to display.
 package struct AlertModifier<CONTEXTTYPE: VLDataError.ContextType>: ViewModifier
 {
  private let title: String?
  private let target: CONTEXTTYPE?
  @Binding private var contextError: VLDataError.Context<CONTEXTTYPE>?

  public init(title: String? = nil,
              target: CONTEXTTYPE? = nil,
              contextError data: Binding<VLDataError.Context<CONTEXTTYPE>?>)
  {
   self.title = title
   self.target = target
   self._contextError = data
  }

  public func body(content: Content) -> some View
  {
   content
    .alert(title ?? VLDataError.localized("I18N-VLErrorKit.Error"),
           isPresented: Binding<Bool>(get: { contextError?.isEqual(target) == true },
                                      set: { if !$0 { contextError = nil } }),
           presenting: contextError,
           actions: { _ in },
           message: { Text(verbatim: $0.alertMessage) })
  }
 }
}

extension View
{
 /// Displays an alert for a given context error in this view hierarchy.
 /// - Parameters:
 ///   - title: Optional custom title for the alert.
 ///   - target: Optional target context to match before showing the alert.
 ///   - contextError: Binding to the context error to display.
 public func alert<CONTEXTTYPE: VLDataError.ContextType>(title: String? = nil,
                   target: CONTEXTTYPE? = nil,
                   error contextError: Binding<VLDataError.Context<CONTEXTTYPE>?>) -> some View
 {
  self.modifier(VLDataError.AlertModifier(title: title,
                                          target: target,
                                          contextError: contextError))
 }
}
