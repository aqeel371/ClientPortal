//
//  TrainingDetailsVC.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 30/11/2023.
//

import UIKit
import WebKit

class TrainingDetailsVC: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var tfSearch: UITextField!
    @IBOutlet weak var trainingCV: UICollectionView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var webView: WKWebView!
    
    
    
    //MARK: - Varibles
    var type:TrainingType?
    var spinner :LoadingViewNib?
    var trainData = [TrainingDatum]()
    var technicalHtmlString = """

<div id="cincopa_274e27">...</div><script type="text/javascript">
var cpo = []; cpo["_object"] ="cincopa_274e27"; cpo["_fid"] = "AELAn3uBQw63";
var _cpmp = _cpmp || []; _cpmp.push(cpo);
(function() { var cp = document.createElement("script"); cp.type = "text/javascript";
cp.async = true; cp.src = "https://rtcdn.cincopa.com/libasync.js";
var c = document.getElementsByTagName("script")[0];
c.parentNode.insertBefore(cp, c); })(); </script>

"""
    var webinarHtmlString = """

<div id="cincopa_aeae52">...</div><script type="text/javascript">
var cpo = []; cpo["_object"] ="cincopa_aeae52"; cpo["_fid"] = "AoHAmB_7EymF";
var _cpmp = _cpmp || []; _cpmp.push(cpo);
(function() { var cp = document.createElement("script"); cp.type = "text/javascript";
cp.async = true; cp.src = "https://rtcdn.cincopa.com/libasync.js";
var c = document.getElementsByTagName("script")[0];
c.parentNode.insertBefore(cp, c); })(); </script>

"""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCV()
        webView.isHidden = true
        trainingCV.isHidden = false
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if type == .webinar{
            titleLbl.text = "Webinars"
            webView.loadHTMLString(webinarHtmlString,baseURL: nil)
        }else if type == .market{
            titleLbl.text = "Market Overview"
            webView.loadHTMLString(webinarHtmlString,baseURL: nil)
        }else if type == .technical{
            titleLbl.text = "Technical Analysis"
            webView.loadHTMLString(technicalHtmlString,baseURL: nil)
        }else if type == .blogs{
            titleLbl.text = "Blogs"
        }
    }
    
    //MARK: - IBActions
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func profileAction(_ sender: Any) {
        let vc = ViewControllers.ProfileVC.getViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

//MARK: - UIcollectionView Methods
extension TrainingDetailsVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func setupCV(){
        trainingCV.register(UINib(nibName: "TrainingCVC", bundle: nil), forCellWithReuseIdentifier: "TrainingCVC")
        
        if trainData.isEmpty{
            self.showNoDataMessage()
        }
        
//        getTraining()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trainData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrainingCVC", for: indexPath) as! TrainingCVC
        cell.config(train: trainData[indexPath.row])
        
        cell.playCallBack = {
            
            let webVC = WebViewController.loadFromNib()
            webVC.url = self.trainData[indexPath.row].url ?? ""
            webVC.modalPresentationStyle = .fullScreen
            self.present(webVC, animated: true)
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height = 175.0
        return CGSize(width: width, height: height)
    }
    
}


//MARK: API

extension TrainingDetailsVC{
    
    
    func getTraining(){
        spinner = self.showSpinner()
        
        ApiManager.shared.request(with: .getTrainingVideos, completion: {resp in
            
            switch resp{
            case .Success(let data):
                self.spinner?.removeFromSuperview()
                if let trainResp:TrainingVideosResponse = self.handleResponse(data: data as! Data){
                    if trainResp.status ?? false {
                        if let training = trainResp.result?.data{
                            self.trainData = training
//                            self.filtreTrainingVideos(training: training)
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
    
    
}
