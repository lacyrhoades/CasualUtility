//
//  Persistable.swift
//
//  Created by Lacy Rhoades on 3/27/18.
//  Copyright © 2018 Lacy Rhoades. All rights reserved.
//

import Foundation
import Disk

public protocol Persistable: Codable {
    init()
    static func load() -> Self
    static func save(_ obj: Self)
    static var persistenceFileName: String { get }
}

extension Persistable {
    public static func load() -> Self {
        
        do {
            let stored = try Disk.retrieve(Self.persistencePath, from: .documents, as: Self.self)
            return stored
        } catch {
            let message = "Error loading \"Persistable\" object from \(Self.persistencePath)\nError message: \(error.localizedDescription)"
            print(message)
            if FileManager.default.fileExists(atPath: Self.persistencePath) {
                assert(false, message)
            }
        }
        
        return Self()
    }

    public static func save(_ obj: Self) {
        do {
            try Disk.save(obj, to: .documents, as: Self.persistencePath)
        } catch {
            let message = "Error saving \"Persistable\" object from \(Self.persistencePath)\nError message: \(error.localizedDescription)"
            print(message)
        }
    }

    public static var persistencePath: String {
        return self.persistenceFileName.appending(".json")
    }
    
    public init?(_: [String: Any]) {
        return nil
    }
}
