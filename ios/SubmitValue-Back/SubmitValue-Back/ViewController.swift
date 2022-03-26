//
//  ViewController.swift
//  SubmitValue-Back
//
//  Created by seonho on 2022/03/21.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet var resultEmail : UILabel! //이메일
    @IBOutlet var resultUpdate : UILabel! //자동갱신
    @IBOutlet var resultInterval : UILabel! //갱신주기
    
    //값 주고 받을 변수
    var paramEmail : String? //이메일
    var paramUpdate : Bool? //자동갱신
    var paramInterval : Double? //갱신주기
    
    override func viewWillAppear(_ animated: Bool) {
        NSLog("viewWillAppear check");
        
        //1.
        if let email = paramEmail{
            NSLog("DEBUG")
            resultEmail.text = email
        }
        if let update = paramUpdate{
            resultUpdate.text = update==true ? "자동갱신" : "자동갱신안함"
        }
        if let interval = paramInterval{
            resultInterval.text = "\(Int(interval))분마다"
        }
        
//        //2.AppDelegate 를 이용한 변수전달
//        let ad = UIApplication.shared.delegate as? AppDelegate
//
//        if let email = ad?.paramEmail{
//            NSLog("viewWillAppear email: "+email);
//            resultEmail.text = email
//        }
//        if let update = ad?.paramUpdate{
//            resultUpdate.text = update==true ? "자동갱신함" : "자동갱신안함"
//        }
//        if let interval = ad?.paramInterval{
//            resultInterval.text = "\(Int(interval))분마다"
//        }
        
        //3.UserDefault 를 이용한 전달
//        let ud = UserDefaults.standard
//
//        if let email = ud.string(forKey: "email"){
//            resultEmail.text = email
//        }
//
//        let update = ud.bool(forKey: "isUpdate")
//        resultUpdate.text = (update == true ? "자동갱신" : "자동갱신안함")
//
//        let interval = ud.double(forKey: "interval")
//        resultInterval.text = "\(Int(interval))분마다"
    }
}

