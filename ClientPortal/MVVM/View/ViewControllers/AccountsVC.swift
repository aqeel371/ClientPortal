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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCV()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        vcTitleLbl.text = titleVC + "Account"
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

//MARK: -  UIcollection VIew Methods
extension AccountsVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func setupCV(){
        accountCV.register(UINib(nibName: "AccountsCVC", bundle: nil), forCellWithReuseIdentifier: "AccountsCVC")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AccountsCVC", for: indexPath) as! AccountsCVC
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = 330.0
        
        return CGSize(width: width, height: height)
    }
    
}
