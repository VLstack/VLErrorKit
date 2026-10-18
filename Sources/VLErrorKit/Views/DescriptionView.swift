import SwiftUI

extension VLDataError
{
 /// A SwiftUI view displaying the description lines of an error context within a BoxView.
 /// - Parameters:
 ///   - context: The error context containing the description.
 ///   - alignment: Text alignment for the description. Default is `.center`.
 ///   - actions: Views displayed at the bottom of the BoxView.
 internal struct DescriptionView<CONTEXTTYPE: VLDataError.ContextType, ACTIONS: View>: View
 {
  @Environment(\.contextErrorDescriptionStyle) private var style

  private let context: VLDataError.Context<CONTEXTTYPE>
  private let alignment: TextAlignment
  private var description: [ String ]
  private let descriptionAlignment: Alignment
  private let actions: () -> ACTIONS

  /// Creates a DescriptionView with a given error context and actions.
  internal init(_ context: VLDataError.Context<CONTEXTTYPE>,
                alignment: TextAlignment = .center,
                @ViewBuilder actions: @escaping () -> ACTIONS)
  {
   self.context = context
   self.alignment = alignment
   self.actions = actions

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

  /// Creates a DescriptionView from a type, title, and underlying error, with actions.
  internal init(_ type: CONTEXTTYPE,
                _ title: String,
                error: any Error,
                alignment: TextAlignment = .center,
                @ViewBuilder actions: @escaping () -> ACTIONS)
  {
   self.init(VLDataError.Context<CONTEXTTYPE>(type, title, error: error),
             alignment: alignment,
             actions: actions)
  }

  internal var body: some View
  {
   VLDataError.BoxView(context,
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
   actions:
   {
    actions()
   }
   .frame(maxHeight: .infinity, alignment: .center)
  }
 }
}
