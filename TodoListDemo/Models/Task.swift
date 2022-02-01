//
//  Task.swift
//  TodoListDemo
//
//  Created by Osaretin Uyigue on 2/1/22.
//

import Foundation
import RealmSwift

class Task: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title = ""
    @Persisted var completed = false
}
