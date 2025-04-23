import VLstackNamespace
import VLColorKit
import SwiftUI

extension VLstack.DataError
{
 internal struct StringsKey: EnvironmentKey
 {
  static let defaultValue: VLstack.DataError.Strings = .init(defaultAlertTitle: "Error",
                                                             defaultAlertMessage: "Unexepected issue")
 }
}

extension EnvironmentValues
{
 internal var contextErrorStrings: VLstack.DataError.Strings
 {
  get { self[VLstack.DataError.StringsKey.self] }
  set { self[VLstack.DataError.StringsKey.self] = newValue }
 }
}

extension View
{
 public func error(strings: VLstack.DataError.Strings) -> some View
 {
  self.environment(\.contextErrorStrings, strings)
 }
}
