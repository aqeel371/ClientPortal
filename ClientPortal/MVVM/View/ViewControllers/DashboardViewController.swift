//
//  DashboardViewController.swift
//  ClientPortal
//
//  Created by Muhammad  Aqeel on 27/11/2023.
//

import UIKit

class DashboardViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var offerCV: UICollectionView!
    @IBOutlet weak var dashboardTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCV()
        setupTV()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

//MARK: - UICollection VIew Methods
extension DashboardViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func setupCV(){
        offerCV.register(UINib(nibName: "OfferCVC", bundle: nil), forCellWithReuseIdentifier: "OfferCVC")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OfferCVC", for: indexPath) as! OfferCVC
        return cell
    }
    
    
}

//MARK: - UITableView Methods
extension DashboardViewController:UITableViewDelegate,UITableViewDataSource{
    
    func setupTV(){
        dashboardTV.register(UINib(nibName: "DashboardTVC", bundle: nil), forCellReuseIdentifier: "DashboardTVC")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardTVC", for: indexPath) as! DashboardTVC
        
        if indexPath.row % 2 == 0 {
            cell.cellView.backgroundColor = UIColor.white
        } else {
            cell.cellView.backgroundColor = UIColor.GhostWhite
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ViewControllers.AccountsVC.getViewController() as AccountsVC
        vc.titleVC = "Live"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = DashboradTVHeader.instanceFromNib()
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}
