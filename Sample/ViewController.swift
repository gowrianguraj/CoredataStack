//
//  ViewController.swift
//  Sample
//
//  Created by gowri anguraj on 01/10/19.
//  Copyright © 2019 gowri anguraj. All rights reserved.
//

import UIKit
import Alamofire
import CoreData


class ViewController: UIViewController {
    
    @IBOutlet var listTable : UITableView!
    var albumModels:[AlbumModels] = []

    lazy var fetchedhResultController: NSFetchedResultsController<NSFetchRequestResult> = {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Dogs.self))
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "url", ascending: true)]
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.sharedInsance.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self as? NSFetchedResultsControllerDelegate
        return frc
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateTableContent()
    }
    
    func updateTableContent() {
        
        do {
            try self.fetchedhResultController.performFetch()
            print("COUNT FETCHED FIRST: \(String(describing: self.fetchedhResultController.sections?[0].numberOfObjects))")
        } catch let error  {
            print("ERROR: \(error)")
        }
        
        let swiftyParam:[String:AnyObject] = [:]
        
        ServiceParser.DoNetworkCall(view: self.view, url: "https://api.myjson.com/bins/kp2e8", parameter:swiftyParam) { (feedmode:[data]) in
            
            saveInCoreDataWith(array: <#T##[[String : AnyObject]]#>)
         
            
            self.albumModels = feedmode.map({return AlbumModels(albums: $0)})
    
            self.listTable.dataSource = self
            self.listTable.delegate = self
            self.listTable.reloadData()
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}



extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = fetchedhResultController.sections?.first?.numberOfObjects {
            return count
        }
        return self.albumModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let tablecell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        
        if let photo = fetchedhResultController.object(at: indexPath) as? Dogs {
            tablecell.setPhotoCellWith(dogs: photo)
            // tablecell.albumModels = self.albumModels[indexPath.row]
        }
       
        
        return tablecell
    }
   
}
private func createPhotoEntityFrom(dictionary: [String: AnyObject]) -> NSManagedObject? {
    
    let context = CoreDataStack.sharedInsance.persistentContainer.viewContext
    if let photoEntity = NSEntityDescription.insertNewObject(forEntityName: "Dogs", into: context) as? Dogs {
        photoEntity.dogName = dictionary["dogName"] as? String
        photoEntity.discription = dictionary["description"] as? String
       // photoEntity.age = dictionary["age"] as? [String : AnyObject]
        let mediaDictionary = dictionary["url"] as? [String: AnyObject]
        photoEntity.url = mediaDictionary?["url"] as? String
        return photoEntity
    }
    return nil
}

private func saveInCoreDataWith(array: [[String: AnyObject]]) {
    _ = array.map{createPhotoEntityFrom(dictionary: $0)}
    do {
        try CoreDataStack.sharedInsance.persistentContainer.viewContext.save()
    } catch let error {
        print(error)
    }
}

private func clearData() {
    do {
        
        let context = CoreDataStack.sharedInsance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Dogs.self))
        do {
            let objects  = try context.fetch(fetchRequest) as? [NSManagedObject]
            _ = objects.map{$0.map{context.delete($0)}}
            CoreDataStack.sharedInsance.saveContext()
        } catch let error {
            print("ERROR DELETING : \(error)")
        }
    }
}




