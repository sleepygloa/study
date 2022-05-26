//
//  DepartmentListVC.swift
//  Chapter6-HR
//
//  Created by seonho on 2022/05/20.
//

import UIKit

class DepartmentListVC : UITableViewController{
    var departList: [(departCd: Int, departTitle: String, deaprtAddr: String)]! //데이터 소스용 멤버 변수
    let departDAO = DepartmentDAO() // SQLite 처리를 담당할 DAO 객체
    
    //UI 초기화할 변수
    func initUI(){
        //1. 네비게이션 타이틀용 레이블 속성 설정
        let navTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
        navTitle.numberOfLines = 2
        navTitle.textAlignment = .center
        navTitle.font = UIFont.systemFont(ofSize: 14)
        navTitle.text = "부서 목록 \n" + " 총 \(self.departList.count) 개"
        
        //2. 네비게이션 바 UI 설정
        self.navigationItem.titleView = navTitle
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        //3. 쎌을 스와이프 했을 때 편집 모드가 되도록 설정
        self.tableView.allowsSelectionDuringEditing = true
    }
    
    override func viewDidLoad() {
        self.departList = self.departDAO.find()
        self.initUI()
    }
    
    //테이블뷰 row 갯수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.departList.count
    }
    
    //row 스타일
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //indexPath 매개변수가 가리키는 행에 대한 데이터를 읽어온다
        let rowData = self.departList[indexPath.row]
        
        //셀 객체를 생성하고 데이터를 배치한다
        let cell = tableView.dequeueReusableCell(withIdentifier: "DEPART_CELL")
        
        cell?.textLabel?.text = rowData.departTitle
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 14)
        
        cell?.detailTextLabel?.text = rowData.deaprtAddr
        cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 12)
        
        return cell!
    }
    
    //row 수정상태시
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.delete
    }
    
    //row 삭제시
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //1. 삭제할 행의 departCd 를 구한다
        let departCd = self.departList[indexPath.row].departCd
        
        //2. DB 에서, 데이터 소스에서, 그리고 테이블 뷰에서 차례대로 삭제한다.
        if departDAO.remove(departCd: departCd) {
            self.departList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    //+ 버튼 클릭
    @IBAction func add(_ sender: Any) {
        let alert = UIAlertController(title: "신규 부서 목록", message: "신규 부서를 등록해 주세요", preferredStyle: .alert)
        
        //부서명 및 주소 입력용 텍스트 필드 추가
        alert.addTextField() { (tf) in tf.placeholder = "부서명" }
        alert.addTextField() { (tf) in tf.placeholder = "주소" }
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel)) //취소
        alert.addAction(UIAlertAction(title: "확인", style: .default) { (_) in
            let title = alert.textFields?[0].text //부서명
            let addr = alert.textFields?[1].text //부서 주소
            
            if self.departDAO.create(title: title!, addr: addr!){
                //신규 부서가 등록되면 DB에서 목록을 다시 읽어온 후, 테이블을 갱신해 준다.
                self.departList = self.departDAO.find()
                self.tableView.reloadData()
                
                //네비게이션 타이틀에도 변경된 부서 정보를 반영한다
                let navTitle = self.navigationItem.titleView as! UILabel
                navTitle.text = "부서 목록 \n" + " 총 \(self.departList.count) 개"
            }
        })
        
        self.present(alert, animated: false)
    }
}
