//
//  UserDocsVC.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 30/11/2023.
//

import UIKit

class UserDocsVC: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var incomView: UIViewX!
    @IBOutlet weak var bankView: UIViewX!
    @IBOutlet weak var additionalView: UIViewX!
    @IBOutlet weak var docsCV: UICollectionView!
    @IBOutlet weak var docsViewHeight: NSLayoutConstraint!
    
    //MARK: - Varibles
    var spinner:LoadingViewNib?
    var docs = [DocsDatum]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCV()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        incomView.isDottedBorder = true
        bankView.isDottedBorder = true
        additionalView.isDottedBorder = true
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    //MARK: - IBActions
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func profielView(_ sender: Any) {
        let vc = ViewControllers.ProfileVC.getViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func uploadIncomActio(_ sender: Any) {
    }
    
    @IBAction func uploadBankView(_ sender: Any) {
    }
    
    
    @IBAction func additonalAction(_ sender: Any) {
    }
    
    
    @IBAction func cancelAction(_ sender: Any) {
    }
    
    @IBAction func uploadAction(_ sender: Any) {
    }
    
}


//MARK: - UIcollection
extension UserDocsVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func setupCV(){
        docsCV.register(UINib(nibName: "DocumentsCVC", bundle: nil), forCellWithReuseIdentifier: "DocumentsCVC")
        getDocs()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return docs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DocumentsCVC", for: indexPath) as! DocumentsCVC
        cell.lblID.text = "\(indexPath.row + 1)"
        cell.populate(d: docs[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width , height: 145.0)
    }
    
}


//MARK: - API
extension UserDocsVC{
    
    func getDocs(){
        spinner = self.showSpinner()
        
        ApiManager.shared.request(with: .GetDocs, completion: {resp in
            
            switch resp{
            case .Success(let data):
                self.spinner?.removeFromSuperview()
                if let docsResp:DocumentsResponse = self.handleResponse(data: data as! Data){
                    if docsResp.status ?? false {
                        if let docs = docsResp.result?.data{
                            self.docs = docs
                            self.docsCV.reloadData()
                            let totalHeight = self.docsCV.collectionViewLayout.collectionViewContentSize.height
                            self.docsViewHeight.constant = totalHeight + 70
                        }
                    }else{
                        self.showAlert(title: "Error", message: docsResp.message, actions: nil)
                    }
                }
            case .Failure(let error):
                self.spinner?.removeFromSuperview()
                self.handleError(error: error)
            }
            
        })
        
    }
    
}
