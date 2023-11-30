//
//  ReportsVC.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 30/11/2023.
//

import UIKit

class ReportsVC: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var reportsCV: UICollectionView!
    
    
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
extension ReportsVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func setupCV(){
        reportsCV.register(UINib(nibName: "ReportsCVC", bundle: nil), forCellWithReuseIdentifier: "ReportsCVC")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReportsCVC", for: indexPath) as! ReportsCVC
        if indexPath.row % 2 == 0 {
            cell.config(status: true)
        } else {
            cell.config(status: false)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height = 180.0
        return CGSize(width: width, height: height)
    }
    
}
