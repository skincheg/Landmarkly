//
//  CustomExtension.swift
//  Landmarkly
//
//  Created by Артур Мугинов on 14.05.2022.
//

import Foundation

// MARK: - UserDefaults extensions

public extension UserDefaults {

    /// Set Codable object into UserDefaults
    ///
    /// - Parameters:
    ///   - object: Codable Object
    ///   - forKey: Key string
    /// - Throws: UserDefaults Error
    public func set<T: Codable>(object: T, forKey: String) throws {

        let jsonData = try JSONEncoder().encode(object)

        set(jsonData, forKey: forKey)
    }

    /// Get Codable object into UserDefaults
    ///
    /// - Parameters:
    ///   - object: Codable Object
    ///   - forKey: Key string
    /// - Throws: UserDefaults Error
    public func get<T: Codable>(objectType: T.Type, forKey: String) throws -> T? {

        guard let result = value(forKey: forKey) as? Data else {
            return nil
        }

        return try JSONDecoder().decode(objectType, from: result)
    }
}

// MARK: - JSONDecoder extensions

public extension JSONDecoder {

    /// Decode an object, decoded from a JSON object.
    ///
    /// - Parameter data: JSON object Data
    /// - Returns: Decodable object
    public func decode<T: Decodable>(from data: Data?) -> T? {
        guard let data = data else {
            return nil
        }
        return try? self.decode(T.self, from: data)
    }

    /// Decode an object in background thread, decoded from a JSON object.
    ///
    /// - Parameters:
    ///   - data: JSON object Data
    ///   - onDecode: Decodable object
    public func decodeInBackground<T: Decodable>(from data: Data?, onDecode: @escaping (T?) -> Void) {
        DispatchQueue.global().async {
            let decoded: T? = self.decode(from: data)

            DispatchQueue.main.async {
                onDecode(decoded)
            }
        }
    }
}

// MARK: - JSONEncoder extensions

public extension JSONEncoder {

    /// Encodable an object
    ///
    /// - Parameter value: Encodable Object
    /// - Returns: Data encode or nil
    public func encode<T: Encodable>(from value: T?) -> Data? {
        guard let value = value else {
            return nil
        }
        return try? self.encode(value)
    }

    /// Encodable an object in background thread
    ///
    /// - Parameters:
    ///   - encodableObject: Encodable Object
    ///   - onEncode: Data encode or nil
    public func encodeInBackground<T: Encodable>(from encodableObject: T?, onEncode: @escaping (Data?) -> Void) {
        DispatchQueue.global().async {
            let encode = self.encode(from: encodableObject)

            DispatchQueue.main.async {
                onEncode(encode)
            }
        }
    }
}

// MARK: - NSUserDefaults extensions

public extension UserDefaults {

    /// Set Encodable object in UserDefaults
    ///
    /// - Parameters:
    ///   - type: Encodable object type
    ///   - key: UserDefaults key
    /// - Throws: An error if any value throws an error during encoding.
    public func set<T: Encodable>(object type: T, for key: String, onEncode: @escaping (Bool) -> Void) throws {

        JSONEncoder().encodeInBackground(from: type) { [weak self] (data) in
            guard let data = data, let `self` = self else {
                onEncode(false)
                return
            }
            self.set(data, forKey: key)
            onEncode(true)
        }
    }

    /// Get Decodable object in UserDefaults
    ///
    /// - Parameters:
    ///   - objectType: Decodable object type
    ///   - forKey: UserDefaults key
    ///   - onDecode: Codable object
    public func get<T: Decodable>(object type: T.Type, for key: String, onDecode: @escaping (T?) -> Void) {
        let data = value(forKey: key) as? Data
        JSONDecoder().decodeInBackground(from: data, onDecode: onDecode)
    }
}
