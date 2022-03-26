//
//  ViewController.swift
//  SubmitValue
//
//  Created by seonho on 2022/03/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBOutlet var email : UITextField! //이메일
    @IBOutlet var isUpdate : UISwitch! //자동갱신
    @IBOutlet var interval : UIStepper! //갱신주기
    
    @IBOutlet var isUpdateText : UILabel! //자동갱신텍스트
    @IBOutlet var intervalText : UILabel! //갱신주기텍스트
    
    @IBAction func onSwtich(_ sender: UISwitch) {
        if(sender.isOn == true){
            self.isUpdateText.text = "갱신함";
        }else{
            self.isUpdateText.text = "갱신하지않음";
        }
    }
    
    @IBAction func onStepper(_ sender: UIStepper) {
        let value = Int(sender.value)
        self.intervalText.text = "\(value)분마다"
    }
    
    @IBAction func onSubmit(_ sender: Any) {
        
        //VC2 인스턴스생성
        guard let rvc = self.storyboard?.instantiateViewController(withIdentifier: "RVC") as? ResultViewController else {
            return
        }
        
        //값 전달
        rvc.paramEmail = self.email.text! //이메일
        rvc.paramUpdate = self.isUpdate.isOn //자동갱신
        rvc.paramToggle = self.interval.value //갱신주기
    
        //화면이동
        self.present(rvc, animated: true)
    }
    
    @IBAction func onSubmit2(_ sender: Any) {
        
        //VC2 인스턴스생성
        guard let rvc = self.storyboard?.instantiateViewController(withIdentifier: "RVC") as? ResultViewController else {
            return
        }
        
        //값 전달
        rvc.paramEmail = self.email.text! //이메일
        rvc.paramUpdate = self.isUpdate.isOn //자동갱신
        rvc.paramToggle = self.interval.value //갱신주기
    
        //화면이동
        //self.present(rvc, animated: true)
        self.navigationController?.pushViewController(rvc, animated: true)
    }
    
    @IBAction func onPerformSegue(_ sender: Any) {
        self.performSegue(withIdentifier: "ManualSubmit", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //목적지 뷰
        let dest = segue.destination
        
        guard let rvc = dest as? ResultViewController else{
            return
        }
        
        //값 전달
        rvc.paramEmail = self.email.text! //이메일
        rvc.paramUpdate = self.isUpdate.isOn //자동갱신
        rvc.paramToggle = self.interval.value //갱신주기
    }
    
}

