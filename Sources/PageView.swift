import VLstackNamespace
import VLSFSymbolKit
import SwiftUI

extension VLstack.DataError
{
 public struct PageView<CONTEXTTYPE: VLstack.DataError.ContextType>: View
 {
  @Environment(\.dismiss) private var dismiss
  @Environment(\.contextErrorPageStyle) private var style
  @Environment(\.contextErrorDismissEnabled) private var dismissEnabled

  private let context: VLstack.DataError.Context<CONTEXTTYPE>
  private let alignment: TextAlignment

  public init(_ context: VLstack.DataError.Context<CONTEXTTYPE>,
              alignment: TextAlignment = .center)
  {
   self.context = context
   self.alignment = alignment
  }

  public init(_ type: CONTEXTTYPE,
              _ message: String,
              error: Error,
              alignment: TextAlignment = .center)
  {
   self.init(VLstack.DataError.Context(type, message, error: error),
             alignment: alignment)
  }

  public var body: some View
  {
   VLstack.DataError.DescriptionView(context,
                                     alignment: alignment)
   .background(style.background)
   .ignoresSafeArea(.all)
   .overlay(alignment: .topTrailing)
   {
    if dismissEnabled
    {
     Button(action: { dismiss() })
     {
      Image(.xmark)
       .font(.system(size: 16, weight: .bold))
       .foregroundColor(.white)
       .padding(5)
       .background(Color.black.opacity(0.6))
       .clipShape(.circle)
     }
     .buttonStyle(.plain)
     .padding()
    }
   }
  }
 }
}
