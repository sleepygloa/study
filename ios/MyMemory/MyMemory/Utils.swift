//
//  Utils.swift
//  MyMemory
//
//  Created by seonho on 2022/05/16.
//

import UIKit
extension UIViewController{
    var tutorialSB : UIStoryboard{
        return UIStoryboard(name: "Tutorial", bundle: Bundle.main)
    }
    func instanceTutorialVC(name:String)-> UIViewController?{
        return self.tutorialSB.instantiateViewController(withIdentifier: name)
    }
    func alert(_ message: String, completion: (()->Void)? = nil){
        //메인 쓰레드에서 실행되도록
        DispatchQueue.main.async {
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .cancel){ (_) in
                completion?() //completion 매개변수이 값이 nil이 아닐때만 실행되도록
            }
            alert.addAction(okAction)
            self.present(alert, animated: false)
        }
    }
}
