//
//  QuizViewController.swift
//  Quiz
//
//  Created by ohtatomotaka on 2015/02/10.
//  Copyright (c) 2015年 LifeisTech. All rights reserved.
//

import UIKit
import AVFoundation

struct AVAudioPlayerUtil {
    
    static var audioPlayer:AVAudioPlayer = AVAudioPlayer();
    static var sound_data:NSURL = NSURL();
    
    static func setValue(nsurl:NSURL){
        self.sound_data = nsurl;
        self.audioPlayer = AVAudioPlayer(contentsOfURL: self.sound_data, error: nil);
        self.audioPlayer.prepareToPlay();
    }
    static func play(){
        self.audioPlayer.play();
    }
}

class QuizViewController: UIViewController,AVAudioPlayerDelegate  {
    //音源の変数宣言
    var myAudioPlayer : AVAudioPlayer!
    var myButton : UIButton!
    
    @IBOutlet var home: UIView!
    @IBOutlet var first: UIView!
    @IBOutlet var second: UIView!
    @IBOutlet var third: UIView!
    @IBOutlet var out0: UIView!
    @IBOutlet var out1: UIView!
    @IBOutlet var out2: UIView!
    @IBOutlet var out3: UIView!
    
    
    
    //出題数
    var questionNumber:Int = 7
    
    //現在の問題数
    var sum:Int = 0
    
    //正解数
    var correctAnswer:Int = 0
    
    //乱数
    var random:Int = 0
    
    //クイズを格納する配列
    var quizArray = [NSMutableArray]()
    
    //クイズを表示するTextView
    @IBOutlet var quizTextView: UITextView!
    
    //選択肢のボタン
    @IBOutlet var choiceButtons: Array<UIButton>!
    
    //アウトカウント
    var outcount:Int = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        out0.hidden = false;
        out1.hidden = true;
        out2.hidden = true;
        out3.hidden = true;
        first.hidden = true;
        second.hidden = true;
        third.hidden = true;
        
        var audioPlayer:AVAudioPlayer = AVAudioPlayer();
        var sound_data = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bat-koukaon", ofType: "mp3")!);
        audioPlayer = AVAudioPlayer(contentsOfURL: sound_data, error: nil);
        audioPlayer.prepareToPlay();
        
        
        
        //------------------------ここから下にクイズを書く------------------------//
        quizArray.append(["去年のセリーグ優勝チームは？","巨人","中日","阪神",1])
        quizArray.append(["次の内甲子園の優勝経験のある高校は？","私立城北高校","都立雪ヶ谷高校","前橋育英高校",3])
        quizArray.append(["今年の6大学野球の優勝校はどこ？","慶應義塾大学","早稲田大学","東京大学",2])
        quizArray.append(["次の内2000本安打を達成した選手は？","谷佳知","高橋由伸","井口資仁",3])
        quizArray.append(["今年の中日のドラフト１位は？","浜田智博","野村亮介","鈴木翔太",2])
//        quizArray.append(["問題文6","選択肢","選択肢2","選択肢3",2])

        //------------------------ここから下にクイズを書く------------------------//
        choiceQuiz()
    }
    
    func choiceQuiz() {
        println(quizArray.count)
        //クイズの問題文をシャッフルしてTextViewにセット
        random = Int(arc4random_uniform(UInt32(quizArray.count)))
        quizTextView.text = quizArray[random][0] as! NSString as String
        
        //選択肢のボタンにそれぞれ選択肢のテキストをセット
        for var i = 0; i < choiceButtons.count; i++ {
            choiceButtons[i].setTitle((quizArray[random][i+1] as! NSString) as NSString as String, forState: .Normal)
            
            //どのボタンが押されたか判別するためのtagをセット
            choiceButtons[i].tag = i + 1;
        }
    }
    
    @IBAction func choiceAnswer(sender: UIButton) {
        sum++
        println("random \(random)")
        if quizArray[random][4] as! Int == sender.tag {
            
            
            AVAudioPlayerUtil.setValue(NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bat-koukaon", ofType: "mp3")!)!);//ファイルセット（再生前事前準備）
            AVAudioPlayerUtil.play();
            
            
            //正解数を増やす
            correctAnswer++
            
            if(correctAnswer%3==1){
                third.hidden = true;
                first.hidden = false;
            }else if(correctAnswer%3==2){
                first.hidden = true;
                second.hidden = false;
            }else if(correctAnswer%3==0){
                second.hidden = true;
                third.hidden = false;
            }
        }else {
            outcount++
            AVAudioPlayerUtil.setValue(NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("out", ofType: "wav")!)!);//ファイルセット（再生前事前準備）
            AVAudioPlayerUtil.play();
            
            if(outcount==1){
                out0.hidden = true;
                out1.hidden = false;
            }else if(outcount==2){
                out1.hidden = true;
                out2.hidden = false;
            }
            
        }
        
        //解いた問題数の合計が予め設定していた問題数に達したら結果画面へ
        if (outcount==3) {
            performSegueToResult()
        }
        quizArray.removeAtIndex(random)
        choiceQuiz()
    }
    
    func performSegueToResult() {
        performSegueWithIdentifier("toResultView", sender: nil)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "toResultView") {
            
            var ResultView : ResultViewController = segue.destinationViewController as! ResultViewController; ResultViewController()

            ResultView.correctAnswer = self.correctAnswer
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


