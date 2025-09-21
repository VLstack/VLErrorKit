import VLstackNamespace
import VLColorKit
import SwiftUI

extension VLstack.DataError
{
 internal struct InlineStyleKey: EnvironmentKey
 {
  static let defaultValue: VLstack.DataError.InlineStyle = .init()
 }

 internal struct BoxStyleKey: EnvironmentKey
 {
  static let defaultValue: VLstack.DataError.BoxStyle = .init()
 }

 internal struct DescriptionStyleKey: EnvironmentKey
 {
  static let defaultValue: VLstack.DataError.DescriptionStyle = .init()
 }

 internal struct PageStyleKey: EnvironmentKey
 {
  static let defaultValue: VLstack.DataError.PageStyle = .init()
 }

 internal struct DismissEnabledKey: EnvironmentKey
 {
  static let defaultValue: Bool = true
 }
}

extension EnvironmentValues
{
 internal var contextErrorInlineStyle: VLstack.DataError.InlineStyle
 {
  get { self[VLstack.DataError.InlineStyleKey.self] }
  set { self[VLstack.DataError.InlineStyleKey.self] = newValue }
 }

 internal var contextErrorBoxStyle: VLstack.DataError.BoxStyle
 {
  get { self[VLstack.DataError.BoxStyleKey.self] }
  set { self[VLstack.DataError.BoxStyleKey.self] = newValue }
 }

 internal var contextErrorDescriptionStyle: VLstack.DataError.DescriptionStyle
 {
  get { self[VLstack.DataError.DescriptionStyleKey.self] }
  set { self[VLstack.DataError.DescriptionStyleKey.self] = newValue }
 }

 internal var contextErrorPageStyle: VLstack.DataError.PageStyle
 {
  get { self[VLstack.DataError.PageStyleKey.self] }
  set { self[VLstack.DataError.PageStyleKey.self] = newValue }
 }

 internal var contextErrorDismissEnabled: Bool
 {
  get { self[VLstack.DataError.DismissEnabledKey.self] }
  set { self[VLstack.DataError.DismissEnabledKey.self] = newValue }
 }
}

extension View
{
 /// Apply a custom box style to the error view in this view hierarchy.
 public func error(boxStyle style: VLstack.DataError.BoxStyle) -> some View
 {
  self.environment(\.contextErrorBoxStyle, style)
 }

 /// Apply a custom description style to the error view in this view hierarchy.
 public func error(descriptionStyle style: VLstack.DataError.DescriptionStyle) -> some View
 {
  self.environment(\.contextErrorDescriptionStyle, style)
 }

 /// Enable or disable the dismiss button on the error view.
 public func error(dismissEnabled state: Bool) -> some View
 {
  self.environment(\.contextErrorDismissEnabled, state)
 }

 /// Apply a custom inline style to the error view in this view hierarchy.
 public func error(inlineStyle style: VLstack.DataError.InlineStyle) -> some View
 {
  self.environment(\.contextErrorInlineStyle, style)
 }

 /// Apply a custom page style to the error view in this view hierarchy.
 public func error(pageStyle style: VLstack.DataError.PageStyle) -> some View
 {
  self.environment(\.contextErrorPageStyle, style)
 }
}
