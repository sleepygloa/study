//
//  ViewController.swift
//  Chapter6-sqllite
//
//  Created by seonho on 2022/05/18.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let dbPath = self.getDBPath()
        self.dbExecute(dbPath: dbPath)
    }
    
    //DB 생성
    func getDBPath() -> String {
        //앱 내 문서 디렉터리 경로에서 SQLite DB 파일을 찾는다
        let fileMgr = FileManager()
        let docPathURL = fileMgr.urls(for: .documentDirectory, in: .userDomainMask).first! //
        let dbPath = docPathURL.appendingPathComponent("db.sqlite").path //3
//        let dbPath = "/Users/seonho/db.sqlite"
        
        //dbPath 경로에 파일이 없다면 앱 번들에 만들어 둔 db.sqlite를 가져와 복사한다
        if fileMgr.fileExists(atPath: dbPath) == false {
            let dbSource = Bundle.main.path(forResource: "db", ofType: "sqlite")
            try! fileMgr.copyItem(atPath: dbSource!, toPath: dbPath)
        }
        return dbPath
    }
    
    func dbExecute(dbPath: String){
        var db : OpaquePointer? = nil //SQLite 연결 정보를 담을 객체
        guard sqlite3_open(dbPath, &db) == SQLITE_OK else{
            print("Prepare Statement Fail")
            return
        }
        
        //데이터베이스 연결종료
        defer {
            print("Close Database Connection")
            sqlite3_close(db) //DB 연결을 해제한다
        }
        
        var stmt : OpaquePointer? = nil //컴파일된 SQL 정보를 담을 변수
        let sql = "CREATE TABLE IF NOT EXISTS sequence (num INTEGER)"
        
        guard sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK else { //데이터베이스가 연결되었다면
            print("Prepare Statement Fail")
            return
        }
        //stmt 연결종료
        defer {
            print("Finalize Statement")
            sqlite3_finalize(stmt)
        }
        
        if sqlite3_step(stmt) == SQLITE_DONE {
            print("Prepare Statement Success!")
        }
    }
}

