//
//  HLLBaseTabBarController.swift
//  HLLCustomNavigationBar
//
//  Created by  bochb on 2018/9/6.
//  Copyright © 2018年 com.heron. All rights reserved.
//

import UIKit

class HLLBaseTabBarController: UITabBarController {
    
    static func customInit() -> HLLBaseTabBarController {
        let tabBarVC = HLLBaseTabBarController()
        tabBarVC.hidesBottomBarWhenPushed = true
        tabBarVC.tabBar.tintColor = UIColor.black
        //必须同时设定才能生效
        tabBarVC.tabBar.shadowImage = UIImage()
        tabBarVC.tabBar.backgroundImage = #imageLiteral(resourceName: "back")
        
        let oneVC = HLLOneViewController()
        oneVC.tabBarItem.image = #imageLiteral(resourceName: "地图").withRenderingMode(.alwaysOriginal)
        oneVC.tabBarItem.selectedImage = #imageLiteral(resourceName: "电费").withRenderingMode(.alwaysOriginal)
        oneVC.tabBarItem.title = "One"
        
        let twoVC = HLLTwoViewController()
        twoVC.tabBarItem.image = #imageLiteral(resourceName: "地址管理-删除").withRenderingMode(.alwaysOriginal)
        twoVC.tabBarItem.selectedImage = #imageLiteral(resourceName: "店铺").withRenderingMode(.alwaysOriginal)
        twoVC.tabBarItem.title = "Two"
        
        let threeVC = HLLThreeViewController()
        threeVC.tabBarItem.image = #imageLiteral(resourceName: "地址管理-编辑").withRenderingMode(.alwaysOriginal)
        threeVC.tabBarItem.selectedImage = #imageLiteral(resourceName: "书本费").withRenderingMode(.alwaysOriginal)
        threeVC.tabBarItem.title = "Three"
        
        let navOne = HLLBaseNavigationController(rootViewController: oneVC)
        let navTwo = HLLBaseNavigationController(rootViewController: twoVC)
        let navThree = HLLBaseNavigationController(rootViewController: threeVC)
        tabBarVC.viewControllers = [navOne, navTwo,navThree]
        return tabBarVC
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
