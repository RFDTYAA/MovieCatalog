import SwiftUI

public extension Color {
    static let theme = ColorTheme()
}

public struct ColorTheme {
    private static var bundle: Bundle {
        class BundleFinder {}
        return Bundle(for: BundleFinder.self)
    }
    
    // PERBAIKAN: Sesuaikan nama dengan nama file di Assets.xcassets
    public let background = Color("Background", bundle: Self.bundle)
    public let primaryText = Color("PrimaryText", bundle: Self.bundle)
    public let secondaryText = Color("SecondaryText", bundle: Self.bundle)
    public let accent = Color("Accent", bundle: Self.bundle)
    public let surface = Color("Surface", bundle: Self.bundle) // Nama ini sudah benar

    public init() {}
}
