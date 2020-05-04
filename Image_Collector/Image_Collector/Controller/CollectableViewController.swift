//
//  ViewController.swift
//  Image_Collector
//
//  Created by Julia Debecka on 03/05/2020.
//  Copyright © 2020 Julia Debecka. All rights reserved.
//

import UIKit

class CollectableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var collectables: [Collactable] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "photoCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getDataFromCore()
    }
}

extension CollectableViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collectables.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath)
        let collectable = self.collectables[indexPath.row]
        cell.textLabel?.text = collectable.title
        if let image = collectable.image {
            cell.imageView?.image = UIImage(data: image)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                
                context.delete(collectables[indexPath.row])
                (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
                getDataFromCore()
            }
        }
    }
    
}

fileprivate extension CollectableViewController {
    func getDataFromCore(){
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let collactables = try?
                context.fetch(Collactable.fetchRequest()) {
                if let theCollectables = collactables as? [Collactable]{
                    self.collectables = theCollectables
                    self.tableView.reloadData()
                }
            }
        }
    }
}
