//
//  MenuTrainingVC.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 29/11/2023.
//

import UIKit

class MenuTrainingVC: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func profileAction(_ sender: Any) {
        let vc = ViewControllers.ProfileVC.getViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func webinarAction(_ sender: Any) {
        let vc = ViewControllers.TrainingDetailsVC.getViewController() as TrainingDetailsVC
        vc.type = .webinar
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func technicalAction(_ sender: Any) {
        let vc = ViewControllers.TrainingDetailsVC.getViewController() as TrainingDetailsVC
        vc.type = .technical
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func marketAction(_ sender: Any) {
        let vc = ViewControllers.TrainingDetailsVC.getViewController() as TrainingDetailsVC
        vc.type = .market
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func blogsAction(_ sender: Any) {
        
        var stringUrl = "https://www.godofx.com/blog"
        let webVC = WebViewController.loadFromNib()
        webVC.url = stringUrl
        webVC.modalPresentationStyle = .fullScreen
        self.present(webVC, animated: true)
        
    }
    
}
