//
//  CryptoWireVC.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 29/11/2023.
//

import UIKit

class CryptoWireVC: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var banksTV: UITableView!
    @IBOutlet weak var lblTitleVC: UILabel!
    @IBOutlet weak var innerView: UIView!
    
    //MARK: - Variables
    var vcType:TransferType?
    var liveAccount = [AccountsDatum]()
    var gateway = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTV()
    }

    override func viewWillAppear(_ animated: Bool) {
        handleInnerViews()
    }
    
    //MARK: - IBActions
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func profileAction(_ sender: Any) {
        let vc = ViewControllers.ProfileVC.getViewController() as ProfileVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - UItableView methods
extension CryptoWireVC:UITableViewDelegate,UITableViewDataSource{
    
    func setupTV(){
        banksTV.register(UINib(nibName: "TransferTVC", bundle: nil), forCellReuseIdentifier: "TransferTVC")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if vcType == .Crypto{
            return 5
        }else if vcType == .Wire{
            return 7
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransferTVC", for: indexPath) as! TransferTVC
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if vcType == .Wire{
            let vc = ViewControllers.WireTransferDetailsVC.getViewController() as WireTransferDetailsVC
            self.navigationController?.pushViewController(vc, animated: true)
        }else if vcType == .Crypto{
            let vc = ViewControllers.CryptoDetailsVC.getViewController() as CryptoDetailsVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

//MARK: - HandleViews
extension CryptoWireVC{
    
    func handleInnerViews(){
        switch vcType{
        case .Wire:
            lblTitleVC.text = "Wire Transfer"
            gateway = "wireTransfer"
            innerView.isHidden = true
            banksTV.isHidden = false
        case .Crypto:
            lblTitleVC.text = "Crypto"
            gateway = "crypto"
            innerView.isHidden = true
            banksTV.isHidden = false
        case .Instant:
            lblTitleVC.text = "Instant Transfer"
            gateway = "stripe"
            innerView.isHidden = false
            banksTV.isHidden = true
            self.embedInstant()
        case .PerfectMoney:
            lblTitleVC.text = "Perfect Money"
            gateway = "perfectmoney"
            innerView.isHidden = false
            banksTV.isHidden = true
            self.embedPerfectMoney()
        case .Stick:
            lblTitleVC.text = "Stick"
            gateway = "sticpay"
            innerView.isHidden = false
            banksTV.isHidden = true
            self.embedStick()
        case .Skrill:
            lblTitleVC.text = "Skrill"
            gateway = "skrill"
            innerView.isHidden = false
            banksTV.isHidden = true
            self.embedSkrill()
        default:
            lblTitleVC.text = "Crypto"
            gateway = "crypto"
            innerView.isHidden = false
            banksTV.isHidden = true
        }
    }
    
    func embedInstant(){
        let vc = ViewControllers.InstantTransferVC.getViewController() as InstantTransferVC
        vc.accountTypes = self.liveAccount
        vc.gateway = self.gateway
        self.embed(vc, inView: innerView)
    }
    func embedPerfectMoney(){
        let vc = ViewControllers.PerfectMoneyVC.getViewController() as PerfectMoneyVC
        vc.accountTypes = self.liveAccount
        vc.gateway = self.gateway
        self.embed(vc, inView: innerView)
    }
    func embedStick(){
        let vc = ViewControllers.StickSkrillVC.getViewController() as StickSkrillVC
        vc.accountTypes = self.liveAccount
        vc.gateway = self.gateway
        vc.type = .Stick
        self.embed(vc, inView: innerView)
    }
    func embedSkrill(){
        let vc = ViewControllers.StickSkrillVC.getViewController() as StickSkrillVC
        vc.type = .Skrill
        vc.gateway = self.gateway
        vc.accountTypes = self.liveAccount
        self.embed(vc, inView: innerView)
    }
    
}
