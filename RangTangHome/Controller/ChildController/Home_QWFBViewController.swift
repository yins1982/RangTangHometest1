//
//  HomeQWFBViewController.swift
//  RangTangHome
//
//  Created by zk-osx-dev on 2019/5/22.
//  Copyright © 2019年 zk-osx-dev. All rights reserved.
//

import UIKit
import MJRefresh


class Home_QWFBViewController: UIViewController {
    
    let glt_iphoneX = (UIScreen.main.bounds.height >= 812.0)
    
    var count = 20;
    
    private func configIdentifier(_ identifier: inout String) -> String {
        var index = identifier.index(of: ".")
        guard index != nil else { return identifier }
        index = identifier.index(index!, offsetBy: 1)
        identifier = String(identifier[index! ..< identifier.endIndex])
        return identifier
    }
    
    public func cellWithTableView<T: UITableViewCell>(_ tableView: UITableView) -> T {
        var identifier = NSStringFromClass(T.self)
        identifier = configIdentifier(&identifier)
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
        }
        return cell as! T
    }
    
    
    public func registerCell(_ tableView: UITableView, _ cellCls: AnyClass) {
        var identifier = NSStringFromClass(cellCls)
        identifier = configIdentifier(&identifier)
        tableView.register(cellCls, forCellReuseIdentifier: identifier)
    }
    
    public func tableViewConfig(_ frame: CGRect ,_ delegate: UITableViewDelegate, _ dataSource: UITableViewDataSource, _ style: UITableView.Style?) -> UITableView  {
        let tableView = UITableView(frame: frame, style: style ?? .plain)
        tableView.delegate = delegate
        tableView.dataSource = dataSource
        return tableView
    }
    
    private lazy var tableView: UITableView = {
        let H: CGFloat = view.height  - 64
        var tableView = tableViewConfig(CGRect(x: 0, y: 0, width: view.width, height: H), self, self, nil)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(tableView)
        reftreshData()
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
    }
}

extension Home_QWFBViewController {
    
    fileprivate func reftreshData()  {

        tableView.mj_footer = MJRefreshBackNormalFooter {[weak self] in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                print("上拉加载更多数据")
                
                self?.tableView.mj_footer.endRefreshing()
            })
        }
        tableView.mj_header = MJRefreshNormalHeader {[weak self] in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                print("下拉刷新 --- 1")
                self?.tableView.mj_header.endRefreshing()
                
            })
        }
    }
}


extension Home_QWFBViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cellWithTableView(tableView)
        cell.textLabel?.text = "第 \(indexPath.row + 1) 行"
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("点击了第\(indexPath.row + 1)行")
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
}

