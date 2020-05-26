//
//  ViewController.swift
//  RNDM
//
//  Created by Julia Debecka on 15/05/2020.
//  Copyright © 2020 Julia Debecka. All rights reserved.
//

import UIKit
import Firebase

enum ThoughtCategory: String {
    case serious = "Serious"
    case funny = "Funny"
    case crazy = "Crazy"
    case popular = "Popular"
}

class MainViewController: UIViewController {
    
    private var thoughsList = [Thought]()
    private var thoughtsCollectionReference: CollectionReference!
    private var thoughtsListener: FirebaseFirestore.ListenerRegistration!
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    var selectedCategory = ThoughtCategory.funny.rawValue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        getThoughtsRef()
    }
    @IBAction func categoryChanged(_ sender: Any) {
        switch segment.selectedSegmentIndex {
        case 0:
            selectedCategory = ThoughtCategory.funny.rawValue
        case 1:
            selectedCategory = ThoughtCategory.serious.rawValue
        case 2:
            selectedCategory = ThoughtCategory.crazy.rawValue
        default:
            selectedCategory = ThoughtCategory.popular.rawValue
        }
        
        if selectedCategory == ThoughtCategory.popular.rawValue {
            thoughtsListener.remove()
            setPopularListener()
        }else {
            thoughtsListener.remove()
            setListener()
        }

    }
    
    func setPopularListener(){
        
        thoughtsListener = thoughtsCollectionReference.order(by: NUM_LIKES, descending: true).addSnapshotListener { (snapshot, error) in
            if let error = error {
                debugPrint("Error fetching docs: \(error)")
            }else {
                guard let snap = snapshot else { return }
                self.thoughsList.removeAll()
                self.getAndDecodeData(snap: snap)
            }
            self.tableView.reloadData()
        }
    }
    
    func setListener(){
        
        thoughtsListener = thoughtsCollectionReference.whereField(CATEGORY, isEqualTo: selectedCategory).order(by: TIMESTAMP, descending: true).addSnapshotListener { (snapshot, error) in
            if let error = error {
                debugPrint("Error fetching docs: \(error)")
            }else {
                guard let snap = snapshot else { return }
                self.thoughsList.removeAll()
                self.getAndDecodeData(snap: snap)
            }
            self.tableView.reloadData()
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setListener()
        
        // Remember to remove them once we stop using them
//        thoughtsListener = thoughtsCollectionReference.addSnapshotListener { (snapshot, error) in
//            if let error = error {
//                debugPrint("Error fetching docs: \(error)")
//            }else {
//                guard let snap = snapshot else { return }
//                self.thoughsList.removeAll()
//                self.getAndDecodeData(snap: snap)
//            }
//            self.tableView.reloadData()
//        }
//        thoughtsCollectionReference.getDocuments { (snapshot, error) in
//            if let error = error {
//                debugPrint("Error fetching docs: \(error)")
//            }else {
//                guard let snap = snapshot else { return }
//                self.getAndDecodeData(snap: snap)
//            }
//            self.tableView.reloadData()
//        }
    }
}

extension MainViewController :  UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return thoughsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "thoughtCell", for: indexPath) as? ThoughtTableViewCell else { return UITableViewCell() }
        let thought = thoughsList[indexPath.row]
        let objDateformat: DateFormatter = DateFormatter()
        objDateformat.dateFormat = "MMM d, yyyy"
        let date = objDateformat.string(from: thought.date)
        
        cell.dateLbl.text = date
        cell.usenameLbl.text = thought.username
        cell.thoughtLbl.text = thought.thoughtTxt
        cell.likeslbl.text = String(describing: thought.numLikes)
        return cell
    }
}

fileprivate extension MainViewController {
    func getThoughtsRef() {
        thoughtsCollectionReference = Firestore.firestore().collection("thoughts")
    }
    
    func getAndDecodeData(snap: QuerySnapshot) {
        for document in snap.documents {
            let data = document.data()
            let username = data[USERNAME] as? String ?? "Anonymous"
            let date = data[TIMESTAMP] as? Date ?? Date()
            let thoughtTxt = data[THOUGHT] as? String ?? ""
            let likes = data[NUM_LIKES] as? Int ?? 0
            let category = data[CATEGORY] as? String ?? "Funny"
            let docID = document.documentID
            
            var exist: Bool = false
            
            self.thoughsList.forEach { (thought) in
                if thought.documentID == docID {
                    thought.numLikes = likes
                    exist = true
                }
            }
            
            if !exist {
                self.thoughsList.append(Thought(category: category, numComments: 0, thoughtTxt: thoughtTxt, numLikes: likes, date: date, username: username, documentID: docID))
            }
        }
    }
}
