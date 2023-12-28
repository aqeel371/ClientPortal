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
    @IBOutlet weak var tfSelectAccount: UITextField!
    @IBOutlet weak var lblBalance: UILabel!
    @IBOutlet weak var lblDeposit: UILabel!
    @IBOutlet weak var lblEquity: UILabel!
    @IBOutlet weak var lblWithdaw: UILabel!
    
    
    //MARK: - Variables
    var accPicker = UIPickerView()
    var accountTypes = [AccountsDatum]()
    var spinner:LoadingViewNib?
    var banners = [BannerDatum]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCV()
        setupTV()
        setupTF()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        // Enable swipe to back
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: - IBActions
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func profileAction(_ sender: Any) {
        let vc = ViewControllers.ProfileVC.getViewController() as ProfileVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func depositAction(_ sender: Any) {
        let vc = ViewControllers.DepositVC.getViewController() as DepositVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func withdrawAction(_ sender: Any) {
        let vc = ViewControllers.InternalTabsVC.getViewController() as InternalTabsVC
        vc.typeVc = .withdraw
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

//MARK: - UICollection VIew Methods
extension DashboardViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func setupCV(){
        offerCV.register(UINib(nibName: "OfferCVC", bundle: nil), forCellWithReuseIdentifier: "OfferCVC")
        getBanners()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return banners.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OfferCVC", for: indexPath) as! OfferCVC
        cell.populate(banner: banners[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 60
        let height = 180.0
        
        return CGSize(width: width, height: height)
    }
    
}

//MARK: - UITableView Methods
extension DashboardViewController:UITableViewDelegate,UITableViewDataSource{
    
    func setupTV(){
        dashboardTV.register(UINib(nibName: "DashboardTVC", bundle: nil), forCellReuseIdentifier: "DashboardTVC")
        getAccounts()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardTVC", for: indexPath) as! DashboardTVC
        cell.populate(data: accountTypes[indexPath.row])
        
        if indexPath.row % 2 == 0 {
            cell.cellView.backgroundColor = UIColor.white
        } else {
            cell.cellView.backgroundColor = UIColor.GhostWhite
        }
        cell.selectionStyle = .none
        
        cell.depositCallBack = {
            let vc = ViewControllers.DepositVC.getViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = ViewControllers.AccountsVC.getViewController() as AccountsVC
//        if indexPath.row % 2 == 0 {
//            vc.titleVC = "Live"
//        } else {
//            vc.titleVC = "Demo"
//        }
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = DashboradTVHeader.instanceFromNib()
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}

//MARK: - Picker
extension DashboardViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func setupTF(){
        accPicker.delegate = self
        accPicker.dataSource = self
        tfSelectAccount.inputView = accPicker
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return accountTypes.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return (accountTypes[row].platform ?? "") + " - " + "\(accountTypes[row].login ?? 0)"
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        tfSelectAccount.text = (accountTypes[row].platform ?? "") + " - " + "\(accountTypes[row].login ?? 0)"
        self.populateData(data: accountTypes[row])
    }
}


//MARK: - API
extension DashboardViewController{
    
    func getBanners(){
//        spinner = self.showSpinner()
        ApiManager.shared.request(with: .Banners, completion: {resp in
            
            switch resp{
            case .Success(let data):
                if let bannerResp:BannerResponse = self.handleResponse(data: data as! Data){
//                    self.spinner?.removeFromSuperview()
                    if bannerResp.status ?? false {
                        if let banners = bannerResp.result?.data{
                            self.banners = banners
                            self.offerCV.reloadData()
                        }
                    }else{
                        self.showAlert(title: "Error", message: bannerResp.message, actions: nil)
                    }
                }
            case .Failure(let error):
//                self.spinner?.removeFromSuperview()
                self.handleError(error: error)
            }
            
        })
        
    }
    
    func getAccounts(){
        spinner = self.showSpinner()
        ApiManager.shared.request(with: .Accounts, completion: {resp in
            
            switch resp{
            case .Success(let data):
                self.spinner?.removeFromSuperview()
                if let accResp:AccountsResponse = self.handleResponse(data: data as! Data){
                    if accResp.status ?? false {
                        if let accounts = accResp.result?.data{
                            self.populateData(data: accounts[0])
                            self.accountTypes = accounts
                            self.dashboardTV.reloadData()
                        }
                    }else{
                        self.showAlert(title: "Error", message: accResp.message, actions: nil)
                    }
                }
            case .Failure(let error):
                self.spinner?.removeFromSuperview()
                self.handleError(error: error)
            }
            
        })
        
    }
    
    func populateData(data:AccountsDatum){
        tfSelectAccount.text = (data.platform ?? "") + " - " + "\(data.login ?? 0)"
        lblBalance.text = "$\(data.state?.margin?.balance ?? 0)"
        lblEquity.text = "$\(data.state?.margin?.equity ?? 0)"
        lblWithdaw.text = "$\(data.transactions?.totalWithdrawals?.unEscapedDouble ?? 0.0)"
        lblDeposit.text = "$\(data.transactions?.totalDeposits?.unEscapedDouble ?? 0.0)"
    }
    
}
