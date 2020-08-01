//
//  CardViewController.swift
//  IOSflipCardAnimation_0801
//
//  Created by Doris on 2020/08/02.
//  Copyright © 2020 kakao. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
    let yourBackImage = UIImage(named: "wallet_commonBtnBack")

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationSet()
        backButtonCheck()
        securityTimer()
    }
    
    //navigation
    func navigationSet() {
        navigationController?.navigationBar.tintColor = UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 1)
    }
    func backButtonCheck() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: yourBackImage, style: .plain, target: self, action: #selector(backAction))
    }
    
    @IBOutlet weak var securityLabel0: UILabel!
    @IBOutlet weak var securityLabel1: UILabel!
    
    
    //timer start
    var mTimer : Timer?
    func securityTimer() {
        if let timer = mTimer {
            if !timer.isValid {
                //mTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(timeCollback), userInfo: nil, repeats: true)
            }
        } else {
            mTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(timeCollback), userInfo: nil, repeats: true)
        }
    }
    //timer stop
    @objc func backAction(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
        if let timer = mTimer {
            if(timer.isValid){
                timer.invalidate()
                securityLabelxPos = 0
            }
        }
    }
    
    // security line set
    var formatter = DateFormatter()
    var securityLabelxPos: CGFloat = 0
    @objc func timeCollback(){
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let currentDateString = formatter.string(from: Date())
        securityLabel0.text = String("사용가능      \(currentDateString)      사용가능      \(currentDateString)      ")
        securityLabel1.text = String("사용가능      \(currentDateString)      사용가능      \(currentDateString)      ")
        
        if securityLabelxPos > -430 {
            securityLabelxPos -= 1
        } else {
            securityLabelxPos = 0
        }
        securityLabel0.transform = CGAffineTransform(translationX: securityLabelxPos, y: 0)
        securityLabel1.transform = CGAffineTransform(translationX: securityLabelxPos, y: 0)
        print(securityLabelxPos)
    }
}
