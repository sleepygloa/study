//
//  ViewController.swift
//  Msg-AlertController
//
//  Created by seonho on 2022/03/26.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var result: UILabel!
    @IBAction func alert(_ sender:Any){
        //메시지 창을 생성하는 구문
        let alert = UIAlertController(title:"선택", message: "항목을 선택해주세요", preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: "확인", style: .default)
        let exec = UIAlertAction(title: "실행", style: .destructive)
        let stop = UIAlertAction(title: "중지", style: .default)
        
        //버튼을 컨트롤러에 등록
        alert.addAction(cancel)
        alert.addAction(ok)
        alert.addAction(exec)
        alert.addAction(stop)
        
        
        //메시지 창 실행
        self.present(alert, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

