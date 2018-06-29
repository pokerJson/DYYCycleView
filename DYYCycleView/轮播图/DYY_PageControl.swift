//
//  DYY_PageControl.swift
//  DYYCycleView
//
//  Created by dzc on 2018/6/28.
//  Copyright © 2018年 dyy. All rights reserved.
//

import UIKit

public enum DYYPageControlAlignment{
    case center
    case left
    case right
}

class DYY_PageControl: UIControl {
    //1 红点的个数
    public var numberOfPages: Int = 0 {
        didSet { setupItems() }
    }
    /// 红点间隔
    public var spacing: CGFloat = 8 {
        didSet { updateFrame() }
    }
    /// 红点size
    public var dotSize: CGSize = CGSize(width: 8, height: 8) {
        didSet { updateFrame() }
    }
    /// 当前显示的红点size
    public var currentDotSize: CGSize? {
        didSet { updateFrame() }
    }
    /// 红点位置
    public var alignment: DYYPageControlAlignment = .center {
        didSet { updateFrame() }
    }
    //红点 圆角角度
    public var dotRadius: CGFloat? {
        didSet { updateFrame() }
    }
    /// 当前显示红点 圆角角度
    public var currentDotRadius: CGFloat? {
        didSet { updateFrame() }
    }
    /// 当前显示的page
    public var currentPage: Int = 0 {
        didSet { changeColor(); updateFrame() }
    }
    /// 当前显示page的颜色
    public var currentPageIndicatorTintColor: UIColor = UIColor.white {
        didSet { changeColor() }
    }
    /// PageIndicatorTintColor
    public var pageIndicatorTintColor: UIColor = UIColor.gray {
        didSet { changeColor() }
    }
    /// 红点 图片
    public var dotImage: UIImage? {
        didSet { changeColor() }
    }
    /// 红点当前 图片
    public var currentDotImage: UIImage? {
        didSet { changeColor() }
    }
    /// 隐藏
    var hidesForSinglePage: Bool = false {
        didSet { isHidden = hidesForSinglePage && numberOfPages == 1 ? true : false }
    }
    
    fileprivate var items = [UIImageView]()
    fileprivate func changeColor() {
        for (index, item) in items.enumerated() {
            if currentPage == index {
                item.backgroundColor = currentDotImage == nil ? currentPageIndicatorTintColor : UIColor.clear
                item.image = currentDotImage
                if currentDotImage != nil { item.layer.cornerRadius = 0 }
            } else {
                item.backgroundColor = dotImage == nil ? pageIndicatorTintColor : UIColor.clear
                item.image = dotImage
                if dotImage != nil { item.layer.cornerRadius = 0 }
            }
        }
    }
    
    func updateFrame() {
        for (index, item) in items.enumerated() {
            let frame = getFrame(index: index)
            item.frame = frame
            var radius = dotRadius == nil ? frame.size.height/2 : dotRadius!
            if currentPage == index {
                if currentDotImage != nil { radius = 0 }
                item.layer.cornerRadius = currentDotRadius == nil ? radius : currentDotRadius!
            } else {
                if dotImage != nil { radius = 0 }
                item.layer.cornerRadius = radius
            }
            item.layer.masksToBounds = true
        }
    }
    
    fileprivate func getFrame(index: Int) -> CGRect {
        let itemW = dotSize.width + spacing
        var currentSize = currentDotSize
        if currentSize == nil {
            currentSize = dotSize
        }
        let currentItemW = (currentSize?.width)! + spacing
        let totalWidth = itemW*CGFloat(numberOfPages-1)+currentItemW+spacing
        var orignX: CGFloat = 0
        switch alignment {
        case .center:
            orignX = (frame.size.width-totalWidth)/2+spacing
        case .left:
            orignX = spacing
        case .right:
            orignX = frame.size.width-totalWidth+spacing
        }
        
        var x: CGFloat = 0
        if index <= currentPage {
            x = orignX + CGFloat(index)*itemW
        } else {
            x = orignX + CGFloat(index-1)*itemW + currentItemW
        }
        let width = index == currentPage ? (currentSize?.width)! : dotSize.width
        let height = index == currentPage ? (currentSize?.height)! : dotSize.height
        let y = (frame.size.height-height)/2
        return CGRect(x: x, y: y, width: width, height: height)
    }
    fileprivate func setupItems() {
        for item in items { item.removeFromSuperview() }
        items.removeAll()
        for i in 0..<numberOfPages {
            let frame = getFrame(index: i)
            let item = UIImageView(frame: frame)
            addSubview(item)
            items.append(item)
        }
        updateFrame()
        changeColor()
    }
    override public func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
        if hitView == self { return nil }
        return hitView
    }

}
