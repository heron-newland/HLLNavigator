//
//  HLLBaseNavigationController.swift
//  HLLCustomNavigationBar
//
//  Created by  bochb on 2018/9/6.
//  Copyright © 2018年 com.heron. All rights reserved.
//

import UIKit

class HLLBaseNavigationController: UINavigationController {

    var navigationBarHeight:CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.isHidden = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = true;
        super.pushViewController(viewController, animated: animated)
        if self.viewControllers.count <= 1 {
            viewController.hidesBottomBarWhenPushed = false;
        }
    }

    
}
