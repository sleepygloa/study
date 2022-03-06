//
//  ViewController.swift
//  IBTest
//
//  Created by seonho on 2022/03/06.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var uiTitle01: UILabel!
    @IBOutlet var uiTitle02: UILabel!
    @IBOutlet var uiTitle03: UILabel!
    @IBOutlet var uiTitle04: UILabel!
    @IBOutlet var uiTitle05: UILabel!
    
    @IBAction func clickBtn01(_ sender: Any) {
        self.uiTitle01.text = "Button01 click!"
    }
    @IBAction func clickBtn02(_ sender: Any) {
        self.uiTitle02.text = "Button02 click!"
    }
    @IBAction func clickBtn03(_ sender: Any){
        self.uiTitle03.text = "Button03 click!"
    }
    @IBAction func clickBtn04(_ sender: Any){
        self.uiTitle04.text = "Button04 click!"
    }
    @IBAction func clickBtn05(_ sender: Any) {
        self.uiTitle05.text = "Button05 click!"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

