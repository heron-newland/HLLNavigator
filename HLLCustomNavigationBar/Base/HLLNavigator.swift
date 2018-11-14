//
//  HLLNavigator.swift
//  HLLCustomNavigationBar
//
//  Created by  bochb on 2018/9/7.
//  Copyright © 2018年 com.heron. All rights reserved.
//

import UIKit
import SnapKit
class HLLNavigator: UIView {
    //MARK: - Public
    /// 标题
    var navigationTitle: String?{
        didSet{
            configureTitle()
//            caculatorTitleFrame()
//            setNeedsLayout()
        }
    }

    var navigationBackItem: UIButton?{
        didSet{
            configureBackButton(isCustom: true)
        }
    }
    var navigationRightItems: [UIButton]?{
        didSet{
            configureRightItems()
        }
    }
    var navigationLeftItems: [UIButton]?{
        didSet{
            configureLeftItems()
        }
    }
    
    var delegate: HLLNavigatorDelegate?
    
    //专指leftItems 和 rightItems子元素之间的间距
    var innerMargin:CGFloat = 6.0{
        didSet{
            configureLeftItems()
            configureRightItems()
        }
    }
    //最左边控件距离和最右边控件距离屏幕的距离
    var margin: CGFloat = 12.0{
        didSet{
            configureBackButton(isCustom: true)
            configureLeftItems()
            configureRightItems()
            
        }
    }
    //元素之间的间距,backButton, title
    var spaceBetween: CGFloat = 6.0{
        didSet{
            configureLeftItems()
            configureRightItems()
        }
    }
    var numberOfLines:Int = 1 {
        didSet{
            titleLabel.numberOfLines = numberOfLines;

//            caculatorTitleFrame()
            setNeedsLayout()
        }
    }
    var fontOfTitle: UIFont = UIFont.systemFont(ofSize: 17){
        didSet{
            titleLabel.font = fontOfTitle
            setNeedsLayout()
//            caculatorTitleFrame()
        }
    }
    //导航栏透明度, 可以在控制器中直接改
//    var navigationAlpha:CGFloat = 1{
//        didSet{
//            backgroundColor?.withAlphaComponent(0.4)
//        }
//    }
    
    //MARK: - Private
    private var backButton:UIButton = UIButton()
    private let backImageView = UIImageView(frame: .zero)
    private let backLabel = UILabel()
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureBackButton(isCustom: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        caculatorTitleFrame()
    }
    
    

}

//MARK: - Actions
extension HLLNavigator{
    @objc func backbuttonTapped(){
        //返回按钮点击
        delegate?.backButtonTapped?(navigator: self)
    }
}
//MARK: - UI
extension HLLNavigator{
    private func configureBackButton(isCustom: Bool){
        if isCustom {
            guard let backItem = navigationBackItem else {return}
            backButton.removeFromSuperview()
            backButton = backItem
        }else{
            //默认值
            backButton.setImage(#imageLiteral(resourceName: "guanbi2"), for: .normal)
            backButton.setImage(#imageLiteral(resourceName: "guanbi"), for: .highlighted)
            backButton.setTitle("返回", for: .normal)
            backButton.setTitleColor(UIColor.black, for: .normal)
        }
        
        backButton.addTarget(self, action: #selector(backbuttonTapped), for: .touchUpInside)
        if !contains(backButton) {
            addSubview(backButton)
        }
        backButton.snp.removeConstraints()
        backButton.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(margin)
            make.bottom.equalTo(self)
            make.height.equalTo(44)
        }
        
    }
    
    /// 如果标题过长叠加怎么办?
    private func configureTitle(){
        //        navigationTitle = "我是加标题"
        guard let naviTitle = navigationTitle else {
            return
        }
        titleLabel.textAlignment = .center
        titleLabel.text = naviTitle
        titleLabel.textColor = UIColor.black
        titleLabel.font = fontOfTitle
        if !contains(titleLabel) {
            addSubview(titleLabel)
        }
        titleLabel.snp.removeConstraints()
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.bottom.equalTo(self)
            make.height.equalTo(44)
//            make.centerY.equalTo(self).offset(10)
            
            //        make.left.equalTo(backButton.snp.right).offset(6).priority(.medium)
            
        }
        
    }
    
    private func configureRightItems(){
        guard let rightItems = navigationRightItems else {
            return
        }
        for item in rightItems{
            if !contains(item) {
                addSubview(item)
            }
        }
        configureRightItemsConstrains(rightItems: rightItems)
        
    }
    
   private func configureRightItemsConstrains(rightItems: [UIButton]) {
        for (index,item) in rightItems.enumerated() {
//            print(index,item)
            item.snp.removeConstraints()
            if index == 0{
                item.snp.makeConstraints { (make) in
                    make.right.equalToSuperview().offset(-margin)
//                    make.centerY.equalToSuperview().offset(10)
                    make.bottom.equalTo(self)
                    make.height.equalTo(44)
                }
            }else{
                item.snp.makeConstraints { (make) in
                    make.right.equalTo(rightItems[index - 1].snp.left).offset(-innerMargin)
//                    make.centerY.equalToSuperview().offset(10)
                    make.bottom.equalTo(self)
                    make.height.equalTo(44)
                    
                }
            }
        }
    }
    private func configureLeftItems() {
        guard let leftItems = navigationLeftItems else {
            return
        }
        for (index,item) in leftItems.enumerated() {
//            print(index,item)
            if !contains(item) {
                addSubview(item)
            }
            item.snp.removeConstraints()
            if index == 0{
                item.snp.makeConstraints { (make) in
                    make.left.equalTo(backButton.snp.right).offset(spaceBetween)
//                    make.centerY.equalToSuperview().offset(10)
                    make.bottom.equalTo(self)
                    make.height.equalTo(44)
                }
            }else{
                item.snp.makeConstraints { (make) in
                    make.left.equalTo(leftItems[index - 1].snp.right).offset(innerMargin)
//                    make.centerY.equalToSuperview().offset(10)
                    make.bottom.equalTo(self)
                    make.height.equalTo(44)
                }
            }
            
        }
    }
    
    /** 根据左右控件与标题的长度重新计算titleLabel的布局
     *  只有返回按钮
     *  有返回按钮和rightItems
     *  只有leftItems
     *  有leftItems和rightItems
     */
    private func caculatorTitleFrame() {
        
        guard let _ = navigationTitle else { return }
        
//        guard let backBtn = backButton else { return }
        
        
        if let _ = navigationLeftItems, let _ = navigationRightItems {//只有leftItems,返回按钮,标题和rightItems
            let lastRightItem = navigationRightItems!.last!
            let lastLeftItem = navigationLeftItems!.last!
    
            let biggerWidth: CGFloat = bounds.width - lastRightItem.frame.origin.x >= lastLeftItem.frame.maxX ? bounds.width - lastRightItem.frame.origin.x : lastLeftItem.frame.maxX
            
//            var leftBigger = false
//            if lastLeftItem.bounds.width > lastRightItem.bounds.width {
//                biggerWidth = lastLeftItem.bounds.width
//                leftBigger = true
//            }
            
            if titleLabel.bounds.width > bounds.width - (biggerWidth + spaceBetween) * 2 {
                titleLabel.snp.removeConstraints()
                titleLabel.snp.makeConstraints { (make) in
                    make.left.equalTo(lastLeftItem.snp.right).offset(spaceBetween)
                                        make.width.equalTo(bounds.width - (lastLeftItem.frame.maxX + bounds.width - lastRightItem.frame.origin.x + spaceBetween * 2))
//                    make.right.equalTo(lastRightItem.snp.left).offset(-spaceBetween)
                    //                    make.centerY.equalTo(self).offset(10)
                    make.bottom.equalTo(self)
                    make.height.equalTo(44)
                }
            }
            
//            if titleLabel.bounds.width > bounds.width - (lastLeftItem.frame.maxX + bounds.width - lastRightItem.frame.origin.x + spaceBetween * 2) {
//                titleLabel.snp.removeConstraints()
//                titleLabel.snp.makeConstraints { (make) in
//                    make.left.equalTo(lastLeftItem.snp.right).offset(spaceBetween)
////                    make.width.equalTo(bounds.width - (lastLeftItem.frame.maxX + bounds.width - lastRightItem.frame.origin.x + spaceBetween * 2))
//                    make.right.equalTo(lastRightItem.snp.left).offset(-spaceBetween)
////                    make.centerY.equalTo(self).offset(10)
//                    make.bottom.equalTo(self)
//                    make.height.equalTo(44)
//                }
//            }
            
        }else if let _ = navigationLeftItems{//只有leftItems,返回按钮和标题
            let lastLeftItem = navigationLeftItems!.last!
            if titleLabel.bounds.width > bounds.width - (lastLeftItem.frame.maxX + spaceBetween) * 2 {
                titleLabel.snp.removeConstraints()
                titleLabel.snp.makeConstraints { (make) in
                    make.left.equalTo(lastLeftItem.snp.right).offset(spaceBetween)
                    make.width.equalTo(bounds.width - (lastLeftItem.frame.maxX + spaceBetween + margin))
//                    make.right.equalTo(self).offset(-margin)
//                    make.centerY.equalTo(self).offset(10)
                    make.bottom.equalTo(self)
                    make.height.equalTo(44)
                }
            }
        }else if let  _ = navigationRightItems {//只有返回和rightItems
            let lastRightItem = navigationRightItems!.last!
            //        print(lastItem.frame)
            if titleLabel.bounds.width > bounds.width - (bounds.width - lastRightItem.frame.origin.x + spaceBetween) * 2  {
                titleLabel.snp.removeConstraints()
                titleLabel.snp.makeConstraints { (make) in
                    make.left.equalTo(backButton.snp.right).offset(spaceBetween)
                    make.width.equalTo(bounds.width - (bounds.width - lastRightItem.frame.origin.x + spaceBetween * 2 + backButton.frame.maxX))
//                    make.right.equalTo(lastRightItem.snp.left).offset(-spaceBetween)
//                    make.centerY.equalTo(self).offset(10)
                    make.bottom.equalTo(self)
                    make.height.equalTo(44)
                }
            }
        } else if titleLabel.bounds.width > bounds.width - (backButton.frame.maxX + spaceBetween) * 2 {//只有返回按钮和标题
            titleLabel.snp.removeConstraints()
            titleLabel.snp.makeConstraints { (make) in
//                make.left.equalTo(backButton.snp.right).offset(spaceBetween)
                make.width.equalTo(bounds.width - (backButton.frame.maxX + spaceBetween + margin))
                make.right.equalTo(self).offset(-margin)
//                make.centerY.equalTo(self).offset(10)
                make.bottom.equalTo(self)
                make.height.equalTo(44)
            }
        }
        
        setNeedsLayout()
        
    }
    
    
}
