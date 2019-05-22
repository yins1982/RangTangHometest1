//
//  HomeViewController.swift
//  RangTangHome
//
//  Created by zk-osx-dev on 2019/5/22.
//  Copyright © 2019年 zk-osx-dev. All rights reserved.
//

import UIKit
import MJRefresh
import STSegmentPageView

class HomeViewController: UIViewController {
    let statusBarHeight = UIApplication.shared.statusBarFrame.size.height;
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true

        setTop(toParentController: self)
        setContent(toParentController: self)
    }
    
    private func setTop(toParentController:UIViewController)
    {
        let viewTop = UIView()
        viewTop.frame = CGRect(x:0,y:statusBarHeight, width:view.width, height: 80)
        viewTop.backgroundColor = UIColor.black
        self.view.addSubview(viewTop)
    }
    
    private func setContent(toParentController: UIViewController)
    {
        // use default title view configure
        let config = STSegmentPageTitleViewConfigure()
        let titles = ["推荐","热点","视频","娱乐","问答","北京","朝阳","地方","八卦","综艺","推荐","热点","视频","娱乐","问答","北京","朝阳","地方","八卦","综艺"]
        let models = titles.map { (title) -> STSegmentModel in
            let model = STSegmentModel()
            var controller = UIViewController()
            
            if title == "推荐"
            {
                controller = Home_QWFBViewController()
            }
            
            if title == "热点"
            {
                controller = Home_WRTViewController()
            }
            //controller.label.text = title
            model.segmentTitle = title
            model.segmentController = controller
            return model
        }
        //使用自定义高度
        let segmentVC = STSegmentPageViewController(childrenModels: models, titleViewH: 40, titleConfig: config)
        segmentVC.view.frame = CGRect(x: 0, y: statusBarHeight + 80, width: view.width, height: view.height - statusBarHeight+80 )
        segmentVC.addSegmentController(toParentController: self)
    }
}
