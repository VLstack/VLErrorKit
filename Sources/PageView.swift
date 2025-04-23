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
  private let description: [ VLstack.DataError.Description ]
  private let descriptionAlignment: Alignment

  public init(_ context: VLstack.DataError.Context<CONTEXTTYPE>,
              alignment: TextAlignment = .center)
  {
   self.context = context
   self.alignment = alignment

   if let description = context.description
   {
    self.description = description.split(separator: "\n", omittingEmptySubsequences: false)
                                  .map { VLstack.DataError.Description(value: String($0)) }
   }
   else
   {
    self.description = []
   }

   switch alignment
   {
    case .leading: self.descriptionAlignment = .leading
    case .center: self.descriptionAlignment = .center
    case .trailing: self.descriptionAlignment = .trailing
   }
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
   {
    if !description.isEmpty
    {
     VStack(spacing: 4)
     {
      ForEach(description, id: \.self)
      {
       Text($0.value)
        .multilineTextAlignment(alignment)
        .frame(maxWidth: .infinity, alignment: descriptionAlignment)
      }
     }
     .font(style.descriptionFont)
     .foregroundStyle(style.descriptionForeground)
     .frame(minHeight: 200, alignment: .topLeading)
     .padding(.horizontal)
     .padding(.bottom)
     .scrollIndicators(.hidden)
    }
   }
   .frame(maxHeight: .infinity, alignment: .center)
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
