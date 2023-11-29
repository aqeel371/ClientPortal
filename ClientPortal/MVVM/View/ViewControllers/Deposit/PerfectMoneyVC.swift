//
//  PerfectMoneyVC.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 29/11/2023.
//

import UIKit

class PerfectMoneyVC: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var tfTradingAccount: UITextField!
    @IBOutlet weak var tfPayeeAccount: UITextField!
    @IBOutlet weak var tfAmount: UITextField!
    @IBOutlet weak var tvNotes: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tvNotes.delegate = self
        // Do any additional setup after loading the view.
    }
    
    //MARK: - IBActions
    @IBAction func depositAction(_ sender: Any) {
    }
    

}

//MARK: - UITextView Delegate
extension PerfectMoneyVC:UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.Silver {
            textView.text = nil
            textView.textColor = UIColor.EerieBlack
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Special Notes"
            textView.textColor = UIColor.Silver
        }
    }
}
