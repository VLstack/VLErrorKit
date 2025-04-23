import VLstackNamespace
import VLSFSymbolKit
import SwiftUI

extension VLstack.DataError
{
 public struct BoxView<CONTEXTTYPE: VLstack.DataError.ContextType, CONTENT: View>: View
 {
  @Environment(\.contextErrorBoxStyle) private var style

  private let context: VLstack.DataError.Context<CONTEXTTYPE>
  private let alignment: TextAlignment
  private let content: () -> CONTENT

  public init(_ context: VLstack.DataError.Context<CONTEXTTYPE>,
              alignment: TextAlignment = .center,
              @ViewBuilder content: @escaping () -> CONTENT)
  {
   self.context = context
   self.alignment = alignment
   self.content = content
  }

  public var body: some View
  {
   VStack
   {
    Image(context.sfSymbol)
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
