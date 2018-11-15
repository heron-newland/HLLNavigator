//
//  HLLTwoViewController.swift
//  HLLCustomNavigationBar
//
//  Created by  bochb on 2018/9/6.
//  Copyright © 2018年 com.heron. All rights reserved.
//

import UIKit

class HLLTwoViewController: HLLBaseUIViewController {

    var goButton = UIButton()
    var textfield = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightGray
        configureTextfield()
        configureGoButton()
        // Do any additional setup after loading the view.
        let back = HLLCustomNavigatorItem()
        back.setTitle("Back", for: .normal)
        back.setTitleColor(UIColor.blue, for: .normal)
        navigationBar.navigationBackItem = back
        
        let btn = HLLCustomNavigatorItem()
        btn.setTitle("one", for: .normal)
        btn.setTitleColor(UIColor.blue, for: .normal)
        btn.addTarget(self, action: #selector(rightOneActon), for: .touchUpInside)
        
        let btn2 = HLLCustomNavigatorItem()
        btn2.setTitle("two", for: .normal)
        btn2.setTitleColor(UIColor.blue, for: .normal)
        
        let btn3 = HLLCustomNavigatorItem()
        btn3.setTitle("left one", for: .normal)
        btn3.setImage(UIImage(named: "书本费"), for: .normal)
        btn3.setTitleColor(UIColor.blue, for: .normal)
        
        let btn4 = HLLCustomNavigatorItem()
        btn4.setTitle("lefgt two哈", for: .normal)
        btn4.setTitleColor(UIColor.blue, for: .normal)
        
        
        navigationBar.navigationLeftItems = [btn3,btn4]
        navigationBar.navigationRightItems = [btn,btn2]
        
        navigationBar.numberOfLines = 2
        navigationBar.fontOfTitle = UIFont.systemFont(ofSize: 12)
        
        navigationBar.innerMargin = 6
        navigationBar.margin = 12
        navigationBar.spaceBetween = 4
        navigationBar.backgroundColor = UIColor.purple.withAlphaComponent(0.5)
    }

    private func configureTextfield(){
        textfield.backgroundColor = UIColor.lightGray
        textfield.frame = CGRect(x: 10, y: 100, width: 300, height: 44)
        textfield.delegate = self
        view.addSubview(textfield)
    }
    private func configureGoButton(){
        goButton.setTitle("Go", for: .normal)
        goButton.frame = CGRect(x: 10, y: 160, width: 300, height: 44)
        goButton.addTarget(self, action: #selector(goActon), for: .touchUpInside)
        view.addSubview(goButton)
    }
    @objc func rightOneActon(){
        UIAlertView(title: "title", message: "message", delegate: nil, cancelButtonTitle: "OK").show()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.navigationBar.isHidden = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func pop() {
//       super.pop()
        navigationController?.popViewController(animated: true)
    }
    @objc func goActon(){
        if (navigationController?.viewControllers.last?.isKind(of: HLLOneViewController.self))! {
            let twoVC = HLLTwoViewController()
            
            navigationController?.pushViewController(twoVC, animated: true)
        }else{
            let oneVC = HLLOneViewController()
            
            navigationController?.pushViewController(oneVC, animated: true)
        }
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

extension HLLTwoViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let str0 = textfield.text else { return true }
        let str: NSString = str0 as NSString
        str.replacingCharacters(in: range, with: string)
        navigationBar.navigationTitle = str as String
        return true
    }
}
