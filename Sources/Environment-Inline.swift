import VLstackNamespace
import VLColorKit
import SwiftUI

extension VLstack.DataError
{
 internal struct InlineFontKey: EnvironmentKey             { static let defaultValue: Font = .body }
 internal struct InlineSymbolForegroundKey: EnvironmentKey { static let defaultValue: Color = Color(hex: "DC625E") }
 internal struct InlineDescriptionFontKey: EnvironmentKey  { static let defaultValue: Font = .callout }
}

extension EnvironmentValues
{
 internal var contextErrorInlineFont: Font
 {
  get { self[VLstack.DataError.InlineFontKey.self] }
  set { self[VLstack.DataError.InlineFontKey.self] = newValue }
 }

 internal var contextErrorInlineSymbolForeground: Color
 {
  get { self[VLstack.DataError.InlineSymbolForegroundKey.self] }
  set { self[VLstack.DataError.InlineSymbolForegroundKey.self] = newValue }
 }

 internal var contextErrorInlineDescriptionFont: Font
 {
  get { self[VLstack.DataError.InlineDescriptionFontKey.self] }
  set { self[VLstack.DataError.InlineDescriptionFontKey.self] = newValue }
 }
}

extension View
{
 public func contextError(inlineFont font: Font) -> some View { self.environment(\.contextErrorInlineFont, font) }
 public func contextError(inlineSymbolForeground color: Color) -> some View { self.environment(\.contextErrorInlineSymbolForeground, color) }
 public func contextError(inlineDescriptionFont font: Font) -> some View { self.environment(\.contextErrorInlineDescriptionFont, font) }
}
