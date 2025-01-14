//
//  RealmManager.swift
//  WorkoutScheduler
//
//  Created by 土橋正晴 on 2025/01/13.
//

import Foundation
import RealmSwift


// MARK: - Protocol

protocol RealmProtocol {
    associatedtype Model
    static func allFetch() throws -> [Model]
    static func fetch(id: String) throws -> Model
    static func add(_ model: Model) throws
    static func update(_ model: Model) throws
    static func delete(_ model: Model) throws
    static func allDetele() throws
}



// MARK: - Manager

struct RealmManager {
    
    static let realm: Realm? = {
        var configuration = Realm.Configuration()
        configuration.schemaVersion = UInt64(1)
        guard let url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.masaharu.dobashi.WorkoutScheduler") else { return nil }
        configuration.fileURL = url.appendingPathComponent("db.realm")
        return try? Realm(configuration: configuration)
    }()
    
}


// MARK: - Error

struct DBError: Error {
    var message: String
    var type: ErrorType
    
    enum ErrorType {
        case fetchFailed
        case addFailed
        case updateFailed
        case deleteFailed
    }
}
