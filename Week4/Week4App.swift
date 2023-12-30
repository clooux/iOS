//
//  Week4App.swift
//  Week4
//
//  Created by user249775 on 12/30/23.
//

import SwiftUI
import CoreData

@main
struct Week4App: App {
    let persistenceController = PersistenceController.shared
    
    init() {
        loadProducts()
        loadCategories()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

let API = "http://127.0.0.1:3000"

extension Week4App {
    func loadProducts() {
        let context = persistenceController.container.viewContext
        let serverURL = API + "/products"
        let url = URL(string: serverURL)
        let request = URLRequest(url: url!)
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let productEntity = NSEntityDescription.entity(forEntityName: "Product", in: context)
        let dispatchGroup = DispatchGroup()
        
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            guard error == nil else {
                return
            }
            guard data != nil else {
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                if let object = json as? [String:Any] {
                    print(object)
                } else if let object = json as? [Any] {
                    for item in object as! [Dictionary<String, AnyObject>] {
                        let id = item["id"] as! Int64
                        let name = item["name"] as! String
                        let price = item["price"] as! Double
                        
                        if !checkIfExists(model: "Product", field: "id", fieldValue: id) {
                            let product = NSManagedObject(entity: productEntity!, insertInto: context)
                            product.setValue(id, forKey: "id")
                            product.setValue(name, forKey: "name")
                            print("Added product: name: \(name), id:\(id)")
                        } else {
                            print("Product: name: \(name), id: \(id) is in DB")
                        }
                    }
                    try context.save()
                    dispatchGroup.leave()
                } else {
                    print("Invalid JSON")
                }
            } catch {
                dispatchGroup.leave()
                return
            }
        })
        dispatchGroup.enter()
        task.resume()
        dispatchGroup.wait()
    }
    
    func loadCategories() {
        let context = persistenceController.container.viewContext
        let serverURL = API + "/categories"
        
        let url = URL(string: serverURL)
        let request = URLRequest(url: url!)
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let categoryEntity = NSEntityDescription.entity(forEntityName: "Category", in: context)
        let dispatchGroup = DispatchGroup()
        
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            guard error == nil else {
                return
            }
            guard data != nil else {
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                if let object = json as? [String:Any] {
                    print(object)
                } else if let object = json as? [Any] {
                    for item in object as! [Dictionary<String, AnyObject>] {
                        let id = item["id"] as! Int64
                        let name = item["name"] as! String
                        
                        if !checkIfExists(model: "Category", field: "id", fieldValue: id) {
                            let category = NSManagedObject(entity: categoryEntity!, insertInto: context)
                            category.setValue(id, forKey: "id")
                            category.setValue(name, forKey: "name")
                            print("Added category: name: \(name), id:\(id)")
                        } else {
                            print("Category: name: \(name), id: \(id) is in DB")
                        }
                    }
                    try context.save()
                    dispatchGroup.leave()
                } else {
                    print("Invalid JSON")
                }
            } catch {
                dispatchGroup.leave()
                return
            }
        })
        dispatchGroup.enter()
        task.resume()
        dispatchGroup.wait()
    }
    
    
    func checkIfExists(model: String, field: String, fieldValue: CVarArg) -> Bool {
        let context = persistenceController.container.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: model)
        fetchRequest.predicate = NSPredicate(format: "\(field) = %d", fieldValue)
        
        do {
            let fetchResults = try context.fetch(fetchRequest) as? [NSManagedObject]
            if fetchResults!.count > 0 {
                return true
            }
            return false
        } catch {
            print("Error")
        }
        return false
    }
}
