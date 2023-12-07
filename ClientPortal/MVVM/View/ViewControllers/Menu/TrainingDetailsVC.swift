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
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrainingCVC", for: indexPath) as! TrainingCVC
        if indexPath.row % 2 == 0 {
            cell.videoImage.image = UIImage(named: "ic_train1")
        } else {
            cell.videoImage.image = UIImage(named: "ic_train2")
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height = 175.0
        return CGSize(width: width, height: height)
    }
    
}
