//
//  AppUserDefaults.swift
//  Data
//
//  Created by Shaban Kamel on 31/7/2020.
//  Copyright © 2020 sha. All rights reserved.
//

import Foundation

public var defaults = Defaults()

enum DefaultsKey {
    case isAuthenticated
    case token
    case customer

    var name: String {
        get { "\(self)" }
    }
}

public struct Defaults {
   public var token: String? {
        get { AppDefaults.value(for: .token) }
        set { AppDefaults.save(value: newValue, key: .token) }
    }
}

public struct AppDefaults {

    static func save<T: Codable>(
            value: T,
            keyEncoded: DefaultsKey,
            _ defaults: UserDefaults = UserDefaults.standard
    ) {
        save(value: try? PropertyListEncoder().encode(value), key: keyEncoded)
    }

    static func value<T: Decodable>(
            forEncoded key: DefaultsKey,
            _ defaults: UserDefaults = UserDefaults.standard
    ) -> T? {

        guard let data: Data = defaults.value(forKey: key.name) as? Data  else {
            return nil
        }

        return try? PropertyListDecoder().decode(T.self, from: data) as T
    }

    static func saveArray<T: Codable>(
            value: [T],
            keyEncoded: DefaultsKey,
            _ defaults: UserDefaults = UserDefaults.standard
    ) {
        save(value: try? PropertyListEncoder().encode(value), key: keyEncoded)
    }

    static func valueArray<T: Decodable>(
            forEncoded key: DefaultsKey,
            _ defaults: UserDefaults = UserDefaults.standard
    ) -> [T]? {

        guard let data: Data = defaults.value(forKey: key.name) as? Data  else {
            return nil
        }

        return try? PropertyListDecoder().decode([T].self, from: data) as [T]
    }

    static func save(
            value: Any?,
            key: DefaultsKey,
            _ defaults: UserDefaults = UserDefaults.standard
    ) {
        defaults.setValue(value, forKey: key.name)
        defaults.synchronize()
    }

    static func value<T>(
            for key: DefaultsKey,
            _ defaults: UserDefaults = UserDefaults.standard
    ) -> T? { defaults.value(forKey: key.name) as? T }

    static func clearValue(
            for key: DefaultsKey,
            _ defaults: UserDefaults = UserDefaults.standard
    ) {
        defaults.setValue(nil, forKey: key.name)
        defaults.synchronize()
    }

    public static func clear(_ defaults: UserDefaults = UserDefaults.standard){
        let domain = Bundle.main.bundleIdentifier!
        defaults.removePersistentDomain(forName: domain)
        defaults.synchronize()
        print(Array(defaults.dictionaryRepresentation().keys).count)
    }
}
