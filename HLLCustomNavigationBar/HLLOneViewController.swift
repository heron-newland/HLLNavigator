//
//  HLLOneViewController.swift
//  HLLCustomNavigationBar
//
//  Created by  bochb on 2018/9/6.
//  Copyright © 2018年 com.heron. All rights reserved.
//

import UIKit

class HLLOneViewController: HLLBaseUIViewController {

    private let lab = UILabel()
    private let testTableView: UITableView = UITableView(frame: .zero, style: .plain)
     let cellId = "myCellId"
    private var data:[String] = {
        var arr = [String]()
        for i in 0...100 {
            //, 请多关照!, 请多关照!
            arr.append("我是第\(i)个, 请多关照! 请多关照lkljlkjlk")
        }
        return arr
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white;
        // Do any additional setup after loading the view.
        testTableView.dataSource = self
        testTableView.delegate = self
        testTableView.register(HLLUITableViewCell.self, forCellReuseIdentifier: cellId)
        
        contentView.addSubview(testTableView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        testTableView.frame = contentView.bounds
    }
    
    override func pop() {
        print("pop")
        super.pop()
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension HLLOneViewController:UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HLLUITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! HLLUITableViewCell
        cell.name = data[indexPath.row]
 
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (navigationController?.viewControllers.last?.isKind(of: HLLOneViewController.self))! {
            let twoVC = HLLTwoViewController()
            twoVC.navigationBar.navigationTitle = data[indexPath.row]
            navigationController?.pushViewController(twoVC, animated: true)
        }else{
            let oneVC = HLLOneViewController()
            oneVC.navigationBar.navigationTitle = data[indexPath.row]
            navigationController?.pushViewController(oneVC, animated: true)
        }
    }
}
class HLLUITableViewCell: UITableViewCell {
    
     let lab = UILabel(frame: .zero)
    
    var name: String?{
        didSet{
           lab.text = name
        }
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(lab)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        lab.frame = bounds
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
