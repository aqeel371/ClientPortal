//
//  MenuTrainingVC.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 29/11/2023.
//

import UIKit

class MenuTrainingVC: UIViewController {

    var spinner :LoadingViewNib?
    var webinar = [TrainingDatum]()
    var technical = [TrainingDatum]()
    var market = [TrainingDatum]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getTraining()
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
        vc.trainData = webinar
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func technicalAction(_ sender: Any) {
        let vc = ViewControllers.TrainingDetailsVC.getViewController() as TrainingDetailsVC
        vc.type = .technical
        vc.trainData = technical
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func marketAction(_ sender: Any) {
        let vc = ViewControllers.TrainingDetailsVC.getViewController() as TrainingDetailsVC
        vc.type = .market
        vc.trainData = market
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func blogsAction(_ sender: Any) {
        
        let stringUrl = "https://www.godofx.com/blog"
        let webVC = WebViewController.loadFromNib()
        webVC.url = stringUrl
        webVC.modalPresentationStyle = .fullScreen
        self.present(webVC, animated: true)
        
    }
    
}


extension MenuTrainingVC{
    
    func getTraining(){
        spinner = self.showSpinner()
        
        ApiManager.shared.request(with: .getTrainingVideos, completion: {resp in
            
            switch resp{
            case .Success(let data):
                self.spinner?.removeFromSuperview()
                if let trainResp:TrainingVideosResponse = self.handleResponse(data: data as! Data){
                    if trainResp.status ?? false {
                        if let training = trainResp.result?.data{
                            self.filtreTrainingVideos(training: training)
                        }
                    }else{
                        self.showAlert(title: "Error", message: trainResp.message, actions: nil)
                    }
                }
            case .Failure(let error):
                self.spinner?.removeFromSuperview()
                self.handleError(error: error)
            }
            
        })
        
    }
 
    func filtreTrainingVideos(training:[TrainingDatum]){
        
        for train in training {
            if train.gallery == "Webinars"{
                webinar.append(train)
            }else if train.gallery == "MarketOverview"{
                market.append(train)
            }else{
                technical.append(train)
            }
        }
    }
    
    
}
