//
//  FormViewController.swift
//  SubmitValue-Back
//
//  Created by seonho on 2022/03/21.
//

import UIKit

class FormViewController : UIViewController{
    
    @IBOutlet var email : UITextField!
    @IBOutlet var isUpdate : UISwitch!
    @IBOutlet var interval : UIStepper!
    
    @IBAction func onSubmit(_ sender:Any){
        //1
        let preVC = self.presentingViewController
        guard let vc = preVC as? ViewController else {
            return
        }

        //값 전달
        vc.paramEmail = self.email.text
        vc.paramUpdate = self.isUpdate.isOn
        vc.paramInterval = self.interval.value
        
        //2 appdelegate 를 이용한 전달
//        let ad = UIApplication.shared.delegate as? AppDelegate
//        
//        //값 저장
//        ad?.paramEmail = self.email.text
//        ad?.paramUpdate = self.isUpdate.isOn
//        ad?.paramInterval = self.interval.value
        
        //3.userDefault 객체 인스턴스를 가져온다.
//        let ud = UserDefaults.standard
//
//        //값 저장
//        ud.set(self.email.text!, forKey: "email")
//        ud.set(self.isUpdate.isOn, forKey: "isUpdate")
//        ud.set(self.interval.value, forKey: "interval")
        
        //화면 복귀
        self.presentingViewController?.dismiss(animated: true)
    }
    
}
