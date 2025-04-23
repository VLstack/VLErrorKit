import VLstackNamespace
import SwiftUI

extension VLstack.DataError
{
 public struct PageView<CONTEXTTYPE: VLstack.DataError.ContextType>: View
 {
  @Environment(\.contextErrorPageSymbolForeground) private var symbolForeground
  @Environment(\.contextErrorPageSymbolBackground) private var symbolBackground
  @Environment(\.contextErrorPageContentBackground) private var contentBackground
  @Environment(\.contextErrorPageStrokeRadius) private var strokeRadius
  @Environment(\.contextErrorPageStroke) private var stroke
  @Environment(\.contextErrorPageBackground) private var pageBackground
  @Environment(\.contextErrorPageMessageFont) private var messageFont
  @Environment(\.contextErrorPageMessageForeground) private var messageForeground
  @Environment(\.contextErrorPageDescriptionFont) private var descriptionFont
  @Environment(\.contextErrorPageDescriptionForeground) private var descriptionForeground

  private let context: VLstack.DataError.Context<CONTEXTTYPE>
  private let alignment: TextAlignment
  private var description: [ VLstack.DataError.Description ] = []
  private let descriptionAlignment: Alignment

  public init(_ context: VLstack.DataError.Context<CONTEXTTYPE>,
              alignment: TextAlignment = .center)
  {
   self.context = context
   self.alignment = alignment

   if let description = context.description
   {
    self.description = description.split(separator: "\n", omittingEmptySubsequences: false)
                                  .map { VLstack.DataError.Description(value: String($0)) }
   }

   switch alignment
   {
    case .leading: self.descriptionAlignment = .leading
    case .center: self.descriptionAlignment = .center
    case .trailing: self.descriptionAlignment = .trailing
   }
  }

  public init(_ type: CONTEXTTYPE,
              _ message: String,
              error: Error,
              alignment: TextAlignment = .center)
  {
   self.init(VLstack.DataError.Context(type, message, error: error),
             alignment: alignment)
  }

  public var body: some View
  {
   VStack
   {
    Image(context.sfSymbol)
     .font(.system(size: 64, weight: .bold))
     .foregroundStyle(symbolForeground)
     .padding(.vertical, 24)
     .frame(maxWidth: .infinity, alignment: .center)
     .background(symbolBackground)

    Text(context.message)
     .multilineTextAlignment(.center)
     .font(messageFont)
     .foregroundStyle(messageForeground)
     .textCase(nil)
     .underline()
     .frame(maxWidth: .infinity, alignment: .center)
     .padding()

    if !description.isEmpty
    {
     VStack(spacing: 4)
     {
      ForEach(description, id: \.self)
      {
       Text($0.value)
        .multilineTextAlignment(alignment)
        .frame(maxWidth: .infinity, alignment: descriptionAlignment)
      }
     }
     .font(descriptionFont)
     .foregroundStyle(descriptionForeground)
     .frame(minHeight: 200, alignment: .topLeading)
     .padding(.horizontal)
     .padding(.bottom)
     .scrollIndicators(.hidden)
    }
   }
   .background(contentBackground)
   .clipShape(.rect(cornerRadius: strokeRadius))
   .overlay
   {
    RoundedRectangle(cornerRadius: strokeRadius)
     .stroke(stroke, lineWidth: 1)
   }
   .contentShape(.rect(cornerRadius: strokeRadius))
   .padding()
   .frame(maxHeight: .infinity, alignment: .center)
   .background(pageBackground)
   .ignoresSafeArea(.all)
  }
 }
}
