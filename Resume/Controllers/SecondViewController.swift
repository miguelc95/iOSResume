//
//  SecondViewController.swift
//  Resume
//
//  Created by Miguel Fernando Cuellar Gauna on 8/26/19.
//  Copyright © 2019 Miguel Fernando Cuellar Gauna. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var infoTxtLbl: UITextView!
    @IBOutlet weak var educationTableView: UITableView!
    @IBOutlet weak var generalStackView: UIStackView!
    
    var education = [Education]() {
        didSet {
            educationTableView.reloadData()
        }
    }
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(self.loadData(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        return refreshControl
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        rotationVerify()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadData(nil)
        setup()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return education.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "educationCell", for: indexPath) as! EducationTableViewCell
            cell.school.text = education[indexPath.row].school
        cell.EducationImage.downloadFrom(endpoint: education[indexPath.row].image ?? "")
            cell.info.text = education[indexPath.row].description
        cell.date.text = education[indexPath.row].date?.dateMonthYear()
        return cell
    }
    
    func setup() {
        self.educationTableView.delegate = self
        self.educationTableView.dataSource = self
        educationTableView.register(UINib(nibName: "EducationTableViewCell", bundle: nil), forCellReuseIdentifier: "educationCell")
        educationTableView.tableFooterView = UIView()
        educationTableView.allowsSelection = false
        self.educationTableView.addSubview(self.refreshControl)
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        rotationVerify()
    }
    
    func rotationVerify() {
        infoTxtLbl.scrollsToTop = true
        switch UIDevice.current.orientation{
        case .portrait, .portraitUpsideDown:
            generalStackView.axis = .vertical
            generalStackView.distribution = .fill
        case .landscapeLeft, .landscapeRight:
            generalStackView.axis = .horizontal
            generalStackView.distribution = .fillEqually
        default:
            break
        }
    }
    
    @objc func loadData(_ refreshControl: UIRefreshControl?) {
        Network.getExternalData(fileLocation: Endpoints.shared.me) { (event: Me?, error) in
            if let err = error {
                self.alert(message: err.localizedDescription, title: "Error")
            }
            if let me = event {
                if let edArray = me.education {
                    self.profileImage.downloadFrom(endpoint:  me.image)
                    self.infoTxtLbl.text = me.info
                    self.education = edArray
                    self.educationTableView.reloadData()
                }
                if let rf = refreshControl {
                    rf.endRefreshing()
                }
            }
        }
    }


}

