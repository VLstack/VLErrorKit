import SwiftUI
import UIKit

extension VLDataError
{
 /// Dismiss button of an error page, given ready to use to the page style:
 /// it dismisses the presentation, has a localized accessibility label and follows Dynamic Type
 public struct DismissButton: View
 {
  @Environment(\.dismiss) private var dismiss

  /// Size of the symbol, following Dynamic Type
  @ScaledMetric(relativeTo: .body) private var symbolSize: CGFloat = 16

  internal init() {}

  public var body: some View
  {
   if #available(iOS 26.0, *)
   {
    Button(action: { dismiss() })
    {
     Image(systemName: "xmark")
      .font(.system(size: symbolSize, weight: .bold))
      .padding(5)
    }
    .buttonBorderShape(.circle)
    .buttonStyle(.glass)
    .accessibilityLabel(VLDataError.localized("I18N-VLErrorKit.Close"))
    .padding()
   }
   else
   {
    Button(action: { dismiss() })
    {
     Image(systemName: "xmark")
      .font(.system(size: symbolSize, weight: .bold))
      .foregroundStyle(Color(.label))
      .padding(10)
      .background(Color(.systemBackground))
      .clipShape(.circle)
      .shadow(radius: 16)
    }
    .buttonStyle(.plain)
    .accessibilityLabel(VLDataError.localized("I18N-VLErrorKit.Close"))
    .padding()
   }
  }
 }
}
