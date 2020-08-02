//
//  CardViewController.swift
//  IOSflipCardAnimation_0801
//
//  Created by Doris on 2020/08/02.
//  Copyright © 2020 kakao. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
    @IBOutlet weak var idCard: UIImageView!

    var isOn = true
    let idCardFrontImage = UIImage(named: "idCard_front")
    let idCardBackImage = UIImage(named: "idCard_back")
    let iconCerification = UIImage(named: "ico_certification_b")
    var transform = CATransform3DIdentity
    // flip animation
    func cardFlipAnimation(delayNum: Double) {
       // make image
       let size = CGSize(width: idCardBackImage!.size.width, height: idCardBackImage!.size.height)
       UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
       idCardBackImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
       iconCerification!.draw(in: CGRect(x: 13, y: 13, width: 28, height: 28))
       let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
       UIGraphicsEndImageContext()
       // card animation
       transform.m34 = 1.0 / 500.0
       UIView.animate(withDuration: 0.25, delay: delayNum, options: .curveLinear, animations: {
           self.transform = CATransform3DRotate(self.transform, CGFloat(90 * Double.pi / 180), 0, 1, 0)
           self.idCard.layer.transform = self.transform
           if self.isOn {
               self.idCard.image = self.idCardFrontImage
           } else {
               self.idCard.image = newImage.withHorizontallyFlippedOrientation()
           }
       }, completion: { (_) in
           UIView.animate(withDuration: 0.25, delay: 0, options: .curveLinear, animations: {
               self.transform = CATransform3DRotate(self.transform, CGFloat(100 * Double.pi / 180), 0, 1, 0)
               self.idCard.layer.transform = self.transform
               
               if self.isOn {
                   self.idCard.image = newImage.withHorizontallyFlippedOrientation()
                   self.isOn = false
               } else {
                   self.idCard.image = self.idCardFrontImage
                   self.isOn = true
               }
           }, completion: { (_) in
               UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear, animations: {
                   self.transform = CATransform3DRotate(self.transform, CGFloat(-10 * Double.pi / 180), 0, 1, 0)
                   self.idCard.layer.transform = self.transform
               })
           })
       })
    }
    //tap gesture
    @objc func touchToPickPhoto(_ gesture: UITapGestureRecognizer) {
        cardFlipAnimation(delayNum: 0)
    }

    
    //navigation
    let yourBackImage = UIImage(named: "wallet_commonBtnBack")
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
            RunLoop.main.add(mTimer!, forMode: RunLoop.Mode.common)
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardFlipAnimation(delayNum: 0.5)
        
        // tap gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchToPickPhoto(_:)))
        idCard.addGestureRecognizer(tapGesture)
        idCard.isUserInteractionEnabled = true
        
        navigationSet()
        backButtonCheck()
        securityTimer()
    }
}
