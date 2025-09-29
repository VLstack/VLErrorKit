import VLstackNamespace
import VLSFSymbolKit
import SwiftUI

extension VLstack.DataError
{
 /// A SwiftUI view representing a styled error box with an optional content view.
 /// - Parameters:
 ///   - context: The error context to display (symbol, title, description).
 ///   - alignment: Text alignment for the content. Default is `.center`.
 ///   - content: Optional additional content displayed below the error title.
 internal struct BoxView<CONTEXTTYPE: VLstack.DataError.ContextType, CONTENT: View>: View
 {
  @Environment(\.dismiss) private var dismiss
  @Environment(\.horizontalSizeClass) private var horizontalSizeClass
  @Environment(\.contextErrorDismissEnabled) private var dismissEnabled
  @Environment(\.contextErrorBoxStyle) private var style

  private let context: VLstack.DataError.Context<CONTEXTTYPE>
  private let alignment: TextAlignment
  private let content: () -> CONTENT

  /// Creates a BoxView with a given error context and optional content.
  internal init(_ context: VLstack.DataError.Context<CONTEXTTYPE>,
              alignment: TextAlignment = .center,
              @ViewBuilder content: @escaping () -> CONTENT)
  {
   self.context = context
   self.alignment = alignment
   self.content = content
  }

  /// Creates a BoxView from a type, title, and underlying error with optional content.
  internal init(_ type: CONTEXTTYPE,
              _ title: String,
              error: any Error,
              alignment: TextAlignment = .center,
              @ViewBuilder content: @escaping () -> CONTENT)
  {
   self.init(VLstack.DataError.Context<CONTEXTTYPE>(type, title, error: error),
             alignment: alignment,
             content: content)
  }

  internal var body: some View
  {
   VStack
   {
    titleView
    .padding(.horizontal)
    .padding(.vertical, 10)
    .background(style.symbolBackground)
    .overlay(alignment: .topTrailing)
    {
     if dismissEnabled
     {
      #if os(iOS) || os(macOS) || os(tvOS) || os(watchOS)
      if #available(iOS 26.0, macOS 26.0, tvOS 26.0, watchOS 26.0, *)
      {
       dismissButtonView
      }
      else
      {
       fallbackDismissButtonView
      }
      #else
      fallbackDismissButtonView
      #endif
     }
    }

    ScrollView(.vertical)
    {
     content()
    }
   }
   .background(style.background)
   .clipShape(.rect(cornerRadius: style.strokeRadius))
   .overlay
   {
    RoundedRectangle(cornerRadius: style.strokeRadius)
     .stroke(style.strokeColor, lineWidth: 1)
   }
   .contentShape(.rect(cornerRadius: style.strokeRadius))
   .padding()
  }

  @available(iOS 26.0, macOS 26.0, tvOS 26.0, watchOS 26.0, *)
  @available(visionOS, unavailable)
  internal var dismissButtonView: some View
  {
   Button(action: { dismiss() })
   {
    Image(.xmark)
     .font(.system(size: 16, weight: .bold))
     .padding(5)
   }
   .buttonBorderShape(.circle)
   .buttonStyle(.glass)
   .padding()
  }

  @available(iOS, introduced: 13.0, deprecated: 26.0)
  @available(macOS, introduced: 13.0, deprecated: 26.0)
  @available(tvOS, introduced: 13.0, deprecated: 26.0)
  @available(watchOS, introduced: 1.0, deprecated: 26.0)
  @available(visionOS 1.0, *)
  internal var fallbackDismissButtonView: some View
  {
   Button(action: { dismiss() })
   {
    Image(.xmark)
     .font(.system(size: 16, weight: .bold))
     .foregroundColor(Color(.label))
     .padding(10)
     .background(Color(.systemBackground))
     .clipShape(.circle)
     .shadow(radius: 16)
   }
   .buttonStyle(.plain)
   .padding()
  }

  internal var horizontalTitleView: some View
  {
   HStack(alignment: .center, spacing: 10)
   {
    Image(context.sfSymbol)
     .symbolVariant(context.symbolVariant)
     .font(.system(size: 64, weight: .bold))
     .foregroundStyle(style.symbolForeground)

    Text(context.title)
     .multilineTextAlignment(.center)
     .font(style.titleFont)
     .foregroundStyle(style.titleForeground)
     .fontWeight(.bold)
     .textCase(nil)
   }
   .frame(maxWidth: .infinity, alignment: .leading)
  }

  @ViewBuilder
  internal var titleView: some View
  {
   if horizontalSizeClass == .compact
   {
    ViewThatFits(in: .horizontal)
    {
     horizontalTitleView
     verticalTitleView
    }
   }
   else
   {
    horizontalTitleView
   }
  }

  internal var verticalTitleView: some View
  {
   VStack(alignment: .center, spacing: 10)
   {
    Image(context.sfSymbol)
     .symbolVariant(context.symbolVariant)
     .font(.system(size: 64, weight: .bold))
     .foregroundStyle(style.symbolForeground)

    Text(context.title)
     .multilineTextAlignment(.center)
     .font(style.titleFont)
     .foregroundStyle(style.titleForeground)
     .fontWeight(.bold)
     .textCase(nil)
   }
   .frame(maxWidth: .infinity, alignment: .center)
  }
 }
}
