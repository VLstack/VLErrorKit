import Foundation

extension VLDataError
{
 /// Localized text for a key of the package catalog.
 /// The app catalog is searched first, so the app can override any text by defining the same key;
 /// otherwise the package translation is used.
 /// - Parameter key: The key, shared by the app and package catalogs.
 /// - Returns: The app translation if any, else the package translation, else the key itself.
 internal static func localized(_ key: String) -> String
 {
  Bundle.main.localizedString(forKey: key,
                              value: Bundle.module.localizedString(forKey: key, value: nil, table: nil),
                              table: nil)
 }
}
