import Foundation

enum DefaultsStore {
    static func setCodable<T: Codable>(_ value: T, forKey key: String) {
        do {
            let data = try JSONEncoder().encode(value)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            // Fail silently for SSC demo
            // print("Encode error:", error)
        }
    }
    
    static func getCodable<T: Codable>(_ type: T.Type, forKey key: String) -> T? {
        guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
        do {
            return try JSONDecoder().decode(type, from: data)
        } catch {
            // print("Decode error:", error)
            return nil
        }
    }
    
    static func setInt(_ value: Int, forKey key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    static func getInt(forKey key: String, default defaultValue: Int) -> Int {
        if UserDefaults.standard.object(forKey: key) == nil { return defaultValue }
        return UserDefaults.standard.integer(forKey: key)
    }
    
    static func removeAll(keys: [String]) {
        keys.forEach { UserDefaults.standard.removeObject(forKey: $0) }
    }
}

