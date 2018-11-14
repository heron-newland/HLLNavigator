//
//  HLLNavigatorDelegate.swift
//  HLLCustomNavigationBar
//
//  Created by  bochb on 2018/9/7.
//  Copyright © 2018年 com.heron. All rights reserved.
//

import UIKit

@objc protocol HLLNavigatorDelegate {

    @objc optional func backButtonTapped(navigator:HLLNavigator)
}
