//
//  MapAlertViewController.swift
//  Chapter03-Alert
//
//  Created by seonho on 2022/05/01.
//

import UIKit
import MapKit

class MapAlertViewController : UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //버튼 생성
        let alertBtn = UIButton(type: .system)
        
        //버튼 속성 설정
        alertBtn.frame = CGRect(x: 0, y: 150, width: 100, height: 30)
        alertBtn.center.x = self.view.frame.width / 2
        alertBtn.setTitle("Map Alert", for: .normal)
        alertBtn.addTarget(self, action: #selector(mapAlert(_:)), for: .touchUpInside)
        
        self.view.addSubview(alertBtn)
        
        
        //이미지 버튼
        //버튼 생성
        let imageBtn = UIButton(type: .system)
        
        //버튼 속성 설정
        imageBtn.frame = CGRect(x: 0, y: 200, width: 100, height: 30)
        imageBtn.center.x = self.view.frame.width / 2
        imageBtn.setTitle("Image Alert", for: .normal)
        imageBtn.addTarget(self, action: #selector(imageAlert(_:)), for: .touchUpInside)
        
        self.view.addSubview(imageBtn)
        
        
        //슬라이더 버튼
        //버튼 생성
        let sliderBtn = UIButton(type: .system)
        
        //버튼 속성 설정
        sliderBtn.frame = CGRect(x: 0, y: 250, width: 100, height: 30)
        sliderBtn.center.x = self.view.frame.width / 2
        sliderBtn.setTitle("slider Alert", for: .normal)
        sliderBtn.addTarget(self, action: #selector(sliderAlert(_:)), for: .touchUpInside)
        
        self.view.addSubview(sliderBtn)
        
        //테이블 버튼
        //버튼 생성
        let listBtn = UIButton(type: .system)
        
        //버튼 속성 설정
        listBtn.frame = CGRect(x: 0, y: 300, width: 100, height: 30)
        listBtn.center.x = self.view.frame.width / 2
        listBtn.setTitle("List Alert", for: .normal)
        listBtn.addTarget(self, action: #selector(listAlert(_:)), for: .touchUpInside)
        
        self.view.addSubview(listBtn)
        
        
    }
    
    @objc func mapAlert(_ sender:UIButton){
        //경고창 객체를 생성하고, OK 및 Cancel 버튼을 추가한다
        let alert = UIAlertController(title: nil, message: "여기가 맞습니까?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        
        
        //콘텐츠 뷰 영역에 들어갈 뷰 컨트롤러를 생성하고, 알림창에 등록한다
        let contentVC = UIViewController()
        
        //뷰 컨트롤러에 맵킷 뷰를 추가한다
        let mapkitView = MKMapView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        contentVC.view = mapkitView
        contentVC.preferredContentSize.height = 200
        
        //1. 위치 정보를 설정한다. 위/경도를 사용
        let pos = CLLocationCoordinate2D(latitude: 37.514322, longitude: 126.894623)
        
        //2. 지도에서 보여줄 넓이, 일종의 축척, 숫자가 작을 수록 좁은 범위를 확대 시켜 보여준다.
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        
        //3. 지도 영역을 정의
        let region = MKCoordinateRegion(center: pos, span: span)
        
        //4. 지도 뷰에 표시
        mapkitView.region = region
        mapkitView.regionThatFits(region)
        
        //5. 위치를 핀으로 표시
        let point = MKPointAnnotation()
        point.coordinate = pos
        mapkitView.addAnnotation(point)
        
        //뷰 컨트롤러를 알림창의 콘텐츠 뷰 컨트롤러 속성에 등록한다
        alert.setValue(contentVC, forKeyPath: "contentViewController")
        
        self.present(alert, animated: false)
    }
    
    
    @objc func imageAlert(_ sender:UIButton){
        //경고창 객체를 생성하고, OK 및 Cancel 버튼을 추가한다
        let alert = UIAlertController(title: nil, message: "이번 글의 평점은 다음과 같습니다.", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        
        //뷰 컨트롤러를 알림창의 콘텐츠 뷰 컨트롤러 속성에 등록한다
        let contentVC = ImageViewController()
        alert.setValue(contentVC, forKeyPath: "contentViewController")
        
        self.present(alert, animated: false)
    }
    
    
    @objc func sliderAlert(_ sender:UIButton){
        let contentVC = ControlViewController()
        //경고창 객체를 생성하고, OK 및 Cancel 버튼을 추가한다
        let alert = UIAlertController(title: nil, message: "이번 글의 평점을 입력해주세요", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default){
            (_) in
            print(">>>slider Value =  \(contentVC.sliderValue)")
        }
        alert.addAction(okAction)
        
        //뷰 컨트롤러를 알림창의 콘텐츠 뷰 컨트롤러 속성에 등록한다
        alert.setValue(contentVC, forKeyPath: "contentViewController")
        
        self.present(alert, animated: false)
    }
    
    @objc func listAlert(_ sender:UIButton){
        let contentVC = ListViewController()
        
        //델리게이트 객체를 자신으로 지정한다
        contentVC.delegate = self
        
        //경고창 객체를 생성하고, OK 및 Cancel 버튼을 추가한다
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        
        //뷰 컨트롤러를 알림창의 콘텐츠 뷰 컨트롤러 속성에 등록한다
        alert.setValue(contentVC, forKeyPath: "contentViewController")
        
        self.present(alert, animated: false)
    }
    
    func didSelectRowAt(indexPath: IndexPath){
        print(">>>> 선택된 행은 \(indexPath.row) 입니다")
    }
}
