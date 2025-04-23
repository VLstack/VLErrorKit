import VLstackNamespace
import VLColorKit
import SwiftUI

extension VLstack.DataError
{
 internal struct PageBackgroundKey: EnvironmentKey            { static let defaultValue: Color = Color(uiColor: .secondarySystemBackground) }
 internal struct PageContentBackgroundKey: EnvironmentKey     { static let defaultValue: Color = Color(uiColor: .systemBackground) }
 internal struct PageSymbolForegroundKey: EnvironmentKey      { static let defaultValue: Color = Color(hex: "FFFFFF") }
 internal struct PageSymbolBackgroundKey: EnvironmentKey      { static let defaultValue: Color = Color(hex: "DC625E") }
 internal struct PageStrokeRadiusKey: EnvironmentKey          { static let defaultValue: CGFloat = 10 }
 internal struct PageStrokeKey: EnvironmentKey                { static let defaultValue: Color = Color(hex: "DC625E") }
 internal struct PageMessageFontKey: EnvironmentKey           { static let defaultValue: Font = .title2 }
 internal struct PageMessageForegroundKey: EnvironmentKey     { static let defaultValue: Color = Color(hex: "DC625E") }
 internal struct PageDescriptionFontKey: EnvironmentKey       { static let defaultValue: Font = .body }
 internal struct PageDescriptionForegroundKey: EnvironmentKey { static let defaultValue: Color = Color(uiColor: .label) }
}

extension EnvironmentValues
{
 internal var contextErrorPageBackground: Color
 {
  get { self[VLstack.DataError.PageBackgroundKey.self] }
  set { self[VLstack.DataError.PageBackgroundKey.self] = newValue }
 }

 internal var contextErrorPageContentBackground: Color
 {
  get { self[VLstack.DataError.PageContentBackgroundKey.self] }
  set { self[VLstack.DataError.PageContentBackgroundKey.self] = newValue }
 }

 internal var contextErrorPageSymbolForeground: Color
 {
  get { self[VLstack.DataError.PageSymbolForegroundKey.self] }
  set { self[VLstack.DataError.PageSymbolForegroundKey.self] = newValue }
 }

 internal var contextErrorPageSymbolBackground: Color
 {
  get { self[VLstack.DataError.PageSymbolBackgroundKey.self] }
  set { self[VLstack.DataError.PageSymbolBackgroundKey.self] = newValue }
 }

 internal var contextErrorPageStrokeRadius: CGFloat
 {
  get { self[VLstack.DataError.PageStrokeRadiusKey.self] }
  set { self[VLstack.DataError.PageStrokeRadiusKey.self] = newValue }
 }

 internal var contextErrorPageStroke: Color
 {
  get { self[VLstack.DataError.PageStrokeKey.self] }
  set { self[VLstack.DataError.PageStrokeKey.self] = newValue }
 }

 internal var contextErrorPageMessageFont: Font
 {
  get { self[VLstack.DataError.PageMessageFontKey.self] }
  set { self[VLstack.DataError.PageMessageFontKey.self] = newValue }
 }

 internal var contextErrorPageMessageForeground: Color
 {
  get { self[VLstack.DataError.PageMessageForegroundKey.self] }
  set { self[VLstack.DataError.PageMessageForegroundKey.self] = newValue }
 }

 internal var contextErrorPageDescriptionFont: Font
 {
  get { self[VLstack.DataError.PageDescriptionFontKey.self] }
  set { self[VLstack.DataError.PageDescriptionFontKey.self] = newValue }
 }

 internal var contextErrorPageDescriptionForeground: Color
 {
  get { self[VLstack.DataError.PageDescriptionForegroundKey.self] }
  set { self[VLstack.DataError.PageDescriptionForegroundKey.self] = newValue }
 }
}

extension View
{
 public func contextError(pageBackground color: Color) -> some View { self.environment(\.contextErrorPageBackground, color) }
 public func contextError(pageContentBackground color: Color) -> some View { self.environment(\.contextErrorPageContentBackground, color) }
 public func contextError(pageSymbolForeground color: Color) -> some View { self.environment(\.contextErrorPageSymbolForeground, color) }
 public func contextError(pageSymbolBackground color: Color) -> some View { self.environment(\.contextErrorPageSymbolBackground, color) }
 public func contextError(pageStrokeRadius radius: CGFloat) -> some View { self.environment(\.contextErrorPageStrokeRadius, radius) }
 public func contextError(pageStroke color: Color) -> some View { self.environment(\.contextErrorPageStroke, color) }
 public func contextError(pageMessageFont font: Font) -> some View { self.environment(\.contextErrorPageMessageFont, font) }
 public func contextError(pageMessageForeground color: Color) -> some View { self.environment(\.contextErrorPageMessageForeground, color) }
 public func contextError(pageDescriptionFont font: Font) -> some View { self.environment(\.contextErrorPageDescriptionFont, font) }
 public func contextError(pageDescriptionForeground color: Color) -> some View { self.environment(\.contextErrorPageDescriptionForeground, color) }
}
