//
//  AccountsVC.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 28/11/2023.
//

import UIKit

class AccountsVC: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var accountCV: UICollectionView!
    @IBOutlet weak var vcTitleLbl: UILabel!
    //MARK: - Variables
    var titleVC = ""
    var accounts = [AccountsDatum]()
    var accType = [AccTypeDatum]()
    var spinner:LoadingViewNib?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCV()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        vcTitleLbl.text = titleVC + " Accounts"
        // Enable swipe to back
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isHidden = true
//        getAccounts()
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func profileAction(_ sender: Any) {
        let vc = ViewControllers.ProfileVC.getViewController() as ProfileVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func createAction(_ sender: Any) {
        let vc = ViewControllers.AddAccountVC.getViewController() as AddAccountVC
        vc.accTypes = self.accType
        vc.titleVC = self.titleVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

//MARK: -  UIcollection VIew Methods
extension AccountsVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func setupCV(){
        accountCV.register(UINib(nibName: "AccountsCVC", bundle: nil), forCellWithReuseIdentifier: "AccountsCVC")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return accounts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AccountsCVC", for: indexPath) as! AccountsCVC
        cell.populate(data: accounts[indexPath.row])
        cell.fundCallBack = {
            let vc = ViewControllers.DepositVC.getViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = 330.0
        
        return CGSize(width: width, height: height)
    }
    
}


//MARK: - API
extension AccountsVC{
    
    func getAccounts(){
        spinner = self.showSpinner()
        ApiManager.shared.request(with: .Accounts, completion: {resp in
            
            switch resp{
            case .Success(let data):
                self.spinner?.removeFromSuperview()
                if let accResp:AccountsResponse = self.handleResponse(data: data as! Data){
                    if accResp.status ?? false {
                        if let accounts = accResp.result?.data{
                            for acc in accounts{
                                if acc.type == "LIVE" && self.titleVC == "Live"{
                                    self.accounts.append(acc)
                                }else{
                                    self.accounts.append(acc)
                                }
                            }
                        }
                    }else{
                        self.showAlert(title: "Error", message: accResp.message, actions: nil)
                    }
                }
            case .Failure(let error):
                self.spinner?.removeFromSuperview()
                self.handleError(error: error)
            }
            
        })
        
    }
    
}
