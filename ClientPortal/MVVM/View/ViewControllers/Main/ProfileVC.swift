//
//  ProfileVC.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 29/11/2023.
//

import UIKit
import FloatingPanel

class ProfileVC: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var tfFName: UITextField!
    @IBOutlet weak var tfLName: UITextField!
    @IBOutlet weak var tfPhoneNum: UITextField!
    @IBOutlet weak var tfCountry: UITextField!
    @IBOutlet weak var tfAddress: UITextField!
    
    //MARK: - Variables
    var spinner:LoadingViewNib?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        // Enable swipe to back
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isHidden = true
        
        getProfile()
    }
    
    //MARK: - IBActions
    
    
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func changePassAction(_ sender: Any) {
        let appearance = SurfaceAppearance()
        let fpc = FloatingPanelController()
        let contectVC = ViewControllers.ProfileChangePassVC.getViewController() as ProfileChangePassVC
        fpc.set(contentViewController: contectVC)
        fpc.contentMode = .fitToBounds
        fpc.layout = ChangePassPanelLayout()
        fpc.isRemovalInteractionEnabled = true
        appearance.cornerRadius = 20.0
        fpc.surfaceView.appearance = appearance
        fpc.addPanel(toParent: self,animated: true)
    }
    
    @IBAction func supportAction(_ sender: Any) {
        //        let vc = ViewControllers.SupportVC.getViewController() as SupportVC
        //        self.navigationController?.pushViewController(vc, animated: true)
        let appURL = URL(string: "https://wa.me/+971545299299?text=Hello%20there,%20I%20have%20a%20query.")!
        if UIApplication.shared.canOpenURL(appURL) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
            }
            else {
                UIApplication.shared.openURL(appURL)
            }
        }
        
    }
}

//MARK: FloatingPanelLayout

class ChangePassPanelLayout: FloatingPanelLayout {
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .full
    let anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] = [
        .full: FloatingPanelLayoutAnchor(absoluteInset: 350.0, edge: .bottom, referenceGuide: .safeArea),
        .half: FloatingPanelLayoutAnchor(absoluteInset: 350.0, edge: .bottom, referenceGuide: .safeArea),
        .tip: FloatingPanelLayoutAnchor(fractionalInset: 0.2, edge: .bottom, referenceGuide: .safeArea),
    ]
}


//MARK: - API
extension ProfileVC{
    
    func getProfile(){
        spinner = self.showSpinner()
        ApiManager.shared.request(with: .Profile, completion: {resp in
            
            switch resp{
            case .Success(let data):
                if let profileResp:ProfileResponse = self.handleResponse(data: data as! Data){
                    self.spinner?.removeFromSuperview()
                    if profileResp.status ?? false {
                        if let user = profileResp.result{
                            self.handleUser(user: user)
                        }
                    }else{
                        self.showAlert(title: "Error", message: profileResp.message, actions: nil)
                    }
                }
            case .Failure(let error):
                self.spinner?.removeFromSuperview()
                self.handleError(error: error)
            }
        })
    }
    
    func handleUser(user:ProfileResult){
        
        tfFName.text = user.firstName ?? ""
        tfLName.text = user.lastName ?? ""
        tfPhoneNum.text = user.phone ?? ""
        tfCountry.text = (user.country ?? "") + " - " + (user.city ?? "")
        tfAddress.text = user.address ?? ""
        
    }
    
}
