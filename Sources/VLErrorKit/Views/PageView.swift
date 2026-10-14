import SwiftUI

extension VLDataError
{
 /// A full-screen SwiftUI view displaying an error context with optional dismissal.
 /// Composes DescriptionView and overlays a dismiss button if enabled.
 public struct PageView<CONTEXTTYPE: VLDataError.ContextType>: View
 {
//  @Environment(\.dismiss) private var dismiss
  @Environment(\.contextErrorPageStyle) private var style
//  @Environment(\.contextErrorDismissEnabled) private var dismissEnabled

  private let context: VLDataError.Context<CONTEXTTYPE>
  private let alignment: TextAlignment

  /// Creates a PageView for a given error context.
  /// - Parameters:
  ///   - context: The error context to display.
  ///   - alignment: Text alignment for the description. Default is `.center`.
  public init(_ context: VLDataError.Context<CONTEXTTYPE>,
              alignment: TextAlignment = .leading)
  {
   self.context = context
   self.alignment = alignment
  }

  /// Creates a PageView from a type, title, and underlying error.
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
             alignment: alignment)
  }

  public var body: some View
  {
   VLDataError.DescriptionView(context,
                               alignment: alignment)
   .background(style.background)
  }
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

struct PageView_Previews: PreviewProvider
{
 static let dummyError = PreviewPageContextError(.fatal,
                                                 "Fatal error",
                                                 description: "We are experiencing a technical problem that prevents the application from starting due to an issue with our data management system.\nPlease try the following actions:\n\n1. Check if an update for the application is available.\n2. Make sure you have enough storage space on your device.",
                                                 error: URLError(.badURL))

 static var previews: some View
 {
  VLDataError.PageView(dummyError)
  .environment(\.contextErrorDismissEnabled, true)
//  .previewInterfaceOrientation(.landscapeLeft)
//  .preferredColorScheme(.dark)
 }
}
#endif
