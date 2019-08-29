//
//  ProjectsViewController.swift
//  Resume
//
//  Created by Miguel Fernando Cuellar Gauna on 8/28/19.
//  Copyright © 2019 Miguel Fernando Cuellar Gauna. All rights reserved.
//

import UIKit

class ProjectsViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var projectsScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    var projects = [ProjectsView]()
    override func viewDidLoad() {
        super.viewDidLoad()
        projectsScrollView.delegate = self
        loadData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupSlideScrollView(ProjectsViewSlides: self.projects)
    }
    
    func loadData() {
        Network.getExternalData(fileLocation: Endpoints.shared.personal) { (event: Personal?, error) in
            if let err = error {
                self.alert(message: err.localizedDescription, title: "Error")
            }
            if let personal = event {
               print(personal)
                if let projects = personal.projects {
                    var projectsArr = [ProjectsView]()
                    for project in projects {
                        let projectSlide:ProjectsView = Bundle.main.loadNibNamed("ProjectsView", owner: self, options: nil)?.first as! ProjectsView
                        projectSlide.descriptionLbl.text = project.description
                        projectSlide.jobTitleLbl.text = project.title
                        projectSlide.projectImg.downloadFrom(endpoint: project.image ?? "")
                        projectsArr.append(projectSlide)
                        
                    }
                    self.projects = projectsArr
                    self.setupSlideScrollView(ProjectsViewSlides: self.projects)
                    
                    self.pageControl.numberOfPages = projects.count
                    self.pageControl.currentPage = 0
                    self.view.bringSubviewToFront(self.pageControl)
                }
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        projectsScrollView.scrollsToTop = true
        pageControl.currentPage = Int(pageIndex)
        
    }
    
    func setupSlideScrollView(ProjectsViewSlides : [ProjectsView]) {
        projectsScrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: projectsScrollView.frame.height)
        projectsScrollView.contentSize = CGSize(width: view.frame.width * CGFloat(ProjectsViewSlides.count), height: projectsScrollView.frame.height)
        projectsScrollView.isPagingEnabled = true
        
        for i in 0 ..< ProjectsViewSlides.count {
            ProjectsViewSlides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: projectsScrollView.frame.height)
            ProjectsViewSlides[i].generalStackView.axis = getAxis()
            projectsScrollView.addSubview(ProjectsViewSlides[i])
        }
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        setupSlideScrollView(ProjectsViewSlides: self.projects)
    }
    
    
    func getAxis() -> NSLayoutConstraint.Axis {
        switch UIDevice.current.orientation{
        case .portrait, .portraitUpsideDown:
            return .vertical
        case .landscapeLeft, .landscapeRight:
            return .horizontal
        default:
            return .vertical
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
