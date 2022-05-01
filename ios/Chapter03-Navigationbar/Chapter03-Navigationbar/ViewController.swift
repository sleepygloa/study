//
//  ViewController.swift
//  Chapter03-Navigationbar
//
//  Created by seonho on 2022/04/28.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //네비게이션 타이틀 초기화
        
        //1.기본
//        self.initTitle()
        
        //2.상단 하단 나누기
//        self.initTitleNew()
        
        //3. 이미지 추가하기
//        self.initTitleImage()
        
        //4. 타이틀에 텍스트 필드 사용하기
        self.initTitleInput()
    }
    
    func initTitleInput(){
        // 텍스트 필드 객체 생성
        let tf = UITextField()
        tf.frame = CGRect(x: 0, y: 0, width: 300, height: 35)
        tf.backgroundColor = .white //배경 색상을 흰색으로
        tf.font = UIFont.systemFont(ofSize: 13) //입력할 글씨 크기를 13픽셀로
        tf.autocapitalizationType = .none //자동 대문자 변환 속성은 미사용
        tf.autocorrectionType = .no //자동 입력 기능 해제
        tf.spellCheckingType = .no //스펠링 체크 기능 해제
        tf.keyboardType = .URL //URL 입력 전용 키보드
        tf.keyboardAppearance = .dark
        tf.layer.borderWidth = 0.3 //테두리 경계선 두께
        tf.layer.borderColor = UIColor(red: 0.60, green: 0.60, blue: 0.60, alpha: 1.0).cgColor
        
        //타이틀 뷰에 속성 대입
        self.navigationItem.titleView = tf
    }
    
    func initTitleImage(){
        let image = UIImage(named: "swift_logo")
        let imageV = UIImageView(image: image)
        
        self.navigationItem.titleView = imageV
    }
    
    func initTitleNew(){
        //1. 복잡한 레이아웃을 구현할 컨테이너 뷰
        let containerView  = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 36 ))
        
        //2. 상단 레이블 정의
        let topTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 18))
        topTitle.numberOfLines = 1
        topTitle.textAlignment = .center
        topTitle.font = UIFont.systemFont(ofSize: 15)
        //topTitle.textColor = .white
        topTitle.text = "58개 숙소"
        
        //3. 하단 레이블 정의
        
        let subTitle = UILabel(frame: CGRect(x: 0, y: 18, width: 200, height: 18))
        subTitle.numberOfLines = 1
        subTitle.textAlignment = .center
        subTitle.font = UIFont.systemFont(ofSize: 12)
        //subTitle.textColor = .white
        subTitle.text = "1박(1월 10일 ~ 1월 11일)"
        
        //4. 상하단 레이블을 컨테이너 뷰에 추가한다
        containerView.addSubview(topTitle)
        containerView.addSubview(subTitle)
        
        //5. 내비게이션 타이틀에 컨테이너 뷰를 대입한다
        self.navigationItem.titleView = containerView
        
        //배경 색상 설정
        let color = UIColor(red: 0.02, green: 0.22, blue: 0.49, alpha: 1.0)
        self.navigationController?.navigationBar.barTintColor = color
    }
    
    func initTitle(){
        //1. 네비게이션 타이틀용 레이블 객체
        let nTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 40))

        //2. 속성 설정
        nTitle.numberOfLines = 2 //두 줄까지 표시되도록 설정
        nTitle.textAlignment = .center //중앙 정렬
        //nTitle.textColor = .white //추가된 구문) 텍스트 색상 설정
        nTitle.font = UIFont.systemFont(ofSize: 15) //폰트 크기
        nTitle.text = "58개 숙소 \n 1박(1월 10일 ~ 1월 11일)"

        //3. 네비게이션 타이틀에 입력
        self.navigationItem.titleView = nTitle

        //배경 색상 설정
        let color = UIColor(red: 0.02, green: 0.22, blue: 0.49, alpha: 1.0)
        self.navigationController?.navigationBar.barTintColor = color
    }

}

