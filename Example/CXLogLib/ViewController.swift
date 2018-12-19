//
//  ViewController.swift
//  CXLogLib
//
//  Created by zhouchaohong1111@gmail.com on 12/19/2018.
//  Copyright (c) 2018 zhouchaohong1111@gmail.com. All rights reserved.
//

import UIKit
import CXLogLib

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Log.debug("abcd")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

