//
//  LIstViewController.swift
//  MyMovieChart
//
//  Created by seonho on 2022/04/02.
//

import UIKit

class ListViewController : UITableViewController{
    
    
    @IBOutlet var moreBtn: UIButton!
    var page = 1
    
    //테이블 뷰를 구성할 리스트 데이터
    lazy var list: [MovieVO] = {
        var datalist = [MovieVO]()
        return datalist
    }()
    
    //더보기
    @IBAction func more(_ sender: Any) {
        //현재 페이지에 1을 추가한다
        self.page += 1
        //영화 차트 API 를 호출한다
        self.callMovieAPI()
        
        //데이터를 다시 읽어오도록 테이블뷰를 갱신한다
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        
        //영화 차트 API 를 호출한다
        self.callMovieAPI()
        
    }
    
    //영화 차트 API를 호출해주는 메소드
    func callMovieAPI(){
        
        //1.호핀 API 호출을 위한 URI 생성
        let url = "http://swiftapi.rubypaper.co.kr:2029/hoppin/movies?version=1&page=\(self.page)&count=10&genreId=&order=releasedateasc"
        let apiURI: URL! = URL(string: url)
        
        do{
            //2.REST API를 호출
            let apidata = try Data(contentsOf: apiURI)
            
            //3.데이터 전송 결과를 로그로 출력(반드시 필요한 코드는 아님)
            let log = NSString(data: apidata, encoding: String.Encoding.utf8.rawValue) ?? ""
            NSLog("API Result=\(log)")
            
            //4.JSON
            let apiDictionary = try JSONSerialization.jsonObject(with: apidata, options: []) as! NSDictionary
            
            //5.데이터 구조에 따라 차레대로 캐스트하여 읽어온다
            let hoppin = apiDictionary["hoppin"] as! NSDictionary
            let movies = hoppin["movies"] as! NSDictionary
            let movie = movies["movie"] as! NSArray
            
            //6.Iterator 처리를 하면서 API 데이터를 MovieVO 객체에 저장한다
            for row in movie {
                //순회 상수를 NSDictionary 타입으로 캐스트
                let r = row as! NSDictionary
                
                //테이블 뷰 리스트를 구성할 데이터 형식
                let mvo = MovieVO()
                
                //movie 배열의 각 데이터를 mvo 상수의 속성에 대입
                mvo.title = r["title"] as? String
                mvo.description = r["genreNames"] as? String
                mvo.thumbnail = r["thumbnailImage"] as? String
                mvo.detail = r["linkUrl"] as? String
                mvo.rating = ((r["ratingAverage"] as! NSString).doubleValue)
                
                //list 배열에추가
                self.list.append(mvo)
                NSLog("List add")
            }
            
            //7.전체 데이터 카운트를 조회한다.
            let totalCount = (hoppin["totalCount"] as? NSString)!.integerValue
            
            //8.totalCount 가 읽어온 데이터 크기가 같거나 클 경우 더보기 버튼을 막는다.
            if(self.list.count >= totalCount){
                self.moreBtn.isHidden = true
            }
        }catch {}
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //주어진 행에 맞는 데이터 소스를 읽어온다
        let row = self.list[indexPath.row]
        //테이블 셀 객체를 직접 생성하는 대신 큐로부터 가져옴
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as! MovieCell
        
        //3.Moviecell
        cell.title?.text = row.title
        cell.desc?.text = row.description
        cell.opendate?.text = row.opendate
        cell.thumbnail.image = UIImage(data: try! Data(contentsOf: URL(string:row.thumbnail!)!))
        cell.rating?.text = "\(row.rating!)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("선택된 행은 \(indexPath.row) 번째 행입니다.")
    }
}
