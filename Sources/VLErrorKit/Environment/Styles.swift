import VLstackNamespace
import VLColorKit
import SwiftUI

extension VLstack.DataError
{
 /// Represents the style of a boxed error view.
 /// - Parameters:
 ///   - background: Background color of the box. Default is `systemBackground`.
 ///   - titleFont: Font for the title. Default is `.title2`.
 ///   - titleForeground: Foreground color of the title. Default is red `DC625E`.
 ///   - symbolForeground: Foreground color of the symbol. Default is white `FFFFFF`.
 ///   - symbolBackground: Background color of the symbol. Default is red `DC625E`.
 ///   - strokeRadius: Corner radius for the box border. Default is 10.
 ///   - strokeColor: Color of the box border. Default is red `DC625E`.
 public struct BoxStyle: Sendable
 {
  @usableFromInline internal let background: Color
  @usableFromInline internal let titleFont: Font
  @usableFromInline internal let titleForeground: Color
  @usableFromInline internal let symbolForeground: Color
  @usableFromInline internal let symbolBackground: Color
  @usableFromInline internal let strokeRadius: CGFloat
  @usableFromInline internal let strokeColor: Color

  @inlinable
  public init(background: Color = Color(uiColor: .systemBackground),
              titleFont: Font = .title,
              titleForeground: Color = Color(hex: "FFFFFF"),
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

 /// Represents the style of the description text in an error view.
 /// - Parameters:
 ///   - descriptionFont: Font for the description. Default is `.body`.
 ///   - descriptionForeground: Foreground color for the description text. Default is `.label`.
 public struct DescriptionStyle: Sendable
 {
  @usableFromInline internal let descriptionFont: Font
  @usableFromInline internal let descriptionForeground: Color

  @inlinable
  public init(descriptionFont: Font = .body,
              descriptionForeground: Color = Color(uiColor: .label))
  {
   self.descriptionFont = descriptionFont
   self.descriptionForeground = descriptionForeground
  }
 }

 /// Represents the inline style for an error view.
 /// - Parameters:
 ///   - font: Font for the error title or main text. Default is `.body`.
 ///   - symbolForeground: Foreground color for the error symbol. Default is red `DC625E`.
 ///   - descriptionFont: Font used for the description text. Default is `.callout`.
 public struct InlineStyle: Sendable
 {
  @usableFromInline internal let font: Font
  @usableFromInline internal let symbolForeground: Color
  @usableFromInline internal let descriptionFont: Font

  @inlinable
  public init(font: Font = .body,
              symbolForeground: Color = Color(hex: "DC625E"),
              descriptionFont: Font = .callout)
  {
   self.font = font
   self.symbolForeground = symbolForeground
   self.descriptionFont = descriptionFont
  }
 }

 /// Represents the style of the error page background.
 /// - Parameters:
 ///   - background: Background color of the page. Default is `secondarySystemBackground`.
 public struct PageStyle: Sendable
 {
  @usableFromInline internal let background: Color

  @inlinable
  public init(background: Color = Color(uiColor: .secondarySystemBackground))
  {
   self.background = background
  }
 }
}
