//
//  ResultViewController.swift
//  Quiz
//
//  Created by ohtatomotaka on 2015/02/10.
//  Copyright (c) 2015年 LifeisTech. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
     var correctAnswer:Int = 0
    
    //結果を格納する配列
//    var resultArray = [NSMutableArray]()
    
    //正解数に応じて結果画面が変化して表示するTextView
    @IBOutlet var resultTextView: UITextView!

    override func viewDidLoad() {
        
//        resultArray.append(["あなたは神レベル！"])
//        resultArray.append(["あなたは凡人レベル！"])
//        resultArray.append(["あなたは猿レベル！"])
        
        
        
        
        super.viewDidLoad()
        if correctAnswer >= 3 {
             self.resultTextView.text = "あなたは神レベル！"
        }else if correctAnswer <= 1 {
             self.resultTextView.text = "あなたは猿レベル！"
        }else{
            
            self.resultTextView.text = "あなたは凡人レベル！"
                
            }
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
