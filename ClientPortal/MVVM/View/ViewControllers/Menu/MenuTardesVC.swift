//
//  MenuTardesVC.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 29/11/2023.
//

import UIKit

class MenuTardesVC: UIViewController {

    @IBOutlet weak var tradesCV: UICollectionView!
    
    //MARK: - Varibales
    var spinner :LoadingViewNib?
    var accounts = [AccountsDatum]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCV()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - IBAction
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func profileAction(_ sender: Any) {
        let vc = ViewControllers.ProfileVC.getViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


//MARK: - UIcollection Methods
extension MenuTardesVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func setupCV(){
        tradesCV.register(UINib(nibName: "TradesCVC", bundle: nil), forCellWithReuseIdentifier: "TradesCVC")
        getAccounts()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return accounts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TradesCVC", for: indexPath) as! TradesCVC
        cell.populate(data: accounts[indexPath.row])
        cell.viewCallBack = {
            let vc = ViewControllers.TradeDetailsVC.getViewController() as TradeDetailsVC
            vc.account = self.accounts[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = 180.0
        return CGSize(width: width, height: height)
    }
    
    
}


//MARK: - API
extension MenuTardesVC{
    
    func getAccounts(){
        spinner = self.showSpinner()
        ApiManager.shared.request(with: .Accounts, completion: {resp in
            
            switch resp{
            case .Success(let data):
                self.spinner?.removeFromSuperview()
                if let accResp:AccountsResponse = self.handleResponse(data: data as! Data){
                    if accResp.status ?? false {
                        if let accounts = accResp.result?.data{
                            self.accounts = accounts
                            self.tradesCV.reloadData()
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
