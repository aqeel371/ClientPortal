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
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BanksCVC", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height = 280.0
        return CGSize(width: width, height: height)
    }
    
}
