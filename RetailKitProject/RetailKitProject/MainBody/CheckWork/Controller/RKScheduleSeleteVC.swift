//
//  RKScheduleSeleteVC.swift
//  RetailKitProject
//
//  Created by Sammy Chen on 20/12/2019.
//  Copyright © 2019 Geometry. All rights reserved.
//

import UIKit


class RKScheduleSeleteVC: DSBaseTableViewVC {

    var page :NSInteger = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "选择项目"
        prepareUI()
        getData()
        
//        // 监听团队成员数的变化
//        NotificationCenter.default.addObserver(self, selector: #selector(changeMemberMessageFunc), name: NSNotification.Name(rawValue:"ChangeMemberFuncNotification"), object: nil)
        
//        self.view.backgroundColor = UIColor.yellow
    }
    
    
    @objc func changeMemberMessageFunc() {
        getData()
    }
    
    // MARK: - UIMainBackgroundColor
    private func prepareUI() {
        
        self.view.backgroundColor = MainBackgroundColor
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.view.addSubview(self.titleLabel)
        titleLabel.snp_makeConstraints({ (make) in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.view)
            make.height.equalTo(60)
        })
        
        self.view.addSubview(self.mainTableView)
        mainTableView.snp_makeConstraints({ (make) in
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.top.equalTo(self.titleLabel.snp_bottom)
            make.bottom.equalTo(self.view).offset(-15)
        })
        mainTableView.register(RKProjectCell.self, forCellReuseIdentifier: "RKProjectCell")
        mainTableView.estimatedRowHeight = 150*ScreenScaleY
        mainTableView.backgroundColor = MainBackgroundColor
        
    }
    
    // MARK: - 列表数据源
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowArr.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "RKProjectCell", for: indexPath) as! RKProjectCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        cell.projectModel = self.rowArr[indexPath.row] as! RKProjectListModel
        cell.backgroundColor = UIColor.white
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            
        return UITableView.automaticDimension
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // 点击提示是否确认
        let projectModel = self.rowArr[indexPath.row] as! RKProjectListModel

        // 系统弹框
        var title = ""
        if projectModel.project_name!.length>0 {
            title = String(format: "您选择的项目是：%@", projectModel.project_name!)
        }else {
            title = "您选择的项目名为null"
        }
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertAction.Style.cancel, handler: nil)
        let okAction = UIAlertAction(title: "确定", style: UIAlertAction.Style.default , handler: { (action: UIAlertAction!) -> Void in
            // 保存项目名和项目代码
            UserDefaults.standard.set(projectModel.project_name, forKey: "projectName")
            UserDefaults.standard.set(projectModel.external_code, forKey: "projectCode")
            UserDefaults.standard.set(projectModel.start_time, forKey: "projectStarTime")
            UserDefaults.standard.set(projectModel.end_time, forKey: "projectEndTime")
            UserDefaults.standard.synchronize()
            // 通知刷新首页
            NotificationCenter.default.post(name: NSNotification.Name(RefreshHomeWithProCodeNotificationName), object: self, userInfo: nil)
            self.dismiss(animated: true, completion: nil)
        })
        cancelAction.setValue(MainQianTextColor, forKey:"titleTextColor")
        okAction.setValue(MainColor, forKey:"titleTextColor")
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - 获取数据
    private func getData() {
        
        NetworkTools.sharedInstance.getProjectListRequst(parameArr: [String(format: "%ld",page)], success: { (respond) in
            
            let dict = respond as! [String : Any]
            let dataDict = dict["data"] as! [String : Any]
            let tempArr = dataDict["list"] as! [Any]
            
            for idx in 0..<tempArr.count {
                let listDict = tempArr[idx]
                let model: RKProjectListModel = JsonUtil.dictionaryToModel(listDict as! [String : Any], RKProjectListModel.self) as! RKProjectListModel
                self.rowArr.append(model)
            }
            self.mainTableView.reloadData()
        }) { (error) in
            self.show(text: (error as! String))
        }
    }
    
    lazy var titleLabel :UILabel = {
        let label = UILabel.creatLabelWithTitle(title: "项目选择", titleColor: UIColor.black, fontSize: 18*ScreenScaleX)
        label.textAlignment = .center
        return label
    }()
        
}
