//
//  TradeDetailsVC.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 30/11/2023.
//

import UIKit

class TradeDetailsVC: UIViewController {

    @IBOutlet weak var positionsCV: UICollectionView!
    
    
    //MARK: - Varibles
    var account:AccountsDatum?
    var spinner:LoadingViewNib?
    var openData = [OpenPositionDatum]()
    var closeData = [ClosePositionDatum]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCV()
    }
    

    //MARK: - IBAction
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func profileACTION(_ sender: Any) {
        let vc = ViewControllers.ProfileVC.getViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

//MARK: UicollectionView
extension TradeDetailsVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func setupCV(){
        positionsCV.register(UINib(nibName: "TradesDetailCVC", bundle: nil), forCellWithReuseIdentifier: "TradesDetailCVC")
        positionsCV.register(UINib(nibName: "PositionHeaderCRV", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "PositionHeaderCRV")
        positionsCV.collectionViewLayout = UICollectionViewFlowLayout()
        (positionsCV.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionHeadersPinToVisibleBounds = true
        openTrades(acc: account?.id ?? 0)
        
        self.showNoData()

    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return openData.count
        }else{
            return closeData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TradesDetailCVC", for: indexPath) as! TradesDetailCVC
            cell.type = "Open Position "
            cell.populateOpen(data: openData[indexPath.row])
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TradesDetailCVC", for: indexPath) as! TradesDetailCVC
            cell.type = "Close Position "
            cell.populateClose(data: closeData[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "PositionHeaderCRV", for: indexPath) as! PositionHeaderCRV
            if indexPath.section == 0{
                headerView.titleLbl.text = "Open Position"
            }else{
                headerView.titleLbl.text = "Close Position"
            }
            
            return headerView
        }else {
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height = 375.0
        
        return CGSize(width: width, height: height)
    }
    
    
}

//MARK: - API

extension TradeDetailsVC{
    
    func openTrades(acc:Int){
        spinner = self.showSpinner()
        ApiManager.shared.request(with: .AccountOpenPosition(id: acc), completion: {resp in
            
            switch resp{
            case .Success(let data):
                self.spinner?.removeFromSuperview()
                if let posResp:OpenPositionResponse = self.handleResponse(data: data as! Data){
                    if posResp.status ?? false {
                        if let positions = posResp.result?.data{
                            self.openData = positions
                            self.positionsCV.reloadData()
                            self.closeTrades(acc: acc)
                        }
                    }else{
                        self.showAlert(title: "Error", message: posResp.message, actions: nil)
                    }
                }
            case .Failure(let error):
                self.spinner?.removeFromSuperview()
                self.handleError(error: error)
            }
            
        })
    }
    
    func closeTrades(acc:Int){
        spinner = self.showSpinner()
        ApiManager.shared.request(with: .AccountClosePosition(id: acc), completion: {resp in
            
            switch resp{
            case .Success(let data):
                self.spinner?.removeFromSuperview()
                if let posResp:ClosePositionResponse = self.handleResponse(data: data as! Data){
                    if posResp.status ?? false {
                        if let positions = posResp.result?.data{
                            self.closeData = positions
                            self.showNoData()
                            self.positionsCV.reloadData()
                        }
                    }else{
                        self.showAlert(title: "Error", message: posResp.message, actions: nil)
                    }
                }
            case .Failure(let error):
                self.spinner?.removeFromSuperview()
                self.handleError(error: error)
            }
            
        })
    }
    
    func showNoData(){
        if openData.isEmpty || closeData.isEmpty{
            self.showNoDataMessage()
            positionsCV.isHidden = true
        }else{
            positionsCV.isHidden = false
        }
    }
    
}

