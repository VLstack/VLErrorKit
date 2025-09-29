import SwiftUI
import VLstackNamespace

extension VLstack.DataError
{
 /// A compact SwiftUI view displaying an inline representation of an error context.
 /// Shows an SF Symbol, title, and optional description in a horizontal layout.
 public struct InlineView<CONTEXTTYPE: VLstack.DataError.ContextType>: View
 {
  @Environment(\.contextErrorInlineStyle) private var style

  private let context: VLstack.DataError.Context<CONTEXTTYPE>?
  private let target: CONTEXTTYPE?
  private let strict: Bool

  /// Creates an InlineView for a given optional error context.
  /// - Parameters:
  ///   - context: The optional error context to display.
  ///   - target: Optional target context type to match before showing.
  ///   - strict: Whether to enforce strict equality when comparing context to target.
  public init(_ context: VLstack.DataError.Context<CONTEXTTYPE>?,
              target: CONTEXTTYPE? = nil,
              strict: Bool = false)
  {
   self.context = context
   self.target = target
   self.strict = strict
  }

  public var body: some View
  {
   if let context,
      context.isEqual(target, strict: strict)
   {
    HStack(alignment: .firstTextBaseline)
    {
     Image(context.sfSymbol)
      .symbolVariant(context.symbolVariant)
      .font(style.font)
      .foregroundStyle(style.symbolForeground)

     VStack(alignment: .leading)
     {
      Text(context.title)
       .font(style.font)
       .multilineTextAlignment(.leading)

      if let description = context.description
      {
       Text(description)
        .font(style.descriptionFont)
        .multilineTextAlignment(.leading)
      }
     }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
   }
  }
 }
}

#if DEBUG
typealias PreviewInlineContextError = VLstack.DataError.Context<PreviewInlineContextErrorType>

enum PreviewInlineContextErrorType: VLstack.DataError.ContextType
{
 case fatal
 case importLog
 case exportLog
 case exportEntry
}

struct InlineView_Previews: PreviewProvider
{
 static let dummyErrorA = PreviewInlineContextError(.fatal,
                                                   "Fatal error",
                                                   description: "We are experiencing a technical issue.",
                                                   error: URLError(.badURL))
 static let dummyErrorB = PreviewInlineContextError(.importLog,
                                                   "import log error",
                                                   description: "import log failed")
 static let dummyErrorC = PreviewInlineContextError(.exportLog,
                                                   "export log error",
                                                   error: URLError(.badURL))
 static let dummyErrorD = PreviewInlineContextError(.exportEntry,
                                                    "title",
                                                    sfSymbol: .squareAndArrowUp)

 static var previews: some View
 {
  Form
  {
   Section
   {
    VLstack.DataError.InlineView(dummyErrorA)
     .error(inlineStyle: .init(font: .largeTitle,
                               symbolForeground: .green,
                               descriptionFont: .footnote))
    VLstack.DataError.InlineView(dummyErrorB)
    VLstack.DataError.InlineView(dummyErrorC)
    VLstack.DataError.InlineView(dummyErrorD)
   }
  }
//  .previewInterfaceOrientation(.landscapeLeft)
//  .preferredColorScheme(.dark)
 }
}
#endif
