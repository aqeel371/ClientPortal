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
    
    
    
    var platforms: [Plateforms] = []
    
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
        platforms.append(Plateforms(title: "MT5 PC",link: "https://download.mql5.com/cdn/web/godo.ltd/mt5/godo5setup.exe", btn: "Download"))
        platforms.append(Plateforms(title: "MT5 MAC",link: "https://download.mql5.com/cdn/mobile/mt5/ios?server=GoDo-Server", btn: "Download"))
        platforms.append(Plateforms(title: "Mt5 GoDo Trader",link: "https://godotrader.com", btn: "Go to Trade"))
        platforms.append(Plateforms(title: "MT5 Android",link: "https://download.mql5.com/cdn/mobile/mt5/android?server=GoDo-Server", btn: "Download"))
        
        platforms.append(Plateforms(title: "MT4 PC",link: "https://download.mql5.com/cdn/web/metaquotes.software.corp/mt4/mt4setup.exe", btn: "Download"))
        platforms.append(Plateforms(title: "MT4 MAC",link: "https://download.mql5.com/cdn/mobile/mt4/ios?server=GoDo-server", btn: "Download"))
        platforms.append(Plateforms(title: "MT4 GoDo Trader",link: "https://godotrader.com", btn: "Go to Trade"))
        platforms.append(Plateforms(title: "MT4 Android",link: "https://download.mql5.com/cdn/mobile/mt5/android?server=GoDo-Server", btn: "Download"))
        
        
        plateformCV.register(UINib(nibName: "PlateformCVC", bundle: nil), forCellWithReuseIdentifier: "PlateformCVC")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return platforms.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlateformCVC", for: indexPath) as! PlateformCVC
        cell.populate(p: platforms[indexPath.row])
        
        cell.downloadCallBack = {
            print(self.platforms[indexPath.row].link)
            
            let webVC = WebViewController.loadFromNib()
            webVC.url = self.platforms[indexPath.row].link
            webVC.modalPresentationStyle = .fullScreen
            self.present(webVC, animated: true)
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cvWidth = collectionView.bounds.width
        let itemWidth = (cvWidth / 2) - 10
        let itemHeight = 190.0
        
        return CGSize(width: itemWidth, height: itemHeight)
    }

    
    
}
