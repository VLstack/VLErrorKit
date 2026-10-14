import VLColorKit
import SwiftUI

extension VLDataError
{
 @usableFromInline
 internal struct BoxStyleKey: EnvironmentKey
 {
  @usableFromInline
  static let defaultValue: VLDataError.BoxStyle = .init()
 }

 @usableFromInline
 internal struct DescriptionStyleKey: EnvironmentKey
 {
  @usableFromInline
  static let defaultValue: VLDataError.DescriptionStyle = .init()
 }

 @usableFromInline
 internal struct DismissEnabledKey: EnvironmentKey
 {
  @usableFromInline
  static let defaultValue: Bool = true
 }

 @usableFromInline
 internal struct InlineStyleKey: EnvironmentKey
 {
  @usableFromInline
  static let defaultValue: VLDataError.InlineStyle = .init()
 }

 @usableFromInline
 internal struct PageStyleKey: EnvironmentKey
 {
  @usableFromInline
  static let defaultValue: VLDataError.PageStyle = .init()
 }
}

extension EnvironmentValues
{
 @usableFromInline
 internal var contextErrorBoxStyle: VLDataError.BoxStyle
 {
  get { self[VLDataError.BoxStyleKey.self] }
  set { self[VLDataError.BoxStyleKey.self] = newValue }
 }

 @usableFromInline
 internal var contextErrorDescriptionStyle: VLDataError.DescriptionStyle
 {
  get { self[VLDataError.DescriptionStyleKey.self] }
  set { self[VLDataError.DescriptionStyleKey.self] = newValue }
 }

 @usableFromInline
 internal var contextErrorDismissEnabled: Bool
 {
  get { self[VLDataError.DismissEnabledKey.self] }
  set { self[VLDataError.DismissEnabledKey.self] = newValue }
 }

 @usableFromInline
 internal var contextErrorInlineStyle: VLDataError.InlineStyle
 {
  get { self[VLDataError.InlineStyleKey.self] }
  set { self[VLDataError.InlineStyleKey.self] = newValue }
 }

 @usableFromInline
 internal var contextErrorPageStyle: VLDataError.PageStyle
 {
  get { self[VLDataError.PageStyleKey.self] }
  set { self[VLDataError.PageStyleKey.self] = newValue }
 }
}

extension View
{
 /// Apply a custom box style to the error view in this view hierarchy.
 @inlinable
 public func error(boxStyle style: VLDataError.BoxStyle) -> some View
 {
  self.environment(\.contextErrorBoxStyle, style)
 }

 /// Apply a custom description style to the error view in this view hierarchy.
 @inlinable
 public func error(descriptionStyle style: VLDataError.DescriptionStyle) -> some View
 {
  self.environment(\.contextErrorDescriptionStyle, style)
 }

 /// Enable or disable the dismiss button on the error view.
 @inlinable
 public func error(dismissEnabled state: Bool) -> some View
 {
  self.environment(\.contextErrorDismissEnabled, state)
 }

 /// Apply a custom inline style to the error view in this view hierarchy.
 @inlinable
 public func error(inlineStyle style: VLDataError.InlineStyle) -> some View
 {
  self.environment(\.contextErrorInlineStyle, style)
 }

 /// Apply a custom page style to the error view in this view hierarchy.
 @inlinable
 public func error(pageStyle style: VLDataError.PageStyle) -> some View
 {
  self.environment(\.contextErrorPageStyle, style)
 }
}
