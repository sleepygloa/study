//
//  NewSegue.swift
//  Scene-CustomSegue
//
//  Created by seonho on 2022/03/14.
//

import UIKit

class NewSegue : UIStoryboardSegue{
    override func perform() {
        //세그웨이 출발지 컨트롤러
        let srcUVC = self.source
        //세그웨이 목적지 컨트롤러
        let destUVC = self.destination
        //fromview 에서 toview 로 전환한다
        UIView.transition(from: srcUVC.view, to: destUVC.view, duration: 2, options: .transitionCurlDown)
    }
}
