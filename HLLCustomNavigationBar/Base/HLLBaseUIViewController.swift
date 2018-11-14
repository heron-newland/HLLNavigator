//
//  HLLBaseUIViewController.swift
//  HLLCustomNavigationBar
//
//  Created by  bochb on 2018/9/6.
//  Copyright © 2018年 com.heron. All rights reserved.
//


/**
 *  刘海屏如法隐藏状态栏
 */
import UIKit
import SnapKit
class HLLBaseUIViewController: UIViewController {
    
    //MARK: - Public
    /// 内容容器视图
    var contentView: UIView = UIView()
    //是否隐藏导航栏
    var isNavigationBarHidden: Bool = false{
        didSet{
            shouldNavigationBarAlphaChangedAlone = true
            navigationBarAlpha = 0
        }
    }
    //自定义导航栏视图
    var navigationBar: HLLNavigator = HLLNavigator()
    
    
    //scrollView当前的偏移量
    var currentOffSetY:CGFloat = 0{
        didSet{
            if currentOffSetY <= 0 {
                return
            }
            
            currentY = currentY - (currentOffSetY - oldValue)
            
            if currentY <= -(UIApplication.shared.statusBarFrame.height + navigationBarHeight) {
                currentY = -(UIApplication.shared.statusBarFrame.height + navigationBarHeight)
            }
            if currentY >= 0.0 {
                currentY = 0.0
                
            }
            
            if !shouldNavigationBarAlphaChangedAlone {
                //改变navigationBar的frame
                navigationBarTopConstrain?.update(offset: currentY)
                if navigationBar.frame.maxY <= UIApplication.shared.statusBarFrame.height && !self.prefersStatusBarHidden {
                    
                    //有状态栏留出状态栏
                    contentTopConstrain?.update(offset: UIApplication.shared.statusBarFrame.height - navigationBar.frame.maxY)
                }else{
                    contentTopConstrain?.update(offset: 0)
                }
            }
            //改变透明度
            if shouldNavigationBarAlphaChanged || shouldNavigationBarAlphaChangedAlone {
                navigationBarAlpha = 1 + currentY / (UIApplication.shared.statusBarFrame.height + navigationBarHeight)
            }
        }
    }
    //是否改变导航栏的透明度,同时会改变导航栏的frame
    var shouldNavigationBarAlphaChanged:Bool = false
    //单独改变alpha, frame不变
    var shouldNavigationBarAlphaChangedAlone:Bool = false
    
    
    //MARK: - Private
    private var currentY:CGFloat = 0
    private var navigationBarHeight:CGFloat {
        guard let nav = self.navigationController else { return 0 }
        return nav.navigationBar.bounds.height
    }

    //不能直接设置透明度,设置shouldNavigationBarAlphaChanged或者shouldNavigationBarAlphaChangedAlone为true,会改变导航栏透明度
   private var navigationBarAlpha: CGFloat = 1.0 {
        didSet{
             navigationBar.alpha = navigationBarAlpha
            if shouldNavigationBarAlphaChangedAlone {
                
            if navigationBarAlpha <= 0 {
                if !self.prefersStatusBarHidden {
                    //有状态栏留出状态栏
                    contentTopConstrain?.update(offset: -navigationBarHeight)
                }else{
                    contentTopConstrain?.update(offset: 0)
                }
            }else{
                contentTopConstrain?.update(offset: 0)
            }
            }
        }
    }
    
    
    private var navigationBarTopConstrain: Constraint? = nil
    private var contentTopConstrain: Constraint? = nil
    private var navigationBarHeightConstrain: Constraint? = nil
    private var isPortrait: Bool = true{
        didSet{
            navigationBar.snp.updateConstraints { (make) in
//                make.left.equalToSuperview()
//                make.right.equalToSuperview()
//                self.navigationBarTopConstrain = make.top.equalToSuperview().offset(0).constraint
                make.height.equalTo(UIApplication.shared.statusBarFrame.height + navigationBarHeight)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationBar.backgroundColor = UIColor.yellow
        navigationBar.delegate = self
        contentView.backgroundColor = UIColor.orange
        view.addSubview(contentView)
        view.addSubview(navigationBar)
        
        navigationBar.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            self.navigationBarTopConstrain = make.top.equalToSuperview().offset(0).constraint
            make.height.equalTo(UIApplication.shared.statusBarFrame.height + navigationBarHeight)
        }
        
        
        contentView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            self.contentTopConstrain = make.top.equalTo(navigationBar.snp.bottom).offset(0).constraint
            make.bottom.equalToSuperview()
        }
        
        
    }
    //横竖屏判断
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.notifyWhenInteractionChanges { (context) in
            if context.percentComplete != 0 {
                if size.width > size.height {
                    self.isPortrait = false
                }else{
                    self.isPortrait = true
                }
                
            }
        }
    }
    
    func pop() {
        navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension HLLBaseUIViewController:HLLNavigatorDelegate{
    func backButtonTapped(navigator: HLLNavigator) {
        pop()
    }
}
