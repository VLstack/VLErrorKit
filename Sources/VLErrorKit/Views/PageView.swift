import VLstackNamespace
import SwiftUI

extension VLstack.DataError
{
 /// A full-screen SwiftUI view displaying an error context with optional dismissal.
 /// Composes DescriptionView and overlays a dismiss button if enabled.
 public struct PageView<CONTEXTTYPE: VLstack.DataError.ContextType>: View
 {
  @Environment(\.dismiss) private var dismiss
  @Environment(\.contextErrorPageStyle) private var style
  @Environment(\.contextErrorDismissEnabled) private var dismissEnabled

  private let context: VLstack.DataError.Context<CONTEXTTYPE>
  private let alignment: TextAlignment

  /// Creates a PageView for a given error context.
  /// - Parameters:
  ///   - context: The error context to display.
  ///   - alignment: Text alignment for the description. Default is `.center`.
  public init(_ context: VLstack.DataError.Context<CONTEXTTYPE>,
              alignment: TextAlignment = .center)
  {
   self.context = context
   self.alignment = alignment
  }

  /// Creates a PageView from a type, title, and underlying error.
  /// - Parameters:
  ///   - type: The type of the error context.
  ///   - title: The title of the error.
  ///   - error: The underlying error.
  ///   - alignment: Text alignment for the description. Default is `.center`.
  public init(_ type: CONTEXTTYPE,
              _ title: String,
              error: any Error,
              alignment: TextAlignment = .center)
  {
   self.init(VLstack.DataError.Context<CONTEXTTYPE>(type, title, error: error),
             alignment: alignment)
  }

  public var body: some View
  {
   VLstack.DataError.DescriptionView(context,
                                     alignment: alignment)
   .background(style.background)
   .ignoresSafeArea(.all)
   .overlay(alignment: .topTrailing)
   {
    if dismissEnabled
    {
     Button(action: { dismiss() })
     {
      Image(.xmark)
       .font(.system(size: 16, weight: .bold))
       .foregroundColor(.white)
       .padding(5)
       .background(Color.black.opacity(0.6))
       .clipShape(.circle)
     }
     .buttonStyle(.plain)
     .padding()
    }
   }
  }
 }
}
