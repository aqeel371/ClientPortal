//
//  ReportsVC.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 30/11/2023.
//

import UIKit

class ReportsVC: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var reportsCV: UICollectionView!
    @IBOutlet weak var dateView: UIViewX!
    @IBOutlet weak var tfSearch: UITextField!
    @IBOutlet weak var tfStartDate: UITextField!
    @IBOutlet weak var tfEndDate: UITextField!
    
    //MARK: - Variables
    var searchTypes = ["Deposit","Withdrawal","Internal Transfer"]
    var picker = UIPickerView()
    var filtre = true
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker(frame: .zero)
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        datePicker.timeZone = TimeZone.current
        
        return datePicker
    }()
    var activeTF:UITextField?
    var date = Date()
    var spinner:LoadingViewNib?
    var transactiosn = [TransactionDatum]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCV()
        setupTF()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        dateView.isHidden = filtre
        updateTF()
    }
    func updateTF(){
        tfSearch.text = searchTypes[0]
        let endDate = Date()
        let startDate = endDate.oneMonthAgo()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let startDateString = dateFormatter.string(from: startDate)
        let endDateString = dateFormatter.string(from: endDate)
        
        tfStartDate.text = startDateString
        tfEndDate.text = endDateString
        
        self.getTransaction(type: "DEPOSIT", start: tfStartDate.text ?? "", end: tfEndDate.text ?? "")
        
    }

    //MARK: - IBActions
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func profileAction(_ sender: Any) {
        let vc = ViewControllers.ProfileVC.getViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func filtreAction(_ sender: Any) {
        filtre = !filtre
        dateView.isHidden = filtre
    }
    
    @IBAction func searchAction(_ sender: Any) {
        if let type = tfSearch.text,let start = tfStartDate.text,let end = tfEndDate.text{
            var typeString = ""
            if type == searchTypes[0]{
                typeString = "DEPOSIT"
            }else if type == searchTypes[1]{
                typeString = "WITHDRAWAL"
            }else{
                typeString = "INTERNAL_TRANSFER"
            }
            
            self.getTransaction(type: typeString, start: start, end: end)
            
        }
    }
    
    
}

//MARK: - UICollectionView Methods
extension ReportsVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func setupCV(){
        reportsCV.register(UINib(nibName: "ReportsCVC", bundle: nil), forCellWithReuseIdentifier: "ReportsCVC")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return transactiosn.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReportsCVC", for: indexPath) as! ReportsCVC
        cell.populate(data: transactiosn[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height = 180.0
        return CGSize(width: width, height: height)
    }
    
}
//MARK: - UItextField Delagate
extension ReportsVC:UITextFieldDelegate{
    
    func setupTF(){
        tfSearch.delegate = self
        tfStartDate.delegate = self
        tfEndDate.delegate = self
        
        tfSearch.inputView = picker
        picker.delegate = self
        picker.dataSource = self
        setupDatePicker()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTF = textField
        
        tfSearch.text = searchTypes[0]
    }
    
    func setupDatePicker(){
        
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        
        let inputView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 200))
        inputView.backgroundColor = UIColor(named: "FA_PrimaryFontClr")
        inputView.tintColor = .white
        inputView.addSubview(datePicker)
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: inputView.topAnchor),
            datePicker.leadingAnchor.constraint(equalTo: inputView.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: inputView.trailingAnchor),
            datePicker.bottomAnchor.constraint(equalTo: inputView.bottomAnchor),
        ])
        
        tfStartDate.inputView = inputView
        tfEndDate.inputView = inputView
        
        datePicker.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
    }
    
    @objc func handleDatePicker(sender: UIDatePicker) {
        
        date = sender.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: date)
        
        activeTF?.text = "\(formattedDate)"
        
    }
    
}

//MARK: - Picker
extension ReportsVC: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return searchTypes.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return searchTypes[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        tfSearch.text = searchTypes[row]
        
    }
}

//MARK: - API
extension ReportsVC{
    
    func getTransaction(type:String,start:String,end:String){
        spinner = self.showSpinner()
        
        ApiManager.shared.request(with: .Transaction(type: type, start: start, end: end), completion: {resp in
            
            switch resp{
            case .Success(let data):
                self.spinner?.removeFromSuperview()
                if let transResp:TransactionResponse = self.handleResponse(data: data as! Data){
                    if transResp.status ?? false {
                        if let transaction = transResp.result?.data{
                            if transaction.isEmpty{
                                self.transactiosn = []
                                self.reportsCV.reloadData()
                                self.showAlert(title: "Error", message: "No Data Found..!", actions: nil)
                            }else{
                                self.transactiosn = transaction
                                self.reportsCV.reloadData()
                            }
                        }
                    }else{
                        self.showAlert(title: "Error", message: transResp.message, actions: nil)
                    }
                }
            case .Failure(let error):
                self.spinner?.removeFromSuperview()
                self.handleError(error: error)
            }
            
        })
        
    }
    
}
