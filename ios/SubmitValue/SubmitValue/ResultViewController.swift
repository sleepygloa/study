//
//  ResultViewController.swift
//  SubmitValue
//
//  Created by seonho on 2022/03/21.
//

import UIKit

class ResultViewController : UIViewController{


    @IBOutlet var resultEmail : UILabel! //이메일
    @IBOutlet var resultUpdate : UILabel! //자동갱신
    @IBOutlet var resultToggle : UILabel! //갱신주기
    
    //받을 변수
    var paramEmail : String = ""
    var paramUpdate : Bool = false
    var paramToggle : Double = 0
    

    @IBAction func onBack(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.resultEmail.text = paramEmail
        self.resultUpdate.text = (self.paramUpdate == true ? "자동갱신" : "자동갱신안함")
        self.resultToggle.text = "\(Int(paramToggle))분 마다 갱신"
    }
    
}
