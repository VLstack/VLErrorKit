import SwiftUI
import VLstackNamespace
import VLSFSymbolKit

extension VLstack.DataError
{
 public struct Context<CONTEXTTYPE: VLstack.DataError.ContextType>: Hashable, Equatable
 {
  private let type: CONTEXTTYPE
  public let sfSymbol: VLstack.SFSymbol
  public let symbolVariant: SymbolVariants
  public let title: String
  public let description: String?
  public let error: (any Error)?

  public init(_ type: CONTEXTTYPE,
              _ title: String,
              sfSymbol: VLstack.SFSymbol? = nil,
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

  public func isEqual(_ target: CONTEXTTYPE?,
                      strict: Bool = false) -> Bool
  {
   strict ? type == target : target == nil || type == target
  }

  public static func == (lhs: VLstack.DataError.Context<CONTEXTTYPE>,
                         rhs: VLstack.DataError.Context<CONTEXTTYPE>) -> Bool
  {
      lhs.type == rhs.type
   && lhs.sfSymbol == rhs.sfSymbol
   && lhs.title == rhs.title
   && lhs.description == rhs.description
  }

  public func hash(into hasher: inout Hasher)
  {
   hasher.combine(type)
   hasher.combine(sfSymbol)
   hasher.combine(title)
   hasher.combine(description)
  }
 }
}
