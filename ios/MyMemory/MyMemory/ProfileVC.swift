//
//  ProfileVC.swift
//  MyMemory
//
//  Created by seonho on 2022/05/09.
//

import UIKit

class ProfileVC : UIViewController, UITableViewDelegate, UITableViewDataSource{
    let profileImage = UIImageView() //프로필 사진 이미지
    let tv = UITableView() //프로필 목록
    
    override func viewDidLoad() {
        self.navigationItem.title = "프로필"
        
        //뒤로 가기 버튼 처리
        let backBtn = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector(close(_:)))
        self.navigationItem.leftBarButtonItem = backBtn
        
        //1. 프로필 사진에 들어갈 기본 이미지
        let image = UIImage(named: "account.jpg")
        
        //2. 프로필 이미지 처리
        self.profileImage.image = image
        self.profileImage.frame.size = CGSize(width: 100, height: 100)
        self.profileImage.center = CGPoint(x: self.view.frame.width / 2, y: 130)
        
        //3. 프로필 이미지 둥글게 만들기
        self.profileImage.layer.cornerRadius = self.profileImage.frame.width / 2
        self.profileImage.layer.borderWidth = 0
        self.profileImage.layer.masksToBounds = true
        
        //4. 루트 뷰에 추가
        self.view.addSubview(self.profileImage)
        
        //테이블 뷰
        self.tv.frame = CGRect(x: 0, y: self.profileImage.frame.origin.y + self.profileImage.frame.size.height + 20, width: self.view.frame.width, height: 100)
        self.tv.dataSource = self
        self.tv.delegate = self
        
        self.view.addSubview(self.tv)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 13)
        cell.accessoryType = .disclosureIndicator
        
        switch indexPath.row {
        case 0 :
            cell.textLabel?.text = "이름"
            cell.detailTextLabel?.text = "꼼꼼한 재은 씨"
        case 1 :
            cell.textLabel?.text = "게정"
            cell.detailTextLabel?.text = "sqlpro@naver.com"
        default :
            ()
        }
        
        //여기에 쎌 구현 내용이 들어갈 예정입니다
        return cell
    }
    
    @objc func close(_ sender: Any){
        self.presentingViewController?.dismiss(animated: true)
    }
}
