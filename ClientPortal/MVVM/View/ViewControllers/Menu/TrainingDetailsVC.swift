//
//  TrainingDetailsVC.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 30/11/2023.
//

import UIKit

class TrainingDetailsVC: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var tfSearch: UITextField!
    @IBOutlet weak var trainingCV: UICollectionView!
    @IBOutlet weak var titleLbl: UILabel!
    
    //MARK: - Varibles
    var type:TrainingType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCV()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if type == .webinar{
            titleLbl.text = "Webinars"
        }else if type == .market{
            titleLbl.text = "Market Overview"
        }else if type == .technical{
            titleLbl.text = "Technical Analysis"
        }else if type == .blogs{
            titleLbl.text = "Blogs"
        }
    }
    
    //MARK: - IBActions
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func profileAction(_ sender: Any) {
        let vc = ViewControllers.ProfileVC.getViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

//MARK: - UIcollectionView Methods
extension TrainingDetailsVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func setupCV(){
        trainingCV.register(UINib(nibName: "TrainingCVC", bundle: nil), forCellWithReuseIdentifier: "TrainingCVC")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrainingCVC", for: indexPath) as! TrainingCVC
        if indexPath.row % 2 == 0 {
            cell.videoImage.image = UIImage(named: "ic_train1")
        } else {
            cell.videoImage.image = UIImage(named: "ic_train2")
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height = 175.0
        return CGSize(width: width, height: height)
    }
    
}
