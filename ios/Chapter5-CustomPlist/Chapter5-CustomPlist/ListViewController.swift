//
//  ListViewController.swift
//  Chapter5-CustomPlist
//
//  Created by seonho on 2022/05/12.
//

import UIKit

class ListViewController : UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet weak var account: UITextField! //계좌
    @IBOutlet weak var name : UILabel! //이름
    @IBOutlet weak var gender : UISegmentedControl! //성별
    @IBOutlet weak var married : UISwitch! //결혼여부
    var accountlist = [String]()
    
    override func viewDidLoad() {
        let picker = UIPickerView()
        
        //1.피커 뷰의 델리게이트 객체를 지정
        picker.delegate = self
        //2. account 텍스트 필드 입력 방식을 가상 키보드 대신 피커 뷰로 설정
        self.account.inputView = picker
        
        //툴바 객체정의
        let toolbar = UIToolbar()
        toolbar.frame = CGRect(x: 0, y: 0, width: 0, height: 35)
        toolbar.barTintColor = .lightGray
        
        //액세서리 뷰 영역의 툴 바를 표시
        self.account.inputAccessoryView = toolbar
        
        //툴바에 들어갈 닫기버튼
        let done = UIBarButtonItem()
        done.title = "Done"
        done.target = self
        done.action = #selector(pickerDone)
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        //신규계정등록버튼
        let new = UIBarButtonItem()
        new.title = "New"
        new.target = self
        new.action = #selector(newAccount(_:))
        
        //버튼을 툴 바에 추가
        toolbar.setItems([new, flexSpace, done], animated: true)
        
        //기본 저장소 객체 불러오기
        let plist = UserDefaults.standard
        
        //불러온 값을 설정
        self.name.text = plist.string(forKey: "name")
        self.married.isOn = plist.bool(forKey: "married")
        self.gender.selectedSegmentIndex = plist.integer(forKey: "gender")
        let accountlist = plist.array(forKey: "accountlist") as? [String] ?? [String]()
        self.accountlist = accountlist
        
        if let account = plist.string(forKey: "selectedAccount"){
            self.account.text = account
            //저장 로직 시작
            let customPlist = "\(account).plist" //읽어올 파일명
            
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            let path = paths[0] as NSString
            let clist = path.strings(byAppendingPaths: [customPlist]).first!
            let data = NSMutableDictionary(contentsOfFile: clist)
            
            self.name.text = data?["name"] as? String
            self.married.isOn = data?["married"] as? Bool ?? false
            self.gender.selectedSegmentIndex = data?["gender"] as? Int ?? 0
        }
        
        //사용자 계정의 값이 비어있다면 값을 설정하는 것을 막음
        if (self.account.text?.isEmpty)! {
            self.account.placeholder = "등록된 계정이 없습니다."
            self.gender.isEnabled = false
            self.married.isEnabled = false
        }
        
        //네비게이션 바에 new Account 메소드와 연결된 버튼을 추가
        let addBtn = UIBarButtonItem(barButtonSystemItem: .add
                                     , target: self, action: #selector(newAccount(_:)))
        self.navigationItem.rightBarButtonItems = [addBtn]
     }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.accountlist.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.accountlist[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //선택된 계정값을 텍스트 필드에 입력
        let account = self.accountlist[row]
        self.account.text = account
        
        //입력 뷰 닫음
        //self.view.endEditing(true)
        
        //사용자가 계정을 생성하면 이 계정을 선택한 것으로 간주하고 저장
        let plist = UserDefaults.standard
        plist.set(account, forKey: "selectedAccount")
        plist.synchronize()
    }
    
    @objc func pickerDone(_ sender : Any){
        self.view.endEditing(true)
        
        if let _account = self.account.text {
            
            //저장 로직 시작
            let customPlist = "\(_account).plist" //읽어올 파일명
            
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            let path = paths[0] as NSString
            let clist = path.strings(byAppendingPaths: [customPlist]).first!
            let data = NSMutableDictionary(contentsOfFile: clist)
            
            self.name.text = data?["name"] as? String
            self.married.isOn = data?["married"] as? Bool ?? false
            self.gender.selectedSegmentIndex = data?["gender"] as? Int ?? 0
        }
    }
    
    @objc func newAccount(_ sender: Any){
        self.view.endEditing(true) //열려 있는 입력용 뷰부터 닫아준다
        
        //알림창 객체 생성
        let alert = UIAlertController(title: "새 계정을 입력하세요", message: nil, preferredStyle: .alert)
        
        //입력폼 추가
        alert.addTextField(){
            $0.placeholder = "ex) abc@gmail.com"
        }
        
        //버튼 및 액션 정의
        alert.addAction(UIAlertAction(title: "OK", style: .default){ (_) in
            if let account = alert.textFields?[0].text {
                //계정 목록 배열에 추가한다
                self.accountlist.append(account)
                
                //계정 텍스트 필드에 표시한다
                self.account.text = account
                
                //컨트롤의 값을 모두 초기화 한다
                self.name.text = ""
                self.gender.selectedSegmentIndex = 0
                self.married.isOn = false
                
                //계정 목록을 통째로 저장한다
                let plist = UserDefaults.standard
                
                plist.set(self.accountlist, forKey: "accountlist")
                plist.set(account, forKey: "selectedAccount")
                plist.synchronize()
                
                //입력항목을 활성화
                self.gender.isEnabled = true
                self.married.isEnabled = true
            }
        })
        
        //알림창 오픈
        self.present(alert, animated: false, completion: nil)
    }
    
    @IBAction func changeGender(_ sender: UISegmentedControl) {
        let value = sender.selectedSegmentIndex
        
        //저장 로직 시작
        let customPlist = "\(self.account.text!).plist" //읽어올 파일명
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let path = paths[0] as NSString
        let plist = path.strings(byAppendingPaths: [customPlist]).first!
        let data = NSMutableDictionary(contentsOfFile: plist) ?? NSMutableDictionary()

        data.setValue(value, forKey: "gender")
        data.write(toFile: plist, atomically: true)
    }
    @IBAction func changeMarried(_ sender: UISwitch) {
        let value = sender.isOn
        
        //저장 로직 시작
        let customPlist = "\(self.account.text!).plist" //읽어올 파일명
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let path = paths[0] as NSString
        let plist = path.strings(byAppendingPaths: [customPlist]).first!
        let data = NSMutableDictionary(contentsOfFile: plist) ?? NSMutableDictionary()

        data.setValue(value, forKey: "married")
        data.write(toFile: plist, atomically: true)
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 && !(self.account.text?.isEmpty)! {
            let alert = UIAlertController(title: nil, message: "이름을 입력하세요", preferredStyle: .alert)
            
            alert.addTextField(){
                $0.text = self.name.text
            }
            
            alert.addAction(UIAlertAction(title: "OK", style: .default){ (_) in
                let value = alert.textFields?[0].text
                
                //저장 로직 시작
                let customPlist = "\(self.account.text!).plist" //읽어올 파일명
                
                let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
                let path = paths[0] as NSString
                let plist = path.strings(byAppendingPaths: [customPlist]).first!
                let data = NSMutableDictionary(contentsOfFile: plist) ?? NSMutableDictionary()

                data.setValue(value, forKey: "name")
                data.write(toFile: plist, atomically: true)
                
                self.name.text = value
            })
            
            self.present(alert, animated: false, completion: nil)
        }
    }
}
