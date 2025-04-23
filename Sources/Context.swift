import SwiftUI
import VLstackNamespace
import VLSFSymbolKit

extension VLstack.DataError
{
 public struct Context<CONTEXTTYPE: VLstack.DataError.ContextType>: Hashable, Equatable
 {
  private let type: CONTEXTTYPE
  public let sfSymbol: VLstack.SFSymbol
  public let message: String
  public let description: String?
  public var originalError: (any Error)?

  public init(_ type: CONTEXTTYPE,
              _ message: String,
              sfSymbol: VLstack.SFSymbol = .infoCircle,
              description: String? = nil,
              originalError: (any Error)? = nil)
  {
   self.type = type
   self.message = message
   self.sfSymbol = sfSymbol
   self.description = description
   self.originalError = originalError
  }

  public init(_ type: CONTEXTTYPE,
              _ message: String,
              sfSymbol: VLstack.SFSymbol = .infoCircle,
              error: any Error)
  {
   self.init(type,
             message,
             sfSymbol: sfSymbol,
             description: error.localizedDescription,
             originalError: error)
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
   && lhs.message == rhs.message
   && lhs.description == rhs.description
   && lhs.originalError?.localizedDescription == rhs.originalError?.localizedDescription
  }

  public func hash(into hasher: inout Hasher)
  {
   hasher.combine(type)
   hasher.combine(sfSymbol)
   hasher.combine(message)
   hasher.combine(description)
   hasher.combine(originalError?.localizedDescription)
  }
 }
}
