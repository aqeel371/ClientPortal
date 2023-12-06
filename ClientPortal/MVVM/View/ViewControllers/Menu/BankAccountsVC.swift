//
//  BankAccountsVC.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 30/11/2023.
//

import UIKit

class BankAccountsVC: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var bankCV: UICollectionView!
    
    var spinner:LoadingViewNib?
    var banks = [BankDatum]()
    
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

//MARK: - UICollection VIew Methods
extension BankAccountsVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func setupCV(){
        bankCV.register(UINib(nibName: "BanksCVC", bundle: nil), forCellWithReuseIdentifier: "BanksCVC")
        getBanks()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return banks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BanksCVC", for: indexPath) as! BanksCVC
        cell.lblID.text = "\(indexPath.row + 1)"
        cell.populate(bank: banks[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height = 280.0
        return CGSize(width: width, height: height)
    }
    
}


//MARK: - API
extension BankAccountsVC{
    
    func getBanks(){
     
        spinner = self.showSpinner()
        ApiManager.shared.request(with: .GetBanks, completion: {resp in
            
            switch resp{
            case .Success(let data):
                self.spinner?.removeFromSuperview()
                if let bankResp:BanksResponse = self.handleResponse(data: data as! Data){
                    if bankResp.status ?? false {
                        if let banks = bankResp.result?.data{
                            self.banks = banks
                            self.bankCV.reloadData()
                        }
                    }else{
                        self.showAlert(title: "Error", message: bankResp.message, actions: nil)
                    }
                }
            case .Failure(let error):
                self.spinner?.removeFromSuperview()
                self.handleError(error: error)
            }
            
        })
        
    }
    
}
