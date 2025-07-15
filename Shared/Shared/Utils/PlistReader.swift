import Foundation

public enum PlistReader {
    public static func getValue(forKey key: String) -> String? {
        // Gunakan Bundle.main karena Secrets.plist ada di aplikasi utama
        guard let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
              let xml = FileManager.default.contents(atPath: path),
              let secrets = try? PropertyListSerialization.propertyList(from: xml, options: .mutableContainersAndLeaves, format: nil) as? [String: Any] else {
            print("Error: Secrets.plist tidak ditemukan atau tidak bisa dibaca.")
            return nil
        }
        
        return secrets[key] as? String
    }
}
