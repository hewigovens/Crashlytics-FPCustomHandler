//
//  ViewController.swift
//  CustomCrashHandler
//
//  Created by hewig on 3/12/17.
//  Copyright © 2017 Fourplex Labs. All rights reserved.
//

import UIKit
import FPCrashHandler

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Demo"
        self.navigationController?.present(FPCrashHandler.debugOptionsAlert(), animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

