//
//  SupportVC.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 30/11/2023.
//

import UIKit

class SupportVC: UIViewController {

    @IBOutlet weak var chatsTV: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTV()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func profileAction(_ sender: Any) {
        let vc = ViewControllers.ProfileVC.getViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func attachAction(_ sender: Any) {
    }
    
    @IBAction func sendAction(_ sender: Any) {
    }
    
    @IBAction func voiceAction(_ sender: Any) {
    }
    
    
    
}

extension SupportVC:UITableViewDataSource,UITableViewDelegate{
    
    func setupTV(){
        chatsTV.register(UINib(nibName: "MyChatTVC", bundle: nil), forCellReuseIdentifier: "MyChatTVC")
        chatsTV.register(UINib(nibName: "OtherChatTVC", bundle: nil), forCellReuseIdentifier: "OtherChatTVC")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 2 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyChatTVC", for: indexPath) as! MyChatTVC
            cell.selectionStyle = .none
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "OtherChatTVC", for: indexPath) as! OtherChatTVC
            cell.selectionStyle = .none
            return cell
        }
    }
    
    
}
