//
//  ViewController.swift
//  Clay
//
//  Created by 이민재 on 2021/08/26.
//

import UIKit
///홈 화면
class ViewController:
    UIViewController {
    var userName = "이민재"
    
    @IBOutlet weak var navHome: UINavigationItem!

    @IBOutlet weak var lblHello: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationController?.navigationBar.shadowImage = UIImage()
        /// 네비게이션 바 밑줄제거
        
        lblHello.text = "\t" + userName + "님 반갑습니다!\n \t오늘도 목표를 위해 화이팅!"
        shadowAndRound(instance: lblHello)
        
    }
    
    @objc func shadowAndRound(instance : UILabel){
     
         instance.layer.cornerRadius = 10
         instance.clipsToBounds = true
         // border
         instance.layer.borderWidth = 0
         instance.layer.borderColor = UIColor.black.cgColor

         // shadow
         instance.layer.shadowColor = UIColor.black.cgColor
         instance.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
         instance.layer.shadowOpacity = 0.7
         instance.layer.shadowRadius = 1
         
         
     }
   
}

