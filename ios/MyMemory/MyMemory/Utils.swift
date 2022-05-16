//
//  Utils.swift
//  MyMemory
//
//  Created by seonho on 2022/05/16.
//

import UIKit
extension UIViewController{
    var tutorialSB : UIStoryboard{
        return UIStoryboard(name: "Tutorial", bundle: Bundle.main)
    }
    func instanceTutorialVC(name:String)-> UIViewController?{
        return self.tutorialSB.instantiateViewController(withIdentifier: name)
    }
}
