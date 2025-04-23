import SwiftUI
import VLstackNamespace

extension VLstack.DataError
{
 public struct InlineView<CONTEXTTYPE: VLstack.DataError.ContextType>: View
 {
  @Environment(\.contextErrorInlineFont) private var font
  @Environment(\.contextErrorInlineSymbolForeground) private var foreground
  @Environment(\.contextErrorInlineDescriptionFont) private var descriptionFont


  private let context: VLstack.DataError.Context<CONTEXTTYPE>?
  private let type: CONTEXTTYPE?
  private let strict: Bool

  public init(_ context: VLstack.DataError.Context<CONTEXTTYPE>?,
              type: CONTEXTTYPE? = nil,
              strict: Bool = false)
  {
   self.context = context
   self.type = type
   self.strict = strict
  }

  public var body: some View
  {
   if let context,
      context.isEqual(type, strict: strict)
   {
    HStack(alignment: .firstTextBaseline)
    {
     Image(context.sfSymbol)
      .font(font)
      .foregroundStyle(foreground)

     VStack(alignment: .leading)
     {
      Text(context.message)
       .font(font)

      if let description = context.description
      {
       Text(description)
        .font(descriptionFont)
      }
     }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(.vertical, 4)
   }
  }
 }
}
