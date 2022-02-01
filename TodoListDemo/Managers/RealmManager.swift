//
//  RealmManager.swift
//  TodoListDemo
//
//  Created by Osaretin Uyigue on 2/1/22.
//

import Foundation
import RealmSwift

class RealManager: ObservableObject {
    //MARK: - Properties
    private(set) var localRealm: Realm?
    
    
    //MARK: - Init
    init() {
        openRealm()
    }
    
    
    //MARK: - Handlers
    func openRealm() {
        do {
            let config = Realm.Configuration(schemaVersion: 1)
            
            Realm.Configuration.defaultConfiguration = config
            
            localRealm = try Realm()
        } catch let realmError {
            
        }
    }
}
