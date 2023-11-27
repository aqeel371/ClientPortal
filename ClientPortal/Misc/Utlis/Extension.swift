//
//  Extension.swift
//  ClientPortal
//
//  Created by Muhammad  Aqeel on 27/11/2023.
//

import Foundation
import UIKit

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
}
