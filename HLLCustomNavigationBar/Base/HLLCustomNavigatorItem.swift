//
//  HLLCustomNavigatorItem.swift
//  HLLCustomNavigationBar
//
//  Created by  bochb on 2018/11/15.
//  Copyright © 2018 com.heron. All rights reserved.
//

import UIKit

class HLLCustomNavigatorItem: UIButton {

    
    /// 设置按钮的content距离左右的边距
    var marginLeft: CGFloat = 6
    var marginRight: CGFloat = 6
    
    /// 根据内容获取宽度
    var itemWitdth: CGFloat {
        return self.getTitleWidth() + self.getImageWidth() + marginLeft + marginRight
    }
    

    

    /// 获取图片的宽度
    ///
    /// - Returns:
    private func getImageWidth() -> CGFloat {
        guard let img = image(for: state) else { return 0 }
        return img.size.width
    }
    
    
    /// 计算文字的宽度
    ///
    /// - Returns: 
    private func getTitleWidth() -> CGFloat{
        guard let myTitle = title(for: state) else { return 0 }
        let myFont = titleLabel!.font!
       let mTitle = myTitle as NSString
      let size =  mTitle.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: myFont.lineHeight), options: [.usesFontLeading , .usesLineFragmentOrigin], attributes: [NSAttributedStringKey.font: myFont], context: nil).size
        return size.width
    }
}
