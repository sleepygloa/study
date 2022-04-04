//
//  MovieCell.swift
//  MyMovieChart
//
//  Created by seonho on 2022/04/04.
//

import UIKit
class MovieCell :UITableViewCell{
    @IBOutlet var title : UILabel! //영화제목
    @IBOutlet var desc : UILabel! //영화내용
    @IBOutlet var opendate : UILabel! //개봉일
    @IBOutlet var rating : UILabel! //평점
    @IBOutlet var thumbnail : UIImageView! //썸네일
}
