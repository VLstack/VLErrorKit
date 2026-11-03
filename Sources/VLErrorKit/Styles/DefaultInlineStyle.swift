import SwiftUI

public extension VLDataError.InlineStyle where Self == VLDataError.DefaultInlineStyle
{
 /// Default inline error: red symbol, title, description below
 static var `default`: Self { .init() }

 /// Default inline error with custom fonts and symbol color
 /// - Parameters:
 ///   - font: Font of the symbol and the title. Default is `.body`.
 ///   - symbolColor: Color of the symbol. Default is red `DC625E`.
 ///   - descriptionFont: Font of the description. Default is `.callout`.
 static func `default`(font: Font = .body,
                       symbolColor: Color = VLDataError.red,
                       descriptionFont: Font = .callout) -> Self
 {
  .init(font: font,
        symbolColor: symbolColor,
        descriptionFont: descriptionFont)
 }
}

extension VLDataError
{
 /// Default inline style, see `.default(...)` for its settings
 public struct DefaultInlineStyle: VLDataError.InlineStyle
 {
  private let font: Font
  private let symbolColor: Color
  private let descriptionFont: Font

  public init(font: Font = .body,
              symbolColor: Color = VLDataError.red,
              descriptionFont: Font = .callout)
  {
   self.font = font
   self.symbolColor = symbolColor
   self.descriptionFont = descriptionFont
  }

  public func makeBody(configuration: Configuration) -> some View
  {
   HStack(alignment: .firstTextBaseline)
   {
    configuration.symbol
     .font(font)
     .foregroundStyle(symbolColor)

    VStack(alignment: .leading)
    {
     configuration.title
      .font(font)
      .multilineTextAlignment(.leading)

     configuration.description
      .font(descriptionFont)
      .multilineTextAlignment(.leading)
    }
   }
   .frame(maxWidth: .infinity, alignment: .leading)
  }
 }
}
