//
//  ViewController.swift
//  IOSflipCardAnimation_0801
//
//  Created by Doris on 2020/08/01.
//  Copyright © 2020 kakao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backAction))
    }
    
    @objc func backAction(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
        print("test")
    }

}

