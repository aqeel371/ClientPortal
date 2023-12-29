//
//  UserLogsVC.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 30/11/2023.
//

import UIKit

class UserLogsVC: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var logsCV: UICollectionView!
    
    var spinner :LoadingViewNib?
    var logs = [LogsDatum]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCV()
        // Do any additional setup after loading the view.
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

//MARK: - UICollectionView Methods
extension UserLogsVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func setupCV(){
        logsCV.register(UINib(nibName: "LogsCVC", bundle: nil), forCellWithReuseIdentifier: "LogsCVC")
        getLogs()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return logs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LogsCVC", for: indexPath) as! LogsCVC
        cell.populate(log: logs[indexPath.row])
        
        cell.viewCallBack = {
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height = 145.0
        return CGSize(width: width, height: height)
    }
    
}


//MARK: - API
extension UserLogsVC{
    
    func getLogs(){
        spinner = self.showSpinner()
        
        ApiManager.shared.request(with: .GetLogs, completion: {resp in
            
            switch resp{
            case .Success(let data):
                self.spinner?.removeFromSuperview()
                if let logResp:LogsResponse = self.handleResponse(data: data as! Data){
                    if logResp.status ?? false {
                        if let logs = logResp.result?.data{
                            if logs.isEmpty{
                                self.showNoDataMessage()
                            }else{
                                self.logs = logs
                                self.logsCV.reloadData()
                            }
                        }
                    }else{
                        self.showAlert(title: "Error", message: logResp.message, actions: nil)
                    }
                }
            case .Failure(let error):
                self.spinner?.removeFromSuperview()
                self.handleError(error: error)
            }
            
        })
        
    }
    
}
