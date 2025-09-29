import VLstackNamespace
import SwiftUI

extension VLstack.DataError
{
 /// A SwiftUI view displaying the description lines of an error context within a BoxView.
 /// - Parameters:
 ///   - context: The error context containing the description.
 ///   - alignment: Text alignment for the description. Default is `.center`.
 internal struct DescriptionView<CONTEXTTYPE: VLstack.DataError.ContextType>: View
 {
  @Environment(\.contextErrorDescriptionStyle) private var style

  private let context: VLstack.DataError.Context<CONTEXTTYPE>
  private let alignment: TextAlignment
  private var description: [ String ]
  private let descriptionAlignment: Alignment

  /// Creates a DescriptionView with a given error context.
  internal init(_ context: VLstack.DataError.Context<CONTEXTTYPE>,
                alignment: TextAlignment = .center)
  {
   self.context = context
   self.alignment = alignment

   self.description = context.description?.split(separator: "\n", omittingEmptySubsequences: false)
                                          .map { String($0) } ?? []

   if let errorDescription = context.error?.localizedDescription,
      self.description.last != errorDescription
   {
    self.description.append(contentsOf: [ "", "", errorDescription ])
   }

   switch alignment
   {
    case .leading: self.descriptionAlignment = .leading
    case .center: self.descriptionAlignment = .center
    case .trailing: self.descriptionAlignment = .trailing
   }
  }

  /// Creates a DescriptionView from a type, title, and underlying error.
  internal init(_ type: CONTEXTTYPE,
                _ title: String,
                error: any Error,
                alignment: TextAlignment = .center)
  {
   self.init(VLstack.DataError.Context<CONTEXTTYPE>(type, title, error: error),
             alignment: alignment)
  }

  internal var body: some View
  {
   VLstack.DataError.BoxView(context,
                             alignment: alignment)
   {
    if !description.isEmpty
    {
     VStack(spacing: 4)
     {
      ForEach(Array(description.enumerated()), id: \.0)
      {
       _, text in
       Text(text)
        .multilineTextAlignment(alignment)
        .frame(maxWidth: .infinity, alignment: descriptionAlignment)
      }
     }
     .font(style.descriptionFont)
     .foregroundStyle(style.descriptionForeground)
     .frame(minHeight: 200, alignment: .topLeading)
     .padding(.horizontal)
    }
   }
   .frame(maxHeight: .infinity, alignment: .center)
  }
 }
}
