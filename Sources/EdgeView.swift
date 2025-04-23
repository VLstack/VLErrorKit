import VLstackNamespace
import VLSFSymbolKit
import SwiftUI

extension VLstack.DataError
{
 public struct EdgeView<CONTEXTTYPE: VLstack.DataError.ContextType>: View
 {
  @Environment(\.contextErrorEdgeBackground) private var background
  @Environment(\.contextErrorEdgeDismissEnabled) private var dismissEnabled
  @Environment(\.dismiss) private var dismiss

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
   VLstack.DataError.BoxView(context,
                             alignment: alignment)
   .frame(maxHeight: .infinity, alignment: .center)
   .background(background)
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
