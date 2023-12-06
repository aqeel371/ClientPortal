//
//  Extension.swift
//  ClientPortal
//
//  Created by Muhammad  Aqeel on 27/11/2023.
//

import Foundation
import UIKit

// MARK: - UIViewController
extension UIViewController{
    func showAlert(title:String?,message:String?,actions:[UIAlertAction]?){
        let alert = UIAlertController(title: (title ?? ""), message: (message ?? ""), preferredStyle: .alert)
        if let actions = actions{
            for i in actions{
                alert.addAction(i)
            }
        } else {
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    func showSpinner() -> LoadingViewNib{
        let view = LoadingViewNib.instanceFromNib()
        
        view.showSpinner()
        if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            window.addSubview(view)
            view.frame = window.frame
        }
        return view
    }
    
    func handleResponse<T:Decodable>(data:Data) -> T?{
        var response:T? = nil
        do{
            response = try data.decode(T.self)
        } catch{
            print("error while decoding")
        }
        return response
    }
    func handleError(error:NSError?){
        if var messsage = error?.localizedDescription{
            messsage = messsage.replacingOccurrences(of: "URLSessionTask failed with error: ", with: "").replacingOccurrences(of: "JSON could not be serialized because of error:\nThe data couldn’t be read because it isn’t in the correct format.", with: "Server Side Error Occoured. Please Try Again")
            self.showAlert(title: "Error", message: messsage, actions: nil)
        }
    }
    func getVc(vc: String) -> UIViewController{
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: vc)
        
        return vc
    }
    
    func embed(_ viewController:UIViewController, inView view:UIView){
        viewController.willMove(toParent: self)
        viewController.view.frame = view.bounds
        view.addSubview(viewController.view)
        self.addChild(viewController)
        viewController.didMove(toParent: self)
    }
}

// MARK: - UIColor
extension UIColor {
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
    @objc class var ColorPrimary: UIColor {
        return UIColor(named: "ColorPrimary") ?? .blue
    }
    @objc class var EerieBlack: UIColor {
        return UIColor(named: "EerieBlack") ?? .blue
    }
    @objc class var Silver: UIColor {
        return UIColor(named: "Silver") ?? .blue
    }
    @objc class var DarkSilver: UIColor {
        return UIColor(named: "DarkSilver") ?? .blue
    }
    @objc class var VividCerulean: UIColor {
        return UIColor(named: "VividCerulean") ?? .blue
    }
    @objc class var SonicSilver: UIColor {
        return UIColor(named: "SonicSilver") ?? .blue
    }
    @objc class var GhostWhite: UIColor {
        return UIColor(named: "GhostWhite") ?? .blue
    }
    @objc class var Green200: UIColor {
        return UIColor(named: "Green200") ?? .blue
    }
    @objc class var Green700: UIColor {
        return UIColor(named: "Green700") ?? .blue
    }
    @objc class var Red200: UIColor {
        return UIColor(named: "Red200") ?? .blue
    }
    @objc class var Red700: UIColor {
        return UIColor(named: "Red700") ?? .blue
    }
}

//MARK: - UIImageView
extension UIImageView{
    var load: ImageUtil {
        get { return ImageUtil(image: self) }
        set { }
    }
}

//MARK: - String
extension String{
    
    func convertToFormattedDateString() -> String {
        guard let timestamp = TimeInterval(self) else {
            return ""
        }
        
        let date = Date(timeIntervalSince1970: timestamp)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        
        return dateFormatter.string(from: date)
    }
    
    func formattedDate() -> String {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        inputDateFormatter.timeZone = TimeZone(identifier: "UTC")
        
        if let inputDate = inputDateFormatter.date(from: self) {
            let outputDateFormatter = DateFormatter()
            outputDateFormatter.dateFormat = "EEE, d MMM yyyy"
            outputDateFormatter.locale = Locale(identifier: "en_US")
            return outputDateFormatter.string(from: inputDate)
        } else {
            return ""
        }
    }
    
    func formattedTime() -> String {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        inputDateFormatter.timeZone = TimeZone(identifier: "UTC")
        
        if let inputDate = inputDateFormatter.date(from: self) {
            let outputTimeFormatter = DateFormatter()
            outputTimeFormatter.dateFormat = "h:mm a"
            outputTimeFormatter.locale = Locale(identifier: "en_US")
            return outputTimeFormatter.string(from: inputDate)
        } else {
            return ""
        }
    }
    
    
}


extension Date {
    func oneMonthAgo() -> Date {
        return Calendar.current.date(byAdding: .month, value: -1, to: self) ?? self
    }
}
