import Foundation

class CustomBundle: Bundle {
    override class func preferredLocalizations(from localizations: [String]) -> [String] {
        return [Bundle.preferredLocalizations(from: localizations).first ?? "en"]
    }
}
