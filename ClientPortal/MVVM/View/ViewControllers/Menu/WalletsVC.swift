//
//  WalletsVC.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 30/11/2023.
//

import UIKit

class WalletsVC: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var walletCV: UICollectionView!
    
    @IBOutlet weak var addBtn: UIButtonX!
    
    @IBOutlet weak var btnHeight: NSLayoutConstraint!
    
    var spinner:LoadingViewNib?
    var wallets = [WalletDatum]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCV()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        getWallets()
    }
    
    //MARK: - IBActions
    @IBAction func backActio(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func profileAction(_ sender: Any) {
        let vc = ViewControllers.ProfileVC.getViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func addWalletAction(_ sender: Any) {
        let vc = ViewControllers.AddWalletVC.getViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension WalletsVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func setupCV(){
        walletCV.register(UINib(nibName: "WalletCVC", bundle: nil), forCellWithReuseIdentifier: "WalletCVC")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wallets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WalletCVC", for: indexPath) as! WalletCVC
        cell.lblID.text = "\(indexPath.row + 1)"
        cell.populate(w: wallets[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height = 165.0
        return CGSize(width: width, height: height)
    }
    
}


//MARK: - API
extension WalletsVC{
    
    func getWallets(){
     
        spinner = self.showSpinner()
        ApiManager.shared.request(with: .GetWallets, completion: {resp in
            
            switch resp{
            case .Success(let data):
                self.spinner?.removeFromSuperview()
                if let walletResp:WalletsResponse = self.handleResponse(data: data as! Data){
                    if walletResp.status ?? false {
                        if let wallets = walletResp.result?.data{
                            if wallets.isEmpty{
                                self.btnHeight.constant = 40
                                self.addBtn.isHidden = false
                                self.showNoDataMessage()
                            }else{
                                self.btnHeight.constant = 0
                                self.addBtn.isHidden = true
                                self.wallets = wallets
                                self.walletCV.reloadData()
                            }
                        }
                    }else{
                        self.showAlert(title: "Error", message: walletResp.message, actions: nil)
                    }
                }
            case .Failure(let error):
                self.spinner?.removeFromSuperview()
                self.handleError(error: error)
            }
            
        })
        
    }
    
}
