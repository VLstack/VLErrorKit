import Testing
@testable import VLErrorKit

/// Texts come from the package catalog when the app does not override them
///
/// The test runner has no catalog of its own, so these tests cover the package fallback only;
/// the app override is checked in iOS-TestLocalPackages
@Suite("Localization")
struct LocalizationTests
{
 @Test("Package keys are translated, never returned as raw keys",
       arguments: [ "I18N-VLErrorKit.Close", "I18N-VLErrorKit.Error" ])
 func packageKey(_ key: String)
 {
  let text = VLDataError.localized(key)

  #expect(!text.isEmpty)
  #expect(text != key)
 }

 @Test("An unknown key is returned as is")
 func unknownKey()
 {
  #expect(VLDataError.localized("I18N-VLErrorKit.Unknown") == "I18N-VLErrorKit.Unknown")
 }
}
