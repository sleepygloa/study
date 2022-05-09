//
//  FrontViewController.swift
//  Chapter4-SideBarDIY
//
//  Created by seonho on 2022/05/08.
//

import UIKit
class FrontViewController:UIViewController{
    //사이드바 오픈 기능을 위임할 델리게이트
    var delegate : RevealViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //사이드 바 오픈용 버튼 정의
        let btnSideBar = UIBarButtonItem(image: UIImage(named: "sidemenu.png"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(moveSide(_:)))
        
        //버튼을 네비게이션 바의 왼쪽 영역에 추가
        self.navigationItem.leftBarButtonItem = btnSideBar
        
        //화면 끝에서 다른 쪽으로 패닝하는 제스처 정의
        let dragLeft = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(moveSide(_:)))
        dragLeft.edges = UIRectEdge.left //시작 모서리는 왼쪽
        self.view.addGestureRecognizer(dragLeft) //뷰에 제스처 객체를 등록
        
        //화면을 스와이프 하는 제스처를 정의(사이드메뉴 닫기용)
        let dragRight = UISwipeGestureRecognizer(target: self, action: #selector(moveSide(_:)))
        dragRight.direction = .left //왼쪽
        self.view.addGestureRecognizer(dragRight) //뷰에 제스처 객체를 등록
    }
    
    @objc func moveSide(_ sender : Any){
        if sender is UIScreenEdgePanGestureRecognizer{
            self.delegate?.openSideBar(nil) //사이드 바를 연다
        }else if sender is UISwipeGestureRecognizer{
            self.delegate?.closeSideBar(nil) //사이드 바를 닫는다
        }else if sender is UIBarButtonItem{
            if self.delegate?.isSideBarShowing == false{
                self.delegate?.openSideBar(nil) //사이드 바를 연다
            }else{
                self.delegate?.closeSideBar(nil) //사이드 바를 닫는다
            }
        }
    }
}
