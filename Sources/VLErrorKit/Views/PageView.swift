import SwiftUI

extension VLDataError
{
 /// A full-screen SwiftUI view displaying an error context, with optional actions at the bottom of the error box.
 /// Composes DescriptionView; the dismiss button is handled by BoxView (see `.error(dismissEnabled:)`).
 /// The actions are displayed as provided: the caller is responsible for their padding.
 public struct PageView<CONTEXTTYPE: VLDataError.ContextType, ACTIONS: View>: View
 {
  @Environment(\.contextErrorPageStyle) private var style

  private let context: VLDataError.Context<CONTEXTTYPE>
  private let alignment: TextAlignment
  private let actions: () -> ACTIONS

  /// Creates a PageView for a given error context, with actions displayed at the bottom of the error box.
  /// - Parameters:
  ///   - context: The error context to display.
  ///   - alignment: Text alignment for the description. Default is `.leading`.
  ///   - actions: Views displayed at the bottom of the error box (buttons, links).
  public init(_ context: VLDataError.Context<CONTEXTTYPE>,
              alignment: TextAlignment = .leading,
              @ViewBuilder actions: @escaping () -> ACTIONS)
  {
   self.context = context
   self.alignment = alignment
   self.actions = actions
  }

  /// Creates a PageView from a type, title, and underlying error, with actions displayed at the bottom of the error box.
  /// - Parameters:
  ///   - type: The type of the error context.
  ///   - title: The title of the error.
  ///   - error: The underlying error.
  ///   - alignment: Text alignment for the description. Default is `.center`.
  ///   - actions: Views displayed at the bottom of the error box (buttons, links).
  public init(_ type: CONTEXTTYPE,
              _ title: String,
              error: any Error,
              alignment: TextAlignment = .center,
              @ViewBuilder actions: @escaping () -> ACTIONS)
  {
   self.init(VLDataError.Context<CONTEXTTYPE>(type, title, error: error),
             alignment: alignment,
             actions: actions)
  }

  public var body: some View
  {
   VLDataError.DescriptionView(context,
                               alignment: alignment,
                               actions: actions)
   .background(style.background)
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
  .environment(\.contextErrorDismissEnabled, true)
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
 .error(dismissEnabled: false)
}
#endif
