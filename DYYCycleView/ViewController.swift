//
//  ViewController.swift
//  DYYCycleView
//
//  Created by dzc on 2018/6/28.
//  Copyright © 2018年 dyy. All rights reserved.
//

import UIKit

let KSWidth = UIScreen.main.bounds.size.width
let KSHeight = UIScreen.main.bounds.size.height

class ViewController: UIViewController {

    var view1:DYY_CycleView?
    var view2:DYY_CycleView?
    var view3:DYY_CycleView?
    var view4:DYY_CycleView?
    var view5:DYY_CycleView?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        view1 = DYY_CycleView(frame: CGRect(x: 0, y: 100, width: KSWidth, height: 100))
        view1?.placeholderImage = #imageLiteral(resourceName: "back.png")
        view1?.setUrlsGroup(["http://chatm-icon.oss-cn-beijing.aliyuncs.com/pic/pic_20171101181927887.jpg", "http://chatm-icon.oss-cn-beijing.aliyuncs.com/pic/pic_20171114171645011.jpg", "http://chatm-icon.oss-cn-beijing.aliyuncs.com/pic/pic_20171114172009707.png"])
        view1?.pageControlIndictirColor = UIColor.green
        view1?.pageControlCurrentIndictirColor = UIColor.red
        view1?.scrollDirection = .vertical//垂直滚动
        view1?.delegate = self
        view.addSubview(view1!)
        
        view2 = DYY_CycleView(frame: CGRect(x: 0, y: 220, width: KSWidth, height: 100))
        view2?.timeInterval = 3
        view2?.placeholderImage = #imageLiteral(resourceName: "back.png")
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            self.view2?.setUrlsGroup(["http://t.cn/RYMuvvn","http://t.cn/RYVfnEO","http://t.cn/RYVf1fd","http://t.cn/RYVfgeI","http://t.cn/RYVfsLo"])
        }
        view2?.pageControlItemSize = CGSize(width: 22, height: 4)
        view2?.pageControlCurrentItemSize = CGSize(width: 10, height: 10)
        view2?.pageControlIndictirColor = UIColor.red
        view2?.pageControlCurrentIndictirColor = UIColor.blue
        view2?.pageControlHeight = ((view2?.frame.size.height)!-90*1.3)/2
        view2?.itemSize = CGSize(width: 240, height: 90)
        view2?.itemZoomScale = 1.1
        view2?.itemSpacing = 60
        view2?.didSelectedItem = {
            print("cycleView2 didSelectedItem:  \($0)")
        }
        view.addSubview(view2!)
        
        view3 = DYY_CycleView(frame: CGRect(x: 0, y: 350, width: KSWidth, height: 40))
        view3?.setTitlesGroup(["xxxxxxxxxxxxxxxxxxxxxxx","yyyyyyyyyyyyyyyyy","ddddddddddddddddddddd", "vvvvvvvvvvvv"])
        view3?.setTitleImagesGroup([#imageLiteral(resourceName: "back.png"),#imageLiteral(resourceName: "back.png")], sizeGroup: [CGSize(width: 30, height: 15),CGSize(width: 30, height: 15),CGSize(width: 30, height: 15)])
        view3?.titleBackgroundColor = UIColor.white
        view3?.titleColor = UIColor.blue
        view3?.scrollDirection = .vertical
        view3?.didSelectedItem = {
            print("cycleView3 didSelectedItem:  \($0)")
        }
        view.addSubview(view3!)
        
        view4 = DYY_CycleView(frame: CGRect(x: 0, y: 410, width: KSWidth, height: 100))
        view4?.setImagesGroup([#imageLiteral(resourceName: "back.png"),#imageLiteral(resourceName: "back.png"),#imageLiteral(resourceName: "back.png")], titlesGroup: ["xxxxxxxxxxxxxxxxxx","ffffffffffffffff","vvvvvvvvvvv","rrrrrrrrrrrrrrrr","tttttttttttttttttttt"])
        view4?.itemSize = CGSize(width: KSWidth-160, height: (KSWidth-160)*300/750)
        view4?.itemSpacing = 40
        view4?.itemZoomScale = 1.2
        view4?.itemBorderWidth = 1
        view4?.itemBorderColor = UIColor.gray
        view4?.pageControlIndictorImage = #imageLiteral(resourceName: "back.png")
        view4?.pageControlCurrentIndictorImage = #imageLiteral(resourceName: "back.png")
        view4?.pageControlHeight = 18
        view4?.pageControlItemSize = CGSize(width: 16, height: 16)
        view4?.pageControlAlignment = .right
        view4?.didSelectedItem = {
            print("cycleView4 didSelectedItem:  \($0)")
        }
        view.addSubview(view4!)
        
        
        let titles: [NSString] = ["正在直播·2017维密直播大秀\n天使惊艳合体性感开撩","猎场-会员抢先看\n胡歌陈龙联手戳穿袁总阴谋","我的！体育老师\n好样的！前妻献媚讨好 张嘉译一口回绝","小宝带你模拟断案！\n开局平民，晋升全靠运筹帷幄","【挑战极限·精华版】孙红雷咆哮洗车被冻傻"]
        
        let attibutedTitles = titles.map { (str) -> NSAttributedString in
            let arr = str.components(separatedBy: "\n")
            let attriStr = NSMutableAttributedString(string:str as String)
            attriStr.addAttributes([.foregroundColor: UIColor.green, .font: UIFont.systemFont(ofSize: 13)], range: NSMakeRange(0, arr[0].count))
            if arr.count > 1 {
                attriStr.addAttributes([.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 11)], range: NSMakeRange(arr[0].count+1, arr[1].count))
            }
            return attriStr
        }
        view5 = DYY_CycleView(frame: CGRect(x: 0, y: 530, width: KSWidth, height: 160))
        view5?.timeInterval = 3
        view5?.setImagesGroup([#imageLiteral(resourceName: "back.png"),#imageLiteral(resourceName: "back.png"),#imageLiteral(resourceName: "back.png")], attributedTitlesGroup: attibutedTitles)
        view5?.itemSize = CGSize(width: KSWidth-40, height: (KSWidth-40)*30/70)
        view5?.itemSpacing = 5
        view5?.titleBackgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        view5?.titleNumberOfLines = 0
        view5?.titleViewHeight = 40
        view5?.pageControlIsHidden = true
        view.addSubview(view5!)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension ViewController:DYYCycleViewProtocol{
    func cycleViewDidScrollToIndex(_ index: Int) {
        print(index)
    }
    func cycleViewDidSelectedIndex(_ index: Int) {
        print("selected: \(index)")
    }
}
