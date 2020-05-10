//
//  ViewController.swift
//  BeerMi
//
//  Created by Julia Debecka on 08/05/2020.
//  Copyright © 2020 Julia Debecka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let beerCellID = "BeerCell"
    
    var listBeer = ["Corona", "Perla", "Lomza"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listBeer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: beerCellID, for: indexPath)
        cell.textLabel?.text = listBeer[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailText = listBeer[indexPath.row]
        openDetails(for: detailText)
    }
}

fileprivate extension ViewController {
    
    func openDetails(for Selection: String) {
        let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BeerDetailVC") as! DetailViewController
        detailVC.text = Selection
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
