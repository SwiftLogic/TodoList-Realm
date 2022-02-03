//
//  RealmManager.swift
//  TodoListDemo
//
//  Created by Osaretin Uyigue on 2/1/22.
//

import Foundation
import RealmSwift

class RealmManager: ObservableObject {
    //MARK: - Properties
    private(set) var localRealm: Realm?
    @Published private(set) var tasks: [Task] = []
    
    //MARK: - Init
    init() {
        openRealm()
        getTask()
    }
    
    
    //MARK: - Handlers
    func openRealm() {
        do {
            let config = Realm.Configuration(schemaVersion: 1)
            
            Realm.Configuration.defaultConfiguration = config
            
            localRealm = try Realm()
        } catch let realmError {
            print("Error opening realm ", realmError.localizedDescription)
        }
    }
    
    
    func addTask(taskTitle: String)	{
        if let localRealm = localRealm{
            do {
                try localRealm.write {
                    let newTask = Task(value: ["title": taskTitle, "completed": false])
                    localRealm.add(newTask)
                    getTask()
                    print("Added new task to realm \(newTask)")
                }
            } catch let error {
                print("error failed to add task to realm ", error.localizedDescription)
            }
        }
    }
    
    
    func getTask() {
        if let localRealm = localRealm {
            let allTask = localRealm.objects(Task.self).sorted(byKeyPath: "completed")
            tasks = []
            allTask.forEach { task in
                tasks.append(task)
            }
        }
    }
    
    
    func updateTask(id: ObjectId, completed: Bool) {
        if let localRealm = localRealm {
            do {
               let taskToUpdate = localRealm.objects(Task.self).filter(NSPredicate(format: "id == %@", id))
                guard !taskToUpdate.isEmpty else {return}
                
                try localRealm.write {
                    taskToUpdate[0].completed = completed
                    getTask()
                    print("Updated task with id \(id)! Completed status: \(completed)")
                }
            } catch let error {
                print("Error updating \(id) to Realm ", error.localizedDescription)
            }
        }
    }
    
    
    func deleteTask(id: ObjectId) {
        if let localRealm = localRealm {
            do {
                let taskToDelete = localRealm.objects(Task.self).filter(NSPredicate(format: "id == %@", id))
                guard !taskToDelete.isEmpty else {return}
                
                try localRealm.write {
                    localRealm.delete(taskToDelete)
                    getTask()
                    print("Deleted task with id \(id)")
                }
                
                 
            } catch let error {
                print("Error deleting task \(id) from Realm: \(error)")
            }
        }
    }
    
}
