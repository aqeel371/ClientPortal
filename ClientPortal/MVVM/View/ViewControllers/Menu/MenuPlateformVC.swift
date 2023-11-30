//
//  MenuPlateformVC.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 30/11/2023.
//

import UIKit

class MenuPlateformVC: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var plateformCV: UICollectionView!
    
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
extension MenuPlateformVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func setupCV(){
        plateformCV.register(UINib(nibName: "PlateformCVC", bundle: nil), forCellWithReuseIdentifier: "PlateformCVC")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlateformCVC", for: indexPath) as! PlateformCVC
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cvWidth = collectionView.bounds.width
        let itemWidth = (cvWidth / 2) - 10
        let itemHeight = 190.0
        
        return CGSize(width: itemWidth, height: itemHeight)
    }

    
    
}
