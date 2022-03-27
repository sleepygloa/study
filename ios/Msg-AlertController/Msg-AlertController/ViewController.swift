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
        
        let cancel = UIAlertAction(title: "취소", style: .cancel) {
            (_) in self.result.text = "취소 버튼을 클릭했습니다."
        }
        let ok = UIAlertAction(title: "확인", style: .default){
            (_) in self.result.text = "확인 버튼을 클릭했습니다."
        }
        let exec = UIAlertAction(title: "실행", style: .destructive){
            (_) in self.result.text = "실행 버튼을 클릭했습니다."
        }
        let stop = UIAlertAction(title: "중지", style: .default){
            (_) in self.result.text = "중지 버튼을 클릭했습니다."
        }
        
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

    
    @IBAction func login(_ sender: Any) {
        let title = "iTunes Store에 로그인"
        let message = "사용자의 Apple ID slss@gameil.com 의 암호를 입력해주세요"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: "확인", style: .default) { (_) in
            //확인 버튼을 클릭했을때 내용
            if let tf = alert.textFields?[0]{
                print("입력된 값은 \(tf.text!)입니다")
            }else{
                print("입력된 값이 없습니다")
            }
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        
        //텍스트 필드 추가
        alert.addTextField(configurationHandler: {(tf) in
            tf.placeholder = "암호"
            tf.isSecureTextEntry = true
        })
        
        self.present(alert, animated: false)
    }
    
    @IBAction func Auth(_ sender: Any) {
        let msg = "로그인"
        let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: "확인", style: .default) { (_) in
            
            //입력한 텍스트 변수
            let id = alert.textFields?[0].text
            let pw = alert.textFields?[1].text
            
            //확인 버튼을 클릭했을때 내용
            if id == "id" && pw == "1234" {
                self.result.text = "인증되었습니다"
            }else{
                self.result.text = "인증에 실패했습니다"
            }
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        
        //텍스트 필드 추가
        alert.addTextField(configurationHandler: {(tf) in
            tf.placeholder = "아이디"
            tf.isSecureTextEntry = false
        })
        
        //텍스트 필드 추가
        alert.addTextField(configurationHandler: {(tf) in
            tf.placeholder = "비밀번호"
            tf.isSecureTextEntry = true
        })
        
        self.present(alert, animated: false)
    }
    
}

