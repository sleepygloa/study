//
//  DetailViewController.swift
//  MyMovieChart
//
//  Created by seonho on 2022/04/12.
//

import UIKit
import WebKit

class DetailViewController : UIViewController{
    @IBOutlet var spinner: UIActivityIndicatorView!
    @IBOutlet var wv: WKWebView!
    var mvo: MovieVO! //목록 화면에서 전달하는 영화 정보를 받을 변수
    
    override func viewDidLoad() {
        NSLog("linkurl = \(self.mvo.detail!), title=\(self.mvo.title!)")
        
        //WKNavigationDelegate 의 델리게이트 객체를 지정
        self.wv.navigationDelegate = self
        
        //네비게이션 바에 영화 타이틀을 출력한다
        let navibar = self.navigationItem
        navibar.title = self.mvo.title
        
        if let url = self.mvo.detail{
            if let urlObj = URL(string: url){
                let req = URLRequest(url: urlObj)
                self.wv.load(req)
            }
        }else{ //URL 형식이 잘못되었을 경우에 대한 예외 처리
            //경고 창 형식으로 오류 메시지를 표시한다
            let alert = UIAlertController(title:"오류", message: "잘못된 URL입니다", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title:"확인", style: .cancel) {(_) in
                //이전 페이지로 되돌려보낸다
                _ = self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(cancelAction)
            self.present(alert, animated: false, completion: nil)
        }
    }
}
//MARK:- WKNavigationDelegate 프로토콜 구현
extension DetailViewController: WKNavigationDelegate{
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        self.spinner.startAnimating() //인디게이터 뷰의 애니메이션을 실행
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.spinner.stopAnimating() //인디게이터 뷰의 애니메이션을 중단
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.spinner.stopAnimating() //인디게이터 뷰의 애니메이션을 중단
        self.alert("상세 페이지를 읽어오지 못했습니다."){
            //버튼 클릭 시, 이전 화면으로 되돌려 보낸다
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        self.spinner.stopAnimating() //인디게이터 뷰의 애니메이션을 중단
        self.alert("상세 페이지를 읽어오지 못했습니다."){
            //버튼 클릭 시, 이전 화면으로 되돌려 보낸다
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
}


//MARK:- 심플한 경고창 함수 정의용 익스텐션
extension UIViewController{
    func alert(_ message: String, onClick: (() -> Void)? = nil){
        let controller = UIAlertController(title:nil, message: message, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title:"OK", style: .cancel) {(_) in
            onClick?()
        })
        DispatchQueue.main.async {
            self.present(controller, animated:false)
        }
    }
}
