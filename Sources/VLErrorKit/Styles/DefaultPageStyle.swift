import SwiftUI
import UIKit

public extension VLDataError.PageStyle where Self == VLDataError.DefaultPageStyle
{
 /// Default error page: red banner with a white symbol and title, description in a bordered box
 static var `default`: Self { .init() }

 /// Default error page with custom fonts, colors and corner radius
 /// - Parameters:
 ///   - pageBackground: Background of the page, behind the box. Default is `secondarySystemBackground`.
 ///   - background: Background of the box. Default is `systemBackground`.
 ///   - bannerColor: Background of the banner holding the symbol and the title. Default is red `DC625E`.
 ///   - symbolColor: Color of the symbol. Default is white.
 ///   - titleFont: Font of the title, always bold. Default is `.title`.
 ///   - titleColor: Color of the title. Default is white.
 ///   - descriptionFont: Font of the description. Default is `.body`.
 ///   - descriptionColor: Color of the description. Default is `label`.
 ///   - strokeColor: Color of the box border. Default is red `DC625E`.
 ///   - cornerRadius: Corner radius of the box. Default is 10.
 static func `default`(pageBackground: Color = Color(.secondarySystemBackground),
                       background: Color = Color(.systemBackground),
                       bannerColor: Color = VLDataError.red,
                       symbolColor: Color = .white,
                       titleFont: Font = .title,
                       titleColor: Color = .white,
                       descriptionFont: Font = .body,
                       descriptionColor: Color = Color(.label),
                       strokeColor: Color = VLDataError.red,
                       cornerRadius: CGFloat = 10) -> Self
 {
  .init(pageBackground: pageBackground,
        background: background,
        bannerColor: bannerColor,
        symbolColor: symbolColor,
        titleFont: titleFont,
        titleColor: titleColor,
        descriptionFont: descriptionFont,
        descriptionColor: descriptionColor,
        strokeColor: strokeColor,
        cornerRadius: cornerRadius)
 }
}

extension VLDataError
{
 /// Default error red, `DC625E`, shared by the default page and inline styles
 @usableFromInline
 internal static let red = Color(red: 220 / 255, green: 98 / 255, blue: 94 / 255)

 /// Default page style, see `.default(...)` for its settings
 public struct DefaultPageStyle: VLDataError.PageStyle
 {
  private let pageBackground: Color
  private let background: Color
  private let bannerColor: Color
  private let symbolColor: Color
  private let titleFont: Font
  private let titleColor: Color
  private let descriptionFont: Font
  private let descriptionColor: Color
  private let strokeColor: Color
  private let cornerRadius: CGFloat

  public init(pageBackground: Color = Color(.secondarySystemBackground),
              background: Color = Color(.systemBackground),
              bannerColor: Color = VLDataError.red,
              symbolColor: Color = .white,
              titleFont: Font = .title,
              titleColor: Color = .white,
              descriptionFont: Font = .body,
              descriptionColor: Color = Color(.label),
              strokeColor: Color = VLDataError.red,
              cornerRadius: CGFloat = 10)
  {
   self.pageBackground = pageBackground
   self.background = background
   self.bannerColor = bannerColor
   self.symbolColor = symbolColor
   self.titleFont = titleFont
   self.titleColor = titleColor
   self.descriptionFont = descriptionFont
   self.descriptionColor = descriptionColor
   self.strokeColor = strokeColor
   self.cornerRadius = cornerRadius
  }

  public func makeBody(configuration: Configuration) -> some View
  {
   VLDataError.DefaultPageStyleView(configuration: configuration,
                                    pageBackground: pageBackground,
                                    background: background,
                                    bannerColor: bannerColor,
                                    symbolColor: symbolColor,
                                    titleFont: titleFont,
                                    titleColor: titleColor,
                                    descriptionFont: descriptionFont,
                                    descriptionColor: descriptionColor,
                                    strokeColor: strokeColor,
                                    cornerRadius: cornerRadius)
  }
 }

 /// Drawing of the default page style
 internal struct DefaultPageStyleView: View
 {
  @Environment(\.horizontalSizeClass) private var horizontalSizeClass

  let configuration: VLDataError.PageStyleConfiguration
  let pageBackground: Color
  let background: Color
  let bannerColor: Color
  let symbolColor: Color
  let titleFont: Font
  let titleColor: Color
  let descriptionFont: Font
  let descriptionColor: Color
  let strokeColor: Color
  let cornerRadius: CGFloat

  var body: some View
  {
   VStack
   {
    titleView
     .padding(.horizontal)
     .padding(.vertical, 10)
     .background(bannerColor)
     .overlay(alignment: .topTrailing) { configuration.dismissButton }

    ScrollView(.vertical)
    {
     if let description = configuration.description
     {
      description
       .font(descriptionFont)
       .foregroundStyle(descriptionColor)
       .frame(minHeight: 200, alignment: .topLeading)
       .padding(.horizontal)
     }
    }

    configuration.actions
   }
   .background(background)
   .clipShape(.rect(cornerRadius: cornerRadius))
   .overlay
   {
    RoundedRectangle(cornerRadius: cornerRadius)
     .stroke(strokeColor, lineWidth: 1)
   }
   .contentShape(.rect(cornerRadius: cornerRadius))
   .padding()
   .frame(maxHeight: .infinity, alignment: .center)
   .background(pageBackground)
  }

  @ViewBuilder
  private var titleView: some View
  {
   if horizontalSizeClass == .compact
   {
    ViewThatFits(in: .horizontal)
    {
     horizontalTitleView
     verticalTitleView
    }
   }
   else
   {
    horizontalTitleView
   }
  }

  private var horizontalTitleView: some View
  {
   HStack(alignment: .center, spacing: 10)
   {
    symbol
    title
   }
   .frame(maxWidth: .infinity, alignment: .leading)
  }

  private var verticalTitleView: some View
  {
   VStack(alignment: .center, spacing: 10)
   {
    symbol
    title
   }
   .frame(maxWidth: .infinity, alignment: .center)
  }

  /// Decorative symbol: fixed size, the title carries the meaning
  private var symbol: some View
  {
   configuration.symbol
    .font(.system(size: 64, weight: .bold))
    .foregroundStyle(symbolColor)
  }

  private var title: some View
  {
   configuration.title
    .multilineTextAlignment(.center)
    .font(titleFont)
    .foregroundStyle(titleColor)
    .fontWeight(.bold)
    .textCase(nil)
  }
 }
}
