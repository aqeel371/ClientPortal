//
//  StickSkrillVC.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 29/11/2023.
//

import UIKit

class StickSkrillVC: UIViewController {

    
    @IBOutlet weak var tfTradingAccount: UITextField!
    @IBOutlet weak var tfAmount: UITextField!
    @IBOutlet weak var tvNotes: UITextView!
    
    var type:TransferType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tvNotes.delegate = self
        // Do any additional setup after loading the view.
    }
    

    @IBAction func depositAction(_ sender: Any) {
    }
    

}

//MARK: - UItextView Delegate

extension StickSkrillVC:UITextViewDelegate{
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
