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
    var protein: Float = 20.0
    
    @IBOutlet weak var navHome: UINavigationItem!
    @IBOutlet weak var lblHello: UILabel!
    @IBOutlet weak var remainProtein: UIButton!
    @IBOutlet weak var btnTotalCal: UIButton
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.shadowImage = UIImage()
        /// 네비게이션 바 밑줄제거
        
        lblHello.text = "\t" + userName + "님 반갑습니다!\n \t오늘도 목표를 위해 함께 달려요!"
        /// 인삿말 텍스트
        shadowAndRoundLable(instance: lblHello)
        ///배너 둥글게, 그림자 처리
        shadowAndRoundButton(instance: btnTotalCal)
        
        remainProtein.setTitle("\t오늘 섭취할 단백질이 \(protein)g 남았어요!!\n \t\t\t총합 111g   >",for: .normal)
        ///lblTextBold(object: lblTotalCal, txtBold: "\(protein)g",txtColor: "총합 111g   >")
        
        remainProtein.setTitle("\t 오늘 총 칼로리 : 425 Kcal",for: .normal)
        ///lblTextBold(object: lblTotalCal, txtBold: "\(protein)g",txtColor: "총합 111g   >")

        
    }
    
    @objc func shadowAndRoundLable(instance : UILabel){
     
         instance.layer.cornerRadius = 15
         instance.clipsToBounds = true
         // border
         instance.layer.borderWidth = 0
         instance.layer.borderColor = UIColor.black.cgColor

         // shadow
         instance.layer.shadowColor = UIColor.black.cgColor
         instance.layer.shadowOffset = CGSize(width: 2, height: 2)
         instance.layer.shadowOpacity = 0.7
         instance.layer.shadowRadius = 2
     }
    
    @objc func shadowAndRoundButton(instance : UIButton){
     
         instance.layer.cornerRadius = 15
         instance.clipsToBounds = true
         // border
         instance.layer.borderWidth = 0
         instance.layer.borderColor = UIColor.black.cgColor

         // shadow
         instance.layer.shadowColor = UIColor.black.cgColor
         instance.layer.shadowOffset = CGSize(width: 2, height: 2)
         instance.layer.shadowOpacity = 0.7
         instance.layer.shadowRadius = 2
     }
    /// 모서리 둥글게, 그림자 지게 하는 함수
    
    @objc func popStart(){
        var frame = lblHello.frame
        frame.origin = CGPoint(x: frame.minX, y:frame.minY)
        frame.size = CGSize(width: 380, height: 130)
        UIView.animate(withDuration: 1.0, animations: {
            self.lblHello.frame = frame
            self.lblHello.alpha = 0.5
        })
    }
    ///pop 애니메이션 (미구현)
    
    @objc func lblTextBold(object : UILabel, txtBold: String, txtColor : String = ""){
        // NSMutableAttributedString Type으로 바꾼 text를 저장
        let attributedStr = NSMutableAttributedString(string: object.text!)

        // text의 range 중에서 "Point"라는 글자는 UIColor를 orange로 변경
        attributedStr.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 20), range: (object.text! as NSString).range(of: txtBold))
        attributedStr.addAttribute(.foregroundColor, value: UIColor.gray, range: (object.text! as NSString).range(of: txtColor))

        // 설정이 적용된 text를 label의 attributedText에 저장
        object.attributedText = attributedStr
    }
    ///  부분 문자 Bold 처리

}
