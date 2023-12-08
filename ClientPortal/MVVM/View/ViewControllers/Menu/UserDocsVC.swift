//
//  UserDocsVC.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 30/11/2023.
//

import UIKit
import FloatingPanel

class UserDocsVC: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var identityVIew: UIViewX!
    @IBOutlet weak var lblIdentity: UILabel!
    @IBOutlet weak var incomView: UIViewX!
    @IBOutlet weak var lblIncome: UILabel!
    @IBOutlet weak var addressView: UIViewX!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var additionalView: UIViewX!
    @IBOutlet weak var lblAddition: UILabel!
    @IBOutlet weak var docsCV: UICollectionView!
    @IBOutlet weak var docsViewHeight: NSLayoutConstraint!
    
    //MARK: - Varibles
    var spinner:LoadingViewNib?
    var docs = [DocsDatum]()
    var selectedDocs = UploadDocs()
    var docsData: [String : Data] = [:]
    var typeDoc:DocType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCV()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        incomView.isDottedBorder = true
        addressView.isDottedBorder = true
        identityVIew.isDottedBorder = true
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
    
    @IBAction func uploadIdentityAction(_ sender: Any) {
        let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.item"], in: .import)
        documentPicker.delegate = self
        self.typeDoc = .identity
        present(documentPicker, animated: true, completion: nil)
    }
    
    @IBAction func uploadAddressAction(_ sender: Any) {
        let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.item"], in: .import)
        documentPicker.delegate = self
        self.typeDoc = .address
        present(documentPicker, animated: true, completion: nil)
    }
    
    @IBAction func uploadBankView(_ sender: Any) {
        let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.item"], in: .import)
        documentPicker.delegate = self
        self.typeDoc = .incom
        present(documentPicker, animated: true, completion: nil)
    }
    
    
    @IBAction func additonalAction(_ sender: Any) {
        let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.item"], in: .import)
        documentPicker.delegate = self
        self.typeDoc = .additional
        present(documentPicker, animated: true, completion: nil)
    }
    
    
    @IBAction func cancelAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func uploadAction(_ sender: Any) {
        uploadDocs()
    }
    
    @IBAction func infoAction(_ sender: Any) {
        let appearance = SurfaceAppearance()
        let fpc = FloatingPanelController()
        let contectVC = ViewControllers.DocsInfoVC.getViewController() as DocsInfoVC
        fpc.set(contentViewController: contectVC)
        fpc.contentMode = .fitToBounds
//        fpc.layout = ResetPassPanelLayout()
        fpc.isRemovalInteractionEnabled = true
        appearance.cornerRadius = 20.0
        fpc.surfaceView.appearance = appearance
        fpc.addPanel(toParent: self,animated: true)
        
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

//MARK: Document Deleagte
extension UserDocsVC:UIDocumentPickerDelegate{
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        
        guard let fileUrl = urls.first else {
            print("No file selected.")
            return
        }
        
        let fileName = fileUrl.lastPathComponent
        do {
            let fileData = try Data(contentsOf: fileUrl)
            self.handleFileURL(name: fileName, fileData: fileData)
        } catch {
            print("Error reading file data: \(error)")
        }
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        // Handle cancellation
        print("Document picker was cancelled")
    }
    
    func handleFileURL(name:String,fileData:Data){
        
        if typeDoc == .identity{
            lblIdentity.text = name
            self.selectedDocs.PROOF_OF_ID = fileData
            docsData["PROOF_OF_ID"] = fileData
        }else if typeDoc == .incom{
            lblIncome.text = name
            self.selectedDocs.SOURCE_OF_INCOME = fileData
            docsData["SOURCE_OF_INCOME"] = fileData
        }else if typeDoc == .address{
            lblAddress.text = name
            self.selectedDocs.PROOF_OF_ADDRESS = fileData
            docsData["PROOF_OF_ADDRESS"] = fileData
        }else{
            lblAddition.text = name
            self.selectedDocs.ADDITIONAL = fileData
            docsData["ADDITIONAL"] = fileData
        }
        
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
    
    func uploadDocs(){
        spinner = self.showSpinner()
        
        ApiManager.shared.request(with: .AddDocs,isMultipart: true,fileArray: docsData, completion: {resp in
            
            switch resp{
            case .Success(let data):
                self.spinner?.removeFromSuperview()
                if let docsResp:UploadDocsResponse = self.handleResponse(data: data as! Data){
                    if docsResp.status ?? false {
                        self.docsData = [:]
                        self.lblIncome.text = "Upload File"
                        self.lblIdentity.text = "Upload File"
                        self.lblAddress.text = "Upload File"
                        self.lblAddition.text = "Upload File"
                        self.getDocs()
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
