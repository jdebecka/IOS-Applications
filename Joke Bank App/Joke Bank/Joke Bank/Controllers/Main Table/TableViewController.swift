//
//  TableViewController.swift
//  Joke Bank
//
//  Created by Julia Debecka on 04/04/2020.
//  Copyright © 2020 Julia Debecka. All rights reserved.
//
import UIKit

class TableViewController: UIViewController {
    private let jokeCellIdentifier = "Cell"
    
    var tableView: UITableView!
    var wineList: Wine!
    
    
    override func loadView() {
        super.loadView()
        wineList = Wine()
        self.tableView = UITableView()
        self.view.addSubview(tableView)
        tableView.dataSource = self
        loadData()
        setUpSnapKit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: jokeCellIdentifier)
    }
    
    func setUpSnapKit(){
        tableView.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
        }
    }
    
    fileprivate func loadData(){
        WineRepository.getAllWines { [weak self] wines, error  in
            self?.wineList = wines ?? []
            self?.tableView.reloadData()
        }
        
    }
}

extension TableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wineList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(70)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: jokeCellIdentifier, for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        cell.wineData = wineList[indexPath.row]
        return cell
    }
}
