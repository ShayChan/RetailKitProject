//
//  DSBaseTableViewVC.swift
//  DawsonICMItem
//
//  Created by Sammy Chen on 31/10/2019.
//  Copyright © 2019 Geometry. All rights reserved.
//

import UIKit
import SnapKit

class DSBaseTableViewVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var rowArr = [Any]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    // MARK: - 数据源方法

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none

        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50*ScreenScaleY
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("点击了cell------- %d----%d",indexPath.section,indexPath.row)

    }

    // MARK: - 懒加载

    lazy var mainTableView :UITableView = {

        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: self.view.bounds.size.height), style: UITableView.Style.grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        tableView.delegate = self
        
        weak var weakSelf = self
        tableView.delegate  = weakSelf!
        tableView.dataSource = weakSelf!

        // 延长分割线
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.rowHeight = 0;
        tableView.estimatedRowHeight = 0;
        tableView.estimatedSectionHeaderHeight = 0;

        return tableView
    }()

    lazy var nullView :UIImageView = {

        let nullView = UIImageView.init(image: UIImage.init(named: "icon_null"))
        self.mainTableView.addSubview(nullView)
        nullView.backgroundColor = UIColor.white
        nullView.isHidden = true
        nullView.snp.makeConstraints { (make) in
            make.width.height.equalTo(80*ScreenScaleY)
            make.centerX.equalTo(self.mainTableView)
            make.centerY.equalTo(self.mainTableView).offset(-80*ScreenScaleX)
        }
        return nullView
    }()
    lazy var nullLabel :UILabel = {

        let label = UILabel.init()
        label.text = "暂无数据"
        label.font = UIFont.systemFont(ofSize: 24)
        label.textAlignment = .center
        self.mainTableView.addSubview(label)
        label.isHidden = true
        label.snp.makeConstraints { (make) in
            make.left.equalTo(self.mainTableView)
            make.centerX.equalTo(self.mainTableView)
            make.top.equalTo(nullView.snp_bottom).offset(10*ScreenScaleX)
        }
        return label
    }()
}
