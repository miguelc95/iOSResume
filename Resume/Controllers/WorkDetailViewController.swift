//
//  WorkDetailViewController.swift
//  Resume
//
//  Created by Miguel Fernando Cuellar Gauna on 8/27/19.
//  Copyright © 2019 Miguel Fernando Cuellar Gauna. All rights reserved.
//

import UIKit

class WorkDetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    

    @IBOutlet weak var generalStackView: UIStackView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var logoImgView: UIImageView!
    @IBOutlet weak var logoCollectionView: UICollectionView!
    
    var job = Job()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        descriptionLbl.text = job.description
        logoImgView.downloadFrom(endpoint: job.logo ?? "")
        logoCollectionView.delegate = self
        logoCollectionView.dataSource = self
        logoCollectionView.register(UINib.init(nibName: "WorkCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "workCell")

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        rotationVerify()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let technologies = job.technologies {
            return technologies.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "workCell", for: indexPath) as! WorkCollectionViewCell
        if let technologies = job.technologies {
            cell.imageView.downloadFrom(endpoint: technologies[indexPath.row].image ?? "")
            cell.labelView.isHidden = true
        }
        return cell
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        rotationVerify()
    }
    
    func rotationVerify() {
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
