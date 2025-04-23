import VLstackNamespace
import VLColorKit
import SwiftUI

extension VLstack.DataError
{
 public struct InlineStyle: Sendable
 {
  let font: Font
  let symbolForeground: Color
  let descriptionFont: Font

  init(font: Font = .body,
       symbolForeground: Color = Color(hex: "DC625E"),
       descriptionFont: Font = .callout)
  {
   self.font = font
   self.symbolForeground = symbolForeground
   self.descriptionFont = descriptionFont
  }
 }

 public struct PageStyle: Sendable
 {
  let background: Color
  let descriptionFont: Font
  let descriptionForeground: Color

  init(background: Color = Color(uiColor: .secondarySystemBackground),
       descriptionFont: Font = .body,
       descriptionForeground: Color = Color(uiColor: .label))
  {
   self.background = background
   self.descriptionFont = descriptionFont
   self.descriptionForeground = descriptionForeground
  }
 }

 public struct BoxStyle: Sendable
 {
  let background: Color
  let titleFont: Font
  let titleForeground: Color
  let symbolForeground: Color
  let symbolBackground: Color
  let strokeRadius: CGFloat
  let strokeColor: Color

  init(background: Color = Color(uiColor: .systemBackground),
       titleFont: Font = .title2,
       titleForeground: Color = Color(hex: "DC625E"),
       symbolForeground: Color = Color(hex: "FFFFFF"),
       symbolBackground: Color = Color(hex: "DC625E"),
       strokeRadius: CGFloat = 10,
       strokeColor: Color = Color(hex: "DC625E"))
  {
   self.background = background
   self.titleFont = titleFont
   self.titleForeground = titleForeground
   self.symbolForeground = symbolForeground
   self.symbolBackground = symbolBackground
   self.strokeRadius = strokeRadius
   self.strokeColor = strokeColor
  }
 }
}
