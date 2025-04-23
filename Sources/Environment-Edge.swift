import VLstackNamespace
import VLColorKit
import SwiftUI

extension VLstack.DataError
{
 internal struct EdgeBackgroundKey: EnvironmentKey     { static let defaultValue: Color = Color(uiColor: .secondarySystemBackground) }
 internal struct EdgeDismissEnabledKey: EnvironmentKey { static let defaultValue: Bool = true }
}

extension EnvironmentValues
{
 internal var contextErrorEdgeBackground: Color
 {
  get { self[VLstack.DataError.EdgeBackgroundKey.self] }
  set { self[VLstack.DataError.EdgeBackgroundKey.self] = newValue }
 }

 internal var contextErrorEdgeDismissEnabled: Bool
 {
  get { self[VLstack.DataError.EdgeDismissEnabledKey.self] }
  set { self[VLstack.DataError.EdgeDismissEnabledKey.self] = newValue }
 }
}

extension View
{
 public func contextError(edgeBackground color: Color) -> some View { self.environment(\.contextErrorEdgeBackground, color) }
 public func contextError(edgeDismissEnabled state: Bool) -> some View { self.environment(\.contextErrorEdgeDismissEnabled, state) }
}
