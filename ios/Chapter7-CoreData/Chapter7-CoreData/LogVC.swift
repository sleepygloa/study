//
//  LogVC.swift
//  Chapter7-CoreData
//
//  Created by seonho on 2022/05/26.
//

import UIKit
import CoreData

class LogVC : UITableViewController{
    var board: BoardMO! //게시글 정보를 전달받을 변수
    
    lazy var list: [LogMO]! = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        //1. 요청 객체 생성
        let fetchRequest : NSFetchRequest<LogMO> = LogMO.fetchRequest()
        
        //2. 검색 조건 생성
        let predict = NSPredicate(format: "board == %@", self.board)
        fetchRequest.predicate = predict
        
        //3. 정렬 조건 생성
        let sort = NSSortDescriptor(key: "regdate", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        
        //4. 데이터 가져오기
        do{
            return try context.fetch(fetchRequest)
        }catch let error as NSError{
            NSLog("An Error has occured while list : %@, %@", error, error.userInfo )
            return []
        }
        
        //return self.board.logs?.array as! [LogMO]
    }()
    
    override func viewDidLoad() {
        self.navigationItem.title = self.board.title
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.list[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "logcell")!
        cell.textLabel?.text = "\(row.regdate!)에 \(row.type.toLogType())되었습니다."
        cell.textLabel?.font = UIFont.systemFont(ofSize: 12)
        
        return cell
    }
}
public enum LogType : Int16{
    case create = 0
    case edit = 1
    case delete = 2
}
extension Int16{
    func toLogType() -> String{
        switch self{
        case 0 : return "생성"
        case 1 : return "수정"
        case 2 : return "삭제"
        default: return ""
        }
    }
}
