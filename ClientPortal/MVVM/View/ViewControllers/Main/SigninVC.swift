//
//  SigninVC.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 28/11/2023.
//

import UIKit
import CBTabBarController
import FloatingPanel

class SigninVC: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var eyeIcon: UIImageView!
    
    //MARK: - Variables
    var eyeClick: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
                                        vc.typeVc = .deposit
                                    }else if item.title == menuEntries[1]{
                                        vc.typeVc = .withdraw
                                    }else{
                                        vc.typeVc = .transfer
                                    }
                                    self.navigationController?.pushViewController(vc, animated: true)
                                })
        })
        menu.icon = UIImage(named: "ic_g")
        tabBarController.style = .gooey(menu: menu)
        tabBarController.modalPresentationStyle = .fullScreen
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            self.navigationController?.pushViewController(tabBarController, animated: true)
        })
        
    }
    
    func createSampleTabController() -> CBTabBarController {
        let dashboardVc = getVc(vc: "DashboardViewController")
        dashboardVc.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "ic_dashboard"), tag: 0)
        let transcationVc = getVc(vc: "TranscationViewController")
        transcationVc.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "ic_transcation"), tag: 0)
        let dashboardVc1 = getVc(vc: "DashboardViewController")
        dashboardVc1.tabBarItem = UITabBarItem(title: "", image: UIImage(named: ""), tag: 0)
        
        let tabBarController = CBTabBarController()
        tabBarController.viewControllers = [dashboardVc, dashboardVc1, transcationVc]
        (tabBarController.tabBar as? CBTabBar)?.tabbarBackground = .ColorPrimary
        tabBarController.tabBar.tintColor = .white
        return tabBarController
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
