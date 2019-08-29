//
//  FirstViewController.swift
//  Resume
//
//  Created by Miguel Fernando Cuellar Gauna on 8/26/19.
//  Copyright © 2019 Miguel Fernando Cuellar Gauna. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var jobs = [Job]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib.init(nibName: "WorkCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "workCell")
        loadData()
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return jobs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "workCell", for: indexPath) as! WorkCollectionViewCell
        if let startDate = jobs[indexPath.row].startDate {
            if let endDate = jobs[indexPath.row].endDate {
                cell.datesLbl.text = " \(startDate.dateMonthYear()) - \(endDate.dateMonthYear())"
            } else {
                cell.datesLbl.text = " \(startDate.dateMonthYear())"
            }
        }
        cell.imageView.downloadFrom(endpoint: jobs[indexPath.row].logo ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let navigationController = UINavigationController(rootViewController: self)
//        let newViewController = WorkDetailViewController(nibName: "WorkDetailViewController", bundle: nil)
//        _ = newViewController.view
//        newViewController.job = jobs[indexPath.row]
//        navigationController.present(newViewController, animated: true)
        
        let detailViewController = WorkDetailViewController()
        detailViewController.job = jobs[indexPath.row]
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
     func loadData() {
        Network.getExternalData(fileLocation: Endpoints.shared.work) { (event: Work?, error) in
            if let err = error {
                self.alert(message: err.localizedDescription, title: "Error")
            }
            if let work = event {
                if let jobsArray = work.experience {
                    self.jobs = jobsArray.sorted(by: {$0.startDate?.compare($1.startDate ?? Date()) == .orderedDescending})
                }
            }
        }
    }


}

