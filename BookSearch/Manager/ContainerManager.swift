
import Foundation
import CoreData

class ContainerManager {
    
    static let shared = ContainerManager()

    lazy var persistentContainer: NSPersistentContainer = {
       
        let container = NSPersistentContainer(name: "BookSearch")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private init() {
    }

    //CRUD하는부분 func을 만들어야함
//
//    func create(authors: String, price: Int32, title: String) {
//    
//        let booksearch = Document(from: context)
//        booksearch.authors = authors
//        booksearch.price = price
//        booksearch.title = title
//    }
}


