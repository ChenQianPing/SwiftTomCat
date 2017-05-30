//
//  ViewController.swift
//  SwiftTomCat
//
//  Created by ChenQianPing on 16/7/29.
//  Copyright © 2016年 ChenQianPing. All rights reserved.

//  Swift 实现“会说话的汤姆猫” App互动效果,除了不能发出声音,动画效果与原App十分类似.
//  基本原理是,根据选择的不同动作,播放对应的图像序列,支持图片缓存。

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var catIv: UIImageView!
     var audioPlayer : AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:- 隐藏状态栏
    override var prefersStatusBarHidden:Bool {
        return true
    }
    
    func playWithAudioName(_ audioName : String) {
        let path = Bundle.main.path(forResource: audioName, ofType: "mp3")
        
        if path == nil {
            return
        }
        
        let playUrl = URL.init(fileURLWithPath: path!)
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: playUrl)
            audioPlayer.numberOfLoops = 0
            audioPlayer.play()
            
        } catch let error as NSError {
            print(error.description)
        }
        
    }
    
    // MARK:- 播放动画,这个方法传到两个参数
    func playAnimationWithName(_ fileName:String,imgCount:Int) {
        if self.catIv.isAnimating {
            // 直接结束动画操作方法,这里就是没有返回值
            return
        }
        
        // 创建一个动态数组来保存所有要播放的图片
        let imagesArray = NSMutableArray()
        
        // 遍历图片
        for i in 0..<imgCount {
            
            // 拼接图片名称,不足两位0补齐
            let imageName = fileName + "_" + String.init(format: "%02d.jpg", i)
            
            // imagePath是图片的全路径
            let imagePath = Bundle.main.path(forResource: imageName, ofType: nil)!
            
            // 无缓存
            let imageTom = UIImage.init(contentsOfFile: imagePath)
            
            // 把图片加载到数组中
            imagesArray.add(imageTom!)
            
        }
        
        // 1.设置UIImageView(图片框)的animationImages属性,这个属性中包含的就是所有那些要执行动画的图片
        self.catIv.animationImages = NSArray.init(array: imagesArray) as? [UIImage]
        
        // 2.设置动画持续时间
        self.catIv.animationDuration = Double(imagesArray.count) * 0.1
        
        // 3.设置播放的次数
        self.catIv.animationRepeatCount = 1
        
        // 4.开启动画
        self.catIv.startAnimating()
        
        // 延迟执行某个方法,清空图片,也就是清空缓存,iOS会把你执行的每一个动画都缓存起来
        let timmer = 0.075
        
        self.perform(#selector(ViewController.clearMemory), with: nil , afterDelay: Double(imgCount) * timmer)
    }
    
    func clearMemory() {
        self.catIv.animationImages = nil
    }
    

    // MARK:- 放P
    @IBAction func fart() {
        self.playAnimationWithName("fart", imgCount: 28)
        self.playWithAudioName("fart")
    }

    // MARK:- 铜钹
    @IBAction func cymbal() {
        self.playAnimationWithName("cymbal", imgCount: 13)
        self.playWithAudioName("cymal")
    }

    // MARK:- 喝奶
    @IBAction func drink() {
        self.playAnimationWithName("drink", imgCount: 81)
        self.perform(#selector(ViewController.playWithAudioName), with: "drink" , afterDelay: 2.5)
    }
    
    // MARK:- 点小鸟
    @IBAction func eat() {
        self.playAnimationWithName("eat", imgCount: 40)
    }
    
    // MARK:- 扔盘子
    @IBAction func pie() {
        self.playAnimationWithName("pie", imgCount: 24)
        self.playWithAudioName("pie")
    }
    
    // MARK:- 划屏幕
    @IBAction func scratch() {
        self.playAnimationWithName("scratch", imgCount: 56)
    }
    
    // MARK:- 敲头
    @IBAction func knockout() {
        self.playAnimationWithName("knockout", imgCount: 81)
        self.playWithAudioName("knockout")
    }
    
    // MARK:- 肚子
    @IBAction func stomach() {
        self.playAnimationWithName("stomach", imgCount: 34)
        self.playWithAudioName("stomach")
    }
    
    // MARK:- 左脚
    @IBAction func footLeft() {
        self.playAnimationWithName("footLeft", imgCount: 30)
        self.playWithAudioName("footLeft")
    }
    
    // MARK:- 右脚
    @IBAction func footRight() {
        self.playAnimationWithName("footRight", imgCount: 30)
        self.playWithAudioName("footRight")
    }
    
    // MARK:- 尾巴
    @IBAction func angry() {
        self.playAnimationWithName("angry", imgCount: 26)
        self.playWithAudioName("angry")
    }

}

