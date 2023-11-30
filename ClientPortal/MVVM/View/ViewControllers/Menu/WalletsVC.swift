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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCV()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - IBActions
    @IBAction func backActio(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func profileAction(_ sender: Any) {
        let vc = ViewControllers.ProfileVC.getViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension WalletsVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func setupCV(){
        walletCV.register(UINib(nibName: "WalletCVC", bundle: nil), forCellWithReuseIdentifier: "WalletCVC")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WalletCVC", for: indexPath) as! WalletCVC
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height = 165.0
        return CGSize(width: width, height: height)
    }
    
}
