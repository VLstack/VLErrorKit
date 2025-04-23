import VLstackNamespace
import VLColorKit
import SwiftUI

extension VLstack.DataError
{
 internal struct BoxContentBackgroundKey: EnvironmentKey     { static let defaultValue: Color = Color(uiColor: .systemBackground) }
 internal struct BoxSymbolForegroundKey: EnvironmentKey      { static let defaultValue: Color = Color(hex: "FFFFFF") }
 internal struct BoxSymbolBackgroundKey: EnvironmentKey      { static let defaultValue: Color = Color(hex: "DC625E") }
 internal struct BoxStrokeRadiusKey: EnvironmentKey          { static let defaultValue: CGFloat = 10 }
 internal struct BoxStrokeKey: EnvironmentKey                { static let defaultValue: Color = Color(hex: "DC625E") }
 internal struct BoxMessageFontKey: EnvironmentKey           { static let defaultValue: Font = .title2 }
 internal struct BoxMessageForegroundKey: EnvironmentKey     { static let defaultValue: Color = Color(hex: "DC625E") }
 internal struct BoxDescriptionFontKey: EnvironmentKey       { static let defaultValue: Font = .body }
 internal struct BoxDescriptionForegroundKey: EnvironmentKey { static let defaultValue: Color = Color(uiColor: .label) }
}

extension EnvironmentValues
{
 internal var contextErrorBoxContentBackground: Color
 {
  get { self[VLstack.DataError.BoxContentBackgroundKey.self] }
  set { self[VLstack.DataError.BoxContentBackgroundKey.self] = newValue }
 }

 internal var contextErrorBoxSymbolForeground: Color
 {
  get { self[VLstack.DataError.BoxSymbolForegroundKey.self] }
  set { self[VLstack.DataError.BoxSymbolForegroundKey.self] = newValue }
 }

 internal var contextErrorBoxSymbolBackground: Color
 {
  get { self[VLstack.DataError.BoxSymbolBackgroundKey.self] }
  set { self[VLstack.DataError.BoxSymbolBackgroundKey.self] = newValue }
 }

 internal var contextErrorBoxStrokeRadius: CGFloat
 {
  get { self[VLstack.DataError.BoxStrokeRadiusKey.self] }
  set { self[VLstack.DataError.BoxStrokeRadiusKey.self] = newValue }
 }

 internal var contextErrorBoxStroke: Color
 {
  get { self[VLstack.DataError.BoxStrokeKey.self] }
  set { self[VLstack.DataError.BoxStrokeKey.self] = newValue }
 }

 internal var contextErrorBoxMessageFont: Font
 {
  get { self[VLstack.DataError.BoxMessageFontKey.self] }
  set { self[VLstack.DataError.BoxMessageFontKey.self] = newValue }
 }

 internal var contextErrorBoxMessageForeground: Color
 {
  get { self[VLstack.DataError.BoxMessageForegroundKey.self] }
  set { self[VLstack.DataError.BoxMessageForegroundKey.self] = newValue }
 }

 internal var contextErrorBoxDescriptionFont: Font
 {
  get { self[VLstack.DataError.BoxDescriptionFontKey.self] }
  set { self[VLstack.DataError.BoxDescriptionFontKey.self] = newValue }
 }

 internal var contextErrorBoxDescriptionForeground: Color
 {
  get { self[VLstack.DataError.BoxDescriptionForegroundKey.self] }
  set { self[VLstack.DataError.BoxDescriptionForegroundKey.self] = newValue }
 }
}

extension View
{
 public func contextError(boxContentBackground color: Color) -> some View { self.environment(\.contextErrorBoxContentBackground, color) }
 public func contextError(boxSymbolForeground color: Color) -> some View { self.environment(\.contextErrorBoxSymbolForeground, color) }
 public func contextError(boxSymbolBackground color: Color) -> some View { self.environment(\.contextErrorBoxSymbolBackground, color) }
 public func contextError(boxStrokeRadius radius: CGFloat) -> some View { self.environment(\.contextErrorBoxStrokeRadius, radius) }
 public func contextError(boxStroke color: Color) -> some View { self.environment(\.contextErrorBoxStroke, color) }
 public func contextError(boxMessageFont font: Font) -> some View { self.environment(\.contextErrorBoxMessageFont, font) }
 public func contextError(boxMessageForeground color: Color) -> some View { self.environment(\.contextErrorBoxMessageForeground, color) }
 public func contextError(boxDescriptionFont font: Font) -> some View { self.environment(\.contextErrorBoxDescriptionFont, font) }
 public func contextError(boxDescriptionForeground color: Color) -> some View { self.environment(\.contextErrorBoxDescriptionForeground, color) }
}
