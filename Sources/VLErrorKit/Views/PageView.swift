import SwiftUI

extension VLDataError
{
 /// A full-screen SwiftUI view displaying an error context, with optional actions.
 /// The appearance comes from the page style (`.errorPageStyle(_:)`, `.default` if none);
 /// the dismiss button is shown only with `.error(dismissEnabled: true)`.
 /// The actions are displayed as provided: the caller is responsible for their padding.
 public struct PageView<CONTEXTTYPE: VLDataError.ContextType, ACTIONS: View>: View
 {
  @Environment(\.errorPageStyle) private var style
  @Environment(\.contextErrorDismissEnabled) private var dismissEnabled

  private let context: VLDataError.Context<CONTEXTTYPE>
  private let alignment: TextAlignment
  private let description: [ String ]
  private let descriptionAlignment: Alignment
  private let actions: ACTIONS

  /// Creates a PageView for a given error context, with actions displayed at the bottom of the page.
  /// - Parameters:
  ///   - context: The error context to display.
  ///   - alignment: Text alignment for the description. Default is `.leading`.
  ///   - actions: Views displayed at the bottom of the page (buttons, links).
  public init(_ context: VLDataError.Context<CONTEXTTYPE>,
              alignment: TextAlignment = .leading,
              @ViewBuilder actions: () -> ACTIONS)
  {
   self.context = context
   self.alignment = alignment
   self.description = context.descriptionLines
   self.actions = actions()

   switch alignment
   {
    case .leading: self.descriptionAlignment = .leading
    case .center: self.descriptionAlignment = .center
    case .trailing: self.descriptionAlignment = .trailing
   }
  }

  /// Creates a PageView from a type, title, and underlying error, with actions displayed at the bottom of the page.
  /// - Parameters:
  ///   - type: The type of the error context.
  ///   - title: The title of the error.
  ///   - error: The underlying error.
  ///   - alignment: Text alignment for the description. Default is `.center`.
  ///   - actions: Views displayed at the bottom of the page (buttons, links).
  public init(_ type: CONTEXTTYPE,
              _ title: String,
              error: any Error,
              alignment: TextAlignment = .center,
              @ViewBuilder actions: () -> ACTIONS)
  {
   self.init(VLDataError.Context<CONTEXTTYPE>(type, title, error: error),
             alignment: alignment,
             actions: actions)
  }

  public var body: some View
  {
   (style ?? VLDataError.AnyPageStyle(VLDataError.DefaultPageStyle()))
    .makeBody(configuration: configuration)
  }

  private var configuration: VLDataError.PageStyleConfiguration
  {
   VLDataError.PageStyleConfiguration(symbol: .init(Image(systemName: context.systemImage)
                                                     .symbolVariant(context.symbolVariant)
                                                     .accessibilityHidden(true)),
                                      title: .init(Text(context.title)),
                                      description: description.isEmpty ? nil : VLDataError.StyleContent(descriptionView),
                                      actions: .init(actions),
                                      dismissButton: dismissEnabled ? VLDataError.DismissButton() : nil,
                                      alignment: alignment)
  }

  private var descriptionView: some View
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
  }
 }
}

extension VLDataError.PageView where ACTIONS == EmptyView
{
 /// Creates a PageView for a given error context, without actions.
 /// - Parameters:
 ///   - context: The error context to display.
 ///   - alignment: Text alignment for the description. Default is `.leading`.
 public init(_ context: VLDataError.Context<CONTEXTTYPE>,
             alignment: TextAlignment = .leading)
 {
  self.init(context,
            alignment: alignment,
            actions: { EmptyView() })
 }

 /// Creates a PageView from a type, title, and underlying error, without actions.
 /// - Parameters:
 ///   - type: The type of the error context.
 ///   - title: The title of the error.
 ///   - error: The underlying error.
 ///   - alignment: Text alignment for the description. Default is `.center`.
 public init(_ type: CONTEXTTYPE,
             _ title: String,
             error: any Error,
             alignment: TextAlignment = .center)
 {
  self.init(VLDataError.Context<CONTEXTTYPE>(type, title, error: error),
            alignment: alignment,
            actions: { EmptyView() })
 }
}

#if DEBUG
typealias PreviewPageContextError = VLDataError.Context<PreviewPageContextErrorType>

enum PreviewPageContextErrorType: VLDataError.ContextType
{
 case fatal
 case importLog
 case exportLog
 case exportEntry
}

private var previewPageDummyError: PreviewPageContextError
{
 PreviewPageContextError(.fatal,
                         "Fatal error",
                         description: "We are experiencing a technical problem that prevents the application from starting due to an issue with our data management system.\nPlease try the following actions:\n\n1. Check if an update for the application is available.\n2. Make sure you have enough storage space on your device.",
                         error: URLError(.badURL))
}

#Preview("Without actions")
{
 VLDataError.PageView(previewPageDummyError)
  .error(dismissEnabled: true)
}

#Preview("With actions")
{
 VLDataError.PageView(previewPageDummyError)
 {
  VStack(spacing: 12)
  {
   Button("Retry") {}
    .buttonStyle(.borderedProminent)

   Button("Report a bug") {}
  }
  .padding([ .horizontal, .bottom ])
 }
}
#endif
