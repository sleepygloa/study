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
        
        let preVC = self.presentingViewController
        guard let vc = preVC as? ViewController else {
            return
        }
        
        //값 전달
        vc.paramEmail = self.email.text
        vc.paramUpdate = self.isUpdate.isOn
        vc.paramInterval = self.interval.value
        
        //화면 복귀
        self.presentingViewController?.dismiss(animated: true)
    }
    
    
}
