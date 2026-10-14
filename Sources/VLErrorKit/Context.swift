import SwiftUI
import VLSFSymbolKit

extension VLDataError
{
 /// Represents a typed error context for VLDataError.
 /// Contains the type, SF Symbol, title, optional description, and optional underlying error.
 public struct Context<CONTEXTTYPE: VLDataError.ContextType>: Hashable, Equatable
 {
  @usableFromInline internal let type: CONTEXTTYPE
  public let sfSymbol: VLSFSymbol
  public let symbolVariant: SymbolVariants
  public let title: String
  public let description: String?
  public let error: (any Error)?

  /// Creates a new error context.
  /// - Parameters:
  ///   - type: The type of the context.
  ///   - title: The main title of the error.
  ///   - sfSymbol: Optional SF Symbol to display. Defaults to `.info`.
  ///   - symbolVariant: Optional symbol variant. Defaults to `.circle`.
  ///   - description: Optional description text. Defaults to `error?.localizedDescription`.
  ///   - error: Optional underlying error.
  public init(_ type: CONTEXTTYPE,
              _ title: String,
              sfSymbol: VLSFSymbol? = nil,
              symbolVariant: SymbolVariants? = nil,
              description: String? = nil,
              error: (any Error)? = nil)
  {
   self.type = type
   self.title = title
   if let sfSymbol
   {
    self.sfSymbol = sfSymbol
    self.symbolVariant = symbolVariant ?? .none
   }
   else
   {
    self.sfSymbol = .info
    self.symbolVariant = .circle
   }
   self.description = description ?? error?.localizedDescription
   self.error = error
  }

  /// Compares this context type with a target type.
  /// - Parameters:
  ///   - target: The target context type to compare.
  ///   - strict: If true, only exact type match returns true. If false, nil target returns true.
  /// - Returns: Boolean indicating whether the target matches.
  @inlinable
  public func isEqual(_ target: CONTEXTTYPE?,
                      strict: Bool = false) -> Bool
  {
   strict ? type == target : target == nil || type == target
  }

  /// Equatable conformance comparing type, sfSymbol, title, and description.
  @inlinable
  public static func == (lhs: VLDataError.Context<CONTEXTTYPE>,
                         rhs: VLDataError.Context<CONTEXTTYPE>) -> Bool
  {
      lhs.type == rhs.type
   && lhs.sfSymbol == rhs.sfSymbol
   && lhs.title == rhs.title
   && lhs.description == rhs.description
  }

  /// Hashes the context properties (excluding the underlying error).
  @inlinable
  public func hash(into hasher: inout Hasher)
  {
   hasher.combine(type)
   hasher.combine(sfSymbol)
   hasher.combine(title)
   hasher.combine(description)
  }
 }
}
