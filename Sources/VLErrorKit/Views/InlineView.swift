import SwiftUI

extension VLDataError
{
 /// A compact SwiftUI view displaying an inline representation of an error context.
 /// The appearance comes from the inline style (`.errorInlineStyle(_:)`, `.default` if none).
 public struct InlineView<CONTEXTTYPE: VLDataError.ContextType>: View
 {
  @Environment(\.errorInlineStyle) private var style

  private let context: VLDataError.Context<CONTEXTTYPE>?
  private let target: CONTEXTTYPE?
  private let strict: Bool

  /// Creates an InlineView for a given optional error context.
  /// - Parameters:
  ///   - context: The optional error context to display.
  ///   - target: Optional target context type to match before showing.
  ///   - strict: Whether to enforce strict equality when comparing context to target.
  public init(_ context: VLDataError.Context<CONTEXTTYPE>?,
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
    (style ?? VLDataError.AnyInlineStyle(VLDataError.DefaultInlineStyle()))
     .makeBody(configuration: configuration(context))
   }
  }

  private func configuration(_ context: VLDataError.Context<CONTEXTTYPE>) -> VLDataError.InlineStyleConfiguration
  {
   VLDataError.InlineStyleConfiguration(symbol: .init(Image(systemName: context.systemImage)
                                                       .symbolVariant(context.symbolVariant)),
                                        title: .init(Text(context.title)),
                                        description: context.description.map { VLDataError.StyleContent(Text($0)) })
  }
 }
}

#if DEBUG
typealias PreviewInlineContextError = VLDataError.Context<PreviewInlineContextErrorType>

enum PreviewInlineContextErrorType: VLDataError.ContextType
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
                                                    systemImage: "square.and.arrow.up")

 static var previews: some View
 {
  Form
  {
   Section
   {
    VLDataError.InlineView(dummyErrorA)
     .errorInlineStyle(.default(font: .largeTitle,
                                symbolColor: .green,
                                descriptionFont: .footnote))
    VLDataError.InlineView(dummyErrorB)
    VLDataError.InlineView(dummyErrorC)
    VLDataError.InlineView(dummyErrorD)
   }
  }
 }
}
#endif
