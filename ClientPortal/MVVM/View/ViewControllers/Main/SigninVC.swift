//
//  SigninVC.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 28/11/2023.
//

import UIKit
import CBTabBarController
import FloatingPanel
import SwiftKeychainWrapper

class SigninVC: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var eyeIcon: UIImageView!
    
    //MARK: - Variables
    var eyeClick: Bool = true
    var spinner:LoadingViewNib?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        autoLogin()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        // Enable swipe to back
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: - IBActions
    
    @IBAction func forgetAction(_ sender: Any) {
        
        let appearance = SurfaceAppearance()
        let fpc = FloatingPanelController()
        let contectVC = ViewControllers.ForgetPassVC.getViewController() as ForgetPassVC
        fpc.set(contentViewController: contectVC)
        fpc.contentMode = .fitToBounds
        fpc.layout = ResetPassPanelLayout()
        fpc.isRemovalInteractionEnabled = true
        appearance.cornerRadius = 20.0
        fpc.surfaceView.appearance = appearance
        fpc.addPanel(toParent: self,animated: true)
    }
    
    @IBAction func sigininAction(_ sender: Any) {
        if let user = userNameTF.text, let pass = passwordTF.text{
            if user.isEmpty{
                self.showAlert(title: "Error", message: "Enter a Valid Username...", actions: nil)
                userNameTF.becomeFirstResponder()
            }else if pass.isEmpty || pass.count < 6{
                self.showAlert(title: "Error", message: "Enter a Valid Password...", actions: nil)
                passwordTF.becomeFirstResponder()
            }else{
                let user = LoginModel(email: user,password: pass)
                self.login(user: user)
                
            }
        }
    }
    
    @IBAction func signUpAction(_ sender: Any) {
        
    }
    
    @IBAction func eyeAction(_ sender: UIButton) {
        eyeClick = !eyeClick
        if eyeClick {
            passwordTF.isSecureTextEntry = true
            eyeIcon.image = UIImage(named: "ic_eyecross")
            
        } else {
            passwordTF.isSecureTextEntry = false
            eyeIcon.image = UIImage(named: "ic_eye")
        }
    }
    
    //MARK: - Session Retreive
    
    func autoLogin(){
        let retrievedString: String? = KeychainWrapper.standard.string(forKey: "myLogin")
        Global.shared.tokken = retrievedString ?? ""
        if retrievedString != nil{
            self.setupTabBar()
        }
    }
    
}

//MARK: FloatingPanelLayout

class ResetPassPanelLayout: FloatingPanelLayout {
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .full
    let anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] = [
        .full: FloatingPanelLayoutAnchor(absoluteInset: 320.0, edge: .bottom, referenceGuide: .safeArea),
        .half: FloatingPanelLayoutAnchor(absoluteInset: 320.0, edge: .bottom, referenceGuide: .safeArea),
        .tip: FloatingPanelLayoutAnchor(fractionalInset: 0.2, edge: .bottom, referenceGuide: .safeArea),
    ]
}


//MARK: Tabbar delagate
extension SigninVC:UITabBarControllerDelegate{
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if tabBarController.selectedIndex == 2 {
            
            let tradeView = TradeMTView.instanceFromNib()
            if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
                window.addSubview(tradeView)
                tradeView.frame = window.frame
            }
            tradeView.selectCallBack = {
                tabBarController.selectedIndex = 1
                
                let urlString = "https://godotrader.com/"
                let webVC = WebViewController.loadFromNib()
                webVC.url = urlString
                webVC.modalPresentationStyle = .fullScreen
                self.present(webVC, animated: true)
            }
            
            tradeView.dismissCallBack = {
                tabBarController.selectedIndex = 1
            }
        }
    }
    
    
}

//MARK: - TabBar
extension SigninVC{
    func setupTabBar(){
        let tabBarController = createSampleTabController()
        let menuEntries = ["Deposit", "Withdrawal", "Internal Transfer"]
        var menu = CBTabMenu(menuButtonIndex: 2,
                             menuColor: .ColorPrimary,
                             items: menuEntries,
                             icon: nil,
                             callback: { controller, item in
                                controller.dismiss(animated: true, completion: {
                                    print("\(item) selected")
                                    let vc = ViewControllers.InternalTabsVC.getViewController() as InternalTabsVC
                                    if item.title == menuEntries[0]{
//                                        vc.typeVc = .deposit
                                        let vc = ViewControllers.DepositVC.getViewController()
                                        self.navigationController?.pushViewController(vc, animated: true)
                                    }else if item.title == menuEntries[1]{
                                        vc.typeVc = .withdraw
                                        self.navigationController?.pushViewController(vc, animated: true)
                                    }else{
                                        vc.typeVc = .transfer
                                        self.navigationController?.pushViewController(vc, animated: true)
                                    }
                                    
                                })
        })
        menu.icon = UIImage(named: "ic_g")
        tabBarController.style = .gooey(menu: menu)
        tabBarController.delegate = self
        tabBarController.selectedIndex = 1
        tabBarController.modalPresentationStyle = .fullScreen
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            self.navigationController?.pushViewController(tabBarController, animated: true)
        })
    }
    
    func createSampleTabController() -> CBTabBarController {
        let dashboardVc = getVc(vc: "DashboardViewController")
        dashboardVc.tabBarItem = UITabBarItem(title: "", image: UIImage(named: ""), tag: 0)
        let transcationVc = getVc(vc: "TranscationViewController")
        transcationVc.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "ic_transcation"), tag: 0)
        let menuVC = getVc(vc: "MenuVC")
        menuVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "ic_dashboard"), tag: 0)
        
        let tabBarController = CBTabBarController()
        tabBarController.viewControllers = [menuVC, dashboardVc, transcationVc]
        (tabBarController.tabBar as? CBTabBar)?.tabbarBackground = .ColorPrimary
        tabBarController.tabBar.tintColor = .white
        return tabBarController
    }
    
}

//MARK: -  API
extension SigninVC{
    
    func login(user:LoginModel){
        
        spinner = self.showSpinner()
        
        ApiManager.shared.request(with: .Login(params: user.dictionary as [String:AnyObject]?), completion: {resp in
            
            switch resp{
            case .Success(let data):
                if let loginResp:LoginResponse = self.handleResponse(data: data as! Data){
                    self.spinner?.removeFromSuperview()
                    if loginResp.status ?? false {
                        Global.shared.tokken = loginResp.result?.token ?? ""
                        
                        if let token = Global.shared.tokken{
                            let saveSuccessful: Bool = KeychainWrapper.standard.set(token, forKey: "myLogin")
                            UserDefaults.standard.set(saveSuccessful, forKey: "isLoggedIn")
                        }
                        
                        self.setupTabBar()
                    }else{
                        self.showAlert(title: "Error", message: loginResp.message, actions: nil)
                    }
                    
                }
            case .Failure(let error):
                self.spinner?.removeFromSuperview()
                self.handleError(error: error)
            }
            
        })
        
        
    }
    
}
