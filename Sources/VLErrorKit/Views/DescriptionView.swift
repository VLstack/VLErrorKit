import VLstackNamespace
import SwiftUI

extension VLstack.DataError
{
 /// A SwiftUI view displaying the description lines of an error context within a BoxView.
 /// - Parameters:
 ///   - context: The error context containing the description.
 ///   - alignment: Text alignment for the description. Default is `.center`.
 public struct DescriptionView<CONTEXTTYPE: VLstack.DataError.ContextType>: View
 {
  @Environment(\.contextErrorDescriptionStyle) private var style

  private let context: VLstack.DataError.Context<CONTEXTTYPE>
  private let alignment: TextAlignment
  private let description: [ VLstack.DataError.Description ]
  private let descriptionAlignment: Alignment

  /// Creates a DescriptionView with a given error context.
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

  /// Creates a DescriptionView from a type, title, and underlying error.
  public init(_ type: CONTEXTTYPE,
              _ title: String,
              error: any Error,
              alignment: TextAlignment = .center)
  {
   self.init(VLstack.DataError.Context<CONTEXTTYPE>(type, title, error: error),
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
  }
 }
}
