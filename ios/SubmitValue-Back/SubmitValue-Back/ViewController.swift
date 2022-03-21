//
//  ViewController.swift
//  SubmitValue-Back
//
//  Created by seonho on 2022/03/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBOutlet var resultEmail : UILabel! //이메일
    @IBOutlet var resultUpdate : UILabel! //자동갱신
    @IBOutlet var resultInterval : UILabel! //갱신주기
    
    //값 주고 받을 변수
    var paramEmail : String? //이메일
    var paramUpdate : Bool? //자동갱신
    var paramInterval : Double? //갱신주기
    
    override func viewWillAppear(_ animated: Bool) {
        if let email = paramEmail{
            resultEmail.text = email
        }
        if let update = paramUpdate{
            resultUpdate.text = update==true ? "자동갱신" : "자동갱신안함"
        }
        if let interval = paramInterval{
            resultInterval.text = "\(Int(interval))분마다"
        }
    }
}

