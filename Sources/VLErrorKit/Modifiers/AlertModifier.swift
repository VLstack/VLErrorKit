import VLstackNamespace
import VLBundleKit
import SwiftUI

extension VLstack.DataError
{
 package struct AlertModifier<CONTEXTTYPE: VLstack.DataError.ContextType>: ViewModifier
 {
  private let title: String?
  private let target: CONTEXTTYPE?
  @Binding private var contextError: VLstack.DataError.Context<CONTEXTTYPE>?

  public init(title: String? = nil,
              target: CONTEXTTYPE? = nil,
              contextError data: Binding<VLstack.DataError.Context<CONTEXTTYPE>?>)
  {
   self.title = title
   self.target = target
   self._contextError = data
  }

  public func body(content: Content) -> some View
  {
   content
    .alert(title ?? Bundle.main.localizedString("I18N-VLErrorKit.Error",
                                                fallbackModule: .module),
          isPresented: Binding<Bool>(get: { contextError != nil && contextError?.isEqual(target) == true },
                                     set: { _ in contextError = nil }),
          actions: {},
          message:
          {
           Text(verbatim: contextError?.title ?? Bundle.main.localizedString("I18N-VLErrorKit.UnexpectedIssue",
                                                                             fallbackModule: .module))
          })
  }
 }
}

extension View
{
 public func alert<CONTEXTTYPE: VLstack.DataError.ContextType>(title: String? = nil,
                   target: CONTEXTTYPE? = nil,
                   error contextError: Binding<VLstack.DataError.Context<CONTEXTTYPE>?>) -> some View
 {
  self.modifier(VLstack.DataError.AlertModifier(title: title,
                                                target: target,
                                                contextError: contextError))
 }
}
