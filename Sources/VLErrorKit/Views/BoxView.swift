import VLstackNamespace
import VLSFSymbolKit
import SwiftUI

extension VLstack.DataError
{
 /// A SwiftUI view representing a styled error box with an optional content view.
 /// - Parameters:
 ///   - context: The error context to display (symbol, title, description).
 ///   - alignment: Text alignment for the content. Default is `.center`.
 ///   - content: Optional additional content displayed below the error title.
 public struct BoxView<CONTEXTTYPE: VLstack.DataError.ContextType, CONTENT: View>: View
 {
  @Environment(\.contextErrorBoxStyle) private var style

  private let context: VLstack.DataError.Context<CONTEXTTYPE>
  private let alignment: TextAlignment
  private let content: () -> CONTENT

  /// Creates a BoxView with a given error context and optional content.
  public init(_ context: VLstack.DataError.Context<CONTEXTTYPE>,
              alignment: TextAlignment = .center,
              @ViewBuilder content: @escaping () -> CONTENT)
  {
   self.context = context
   self.alignment = alignment
   self.content = content
  }

  /// Creates a BoxView from a type, title, and underlying error with optional content.
  public init(_ type: CONTEXTTYPE,
              _ title: String,
              error: any Error,
              alignment: TextAlignment = .center,
              @ViewBuilder content: @escaping () -> CONTENT)
  {
   self.init(VLstack.DataError.Context<CONTEXTTYPE>(type, title, error: error),
             alignment: alignment,
             content: content)
  }

  public var body: some View
  {
   VStack
   {
    Image(context.sfSymbol)
     .symbolVariant(context.symbolVariant)
     .font(.system(size: 64, weight: .bold))
     .foregroundStyle(style.symbolForeground)
     .padding(.vertical, 24)
     .frame(maxWidth: .infinity, alignment: .center)
     .background(style.symbolBackground)

    Text(context.title)
     .multilineTextAlignment(.center)
     .font(style.titleFont)
     .foregroundStyle(style.titleForeground)
     .textCase(nil)
     .underline()
     .frame(maxWidth: .infinity, alignment: .center)
     .padding()

    content()
   }
   .background(style.background)
   .clipShape(.rect(cornerRadius: style.strokeRadius))
   .overlay
   {
    RoundedRectangle(cornerRadius: style.strokeRadius)
     .stroke(style.strokeColor, lineWidth: 1)
   }
   .contentShape(.rect(cornerRadius: style.strokeRadius))
   .padding()
  }
 }
}
