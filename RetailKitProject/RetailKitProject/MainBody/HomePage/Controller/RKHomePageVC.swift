//
//  RKHomePageVC.swift
//  RetailKitProject
//
//  Created by Sammy Chen on 28/11/2019.
//  Copyright © 2019 Geometry. All rights reserved.
//

import UIKit


class RKHomePageVC: UIViewController ,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var collectionView : UICollectionView?
    let Identifier       = "RKHomeCollectCell"
    let Identifier0       = "RKCollectHeaderCell"
    let Identifier1       = "RKCollectSignCell"

    let headerIdentifier = "CollectionFooterView"
    var projectCodeStr:String?
    
    var rowArr = [Any]()
    // 标记头部是否有赋值
    var isHave = false
    
        override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // 判断是否选择过项目
        let projectCode = UserDefaults.standard.object(forKey: "projectCode") as? String
        if let tempStr = projectCode {
            projectCodeStr = tempStr
            getData()
        }else {
            present(RKSeleteProjectVC.init(), animated: true) {
            }
        }
//            // 测试
//            present(RKSeleteProjectVC.init(), animated: true) {
//            }
        prepareUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(RefreshHomeWithProCodeNotification), name: NSNotification.Name(rawValue:RefreshHomeWithProCodeNotificationName), object: nil)
    }
    // 监听选中了项目
    @objc func RefreshHomeWithProCodeNotification() {
        
        let projectCode = UserDefaults.standard.object(forKey: "projectCode") as? String
        if let tempStr = projectCode {
            projectCodeStr = tempStr
        }else {
            projectCodeStr = ""
        }
        getData()
    }
    
    // footer高度
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section==0 {
            return CGSize.init(width: kScreenWidth, height: 15)
        }else if section==1 {
            return CGSize.init(width: kScreenWidth, height: 15)
        }
        return CGSize.init(width: kScreenWidth, height: 0)
    }
    // header高度
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: kScreenWidth, height: 0)
    }
    // 设定header和footer的方法，根据kind不同进行不同的判断即可
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        if kind == UICollectionView.elementKindSectionFooter {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: headerIdentifier, for: indexPath)
            footerView.backgroundColor = .groupTableViewBackground
            return footerView
        }
        return UICollectionReusableView.init()
    }

//    //header高度
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize.init(width: kScreenWidth, height: 180)
//    }

    // 设定header和footer的方法，根据kind不同进行不同的判断即可
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//
//        if kind == UICollectionView.elementKindSectionHeader {
//            let headerView : RKHomeHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier, for: indexPath) as! RKHomeHeaderView
//
////            if isHave == false {
//
//                let projectName = UserDefaults.standard.object(forKey: "projectName") as? String
//                let userName = UserDefaults.standard.object(forKey: "userName") as? String
//                let projectCode = UserDefaults.standard.object(forKey: "projectCode") as? String
//                let projectStarTime = UserDefaults.standard.object(forKey: "projectStarTime") as? Int
//                let projectEndTime = UserDefaults.standard.object(forKey: "projectEndTime") as? Int
//                // 赋值
//                if let tempStr = userName {
//                    headerView.niLabel.text = String(format: "姓名：%@", tempStr)
//                }
//                if let tempStr = projectName {
//                    headerView.nameLabel.text = String(format: "项目名称：%@", tempStr)
//                }
//                if let tempStr = projectCode {
//                    headerView.codeLabel.text = String(format: "项目代码：%@", tempStr)
//                }
//                if let tempStr = projectStarTime {
//                    headerView.startLabel.text = String(format: "开始时间：%@", String.formatTimeStamp(time: tempStr, format: "yyyy-MM-dd"))
//                }
//                if let tempStr = projectEndTime {
//                    headerView.endLabel.text = String(format: "结束时间：%@", String.formatTimeStamp(time: tempStr, format: "yyyy-MM-dd"))
//                }
////                isHave = true
////            }
//            return headerView
//        }
//        return UIView.init() as! UICollectionReusableView
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section==0 {
            return CGSize(width: kScreenWidth, height: 120)
        }else if indexPath.section==1 {
            return CGSize(width: kScreenWidth, height: 90)
        }
        return CGSize(width: self.view.frame.size.width/4, height: self.view.frame.size.width/4*1.3)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section==0 {
            return 1
        }else if section==1 {
            return 1
        }
        return rowArr.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section==0 {
            let cell:RKCollectHeaderCell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier0, for: indexPath) as! RKCollectHeaderCell
//            cell.projectModel = self.rowArr[indexPath.item] as! RKHomeColleModel
            cell.contentView.backgroundColor = .white
            return cell
        }else if indexPath.section==1 {
            let cell:RKCollectSignCell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier1, for: indexPath) as! RKCollectSignCell
//            cell.projectModel = self.rowArr[indexPath.item] as! RKHomeColleModel
            cell.contentView.backgroundColor = .white
            return cell
        }
        let cell:RKHomeCollectCell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier, for: indexPath) as! RKHomeCollectCell
        cell.contentView.backgroundColor = .white
        cell.projectModel = self.rowArr[indexPath.item] as! RKHomeColleModel
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        getTemplatedDetailData(indexPath: indexPath)
        
//      print(indexPath.row)
//        let vc = RKSeleteProjectVC.init()
//
//        if #available(iOS 13.0, *) {
//            vc.isModalInPresentation = true
//        } else {
//            // Fallback on earlier versions
//        }
//        if #available(iOS 13.0, *) {
//            vc.modalPresentationStyle = UIModalPresentationStyle.automatic
//        } else {
//            // Fallback on earlier versions
//        }
//       self.present(vc, animated: true, completion: nil)
    }

}

extension RKHomePageVC {
    
    // 创建UI
    private func prepareUI() {
        
        // 初始化
        let layout = UICollectionViewFlowLayout.init()
        
        collectionView = UICollectionView.init(frame: CGRect(x:0, y:0, width:kScreenWidth, height:kScreenHeight-CGFloat(kSafeAreaTopHeight)), collectionViewLayout: layout)
        collectionView?.backgroundColor = .white
        collectionView?.delegate = self
        collectionView?.dataSource = self
        self.view.addSubview(collectionView!)
        collectionView?.alwaysBounceVertical = true
        // 注册cell
        collectionView?.register(RKHomeCollectCell.self, forCellWithReuseIdentifier: "RKHomeCollectCell")
        collectionView?.register(RKCollectHeaderCell.self, forCellWithReuseIdentifier: "RKCollectHeaderCell")
        collectionView?.register(RKCollectSignCell.self, forCellWithReuseIdentifier: "RKCollectSignCell")

        // 注册headerView
        collectionView?.register(RKHomeHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: headerIdentifier)
        
    }
    
    // MARK: - 获取数据
        private func getData() {

            NetworkTools.sharedInstance.getModelListRequst(parameArr: [projectCodeStr!], success: { (respond) in
                
                let dict = respond as! [String : Any]
                let dataDict = dict["data"] as! [String : Any]
                let tempArr = dataDict["list"] as! [Any]
                
                if self.rowArr.count>0 {
                    self.rowArr.removeAll()
                }
                
                if tempArr.count==0 {
                    let model1 = RKHomeColleModel.init()
                    let model2 = RKHomeColleModel.init()
                    model1.model_name = "测试1"
                    model2.model_name = "测试2"
                    model1.model_logo = "home_icon"
                    model2.model_logo = "home_icon"
                    self.rowArr.append(model1)
                    self.rowArr.append(model2)
                }else {
                    for idx in 0..<tempArr.count {
                        let listDict = tempArr[idx]
                        let model: RKHomeColleModel = JsonUtil.dictionaryToModel(listDict as! [String : Any], RKHomeColleModel.self) as! RKHomeColleModel
                        model.modelId = model._id?["$oid"]
                        self.rowArr.append(model)
                    }
                }
                self.collectionView!.reloadData()
                
            }) { (error) in
                self.show(text: (error as! String))
            }
        }
        // MARK: - 获取模块详情
        private func getTemplatedDetailData(indexPath: IndexPath) {
            
            // 项目外部代码
            var project_code = UserDefaults.standard.object(forKey: "projectCode")as? String
            if project_code == nil {
               project_code = ""
            }
            // 门店id
            var store_id = UserDefaults.standard.object(forKey: "store_Id")as? String
            if store_id == nil {
               store_id = ""
            }
            // 档期代码
            var schedule_code = UserDefaults.standard.object(forKey: "schedule_code")as? String
            if schedule_code == nil {
               schedule_code = ""
            }
            // 模块代码
            let model = self.rowArr[indexPath.item] as! RKHomeColleModel
            let model_id = model.modelId
            
            NetworkTools.sharedInstance.getTemplatedDetailRequst(parameArr: [project_code!,store_id!,schedule_code!,model_id!], success: { (respond) in
                 
                 let dict = respond as! [String : Any]
                 let dataDict = dict["data"] as! [String : Any]
//                 let tempArr = dataDict["list"] as! [Any]
                 
//                 if tempArr.count==0 {
//                     let model1 = RKHomeColleModel.init()
//                     let model2 = RKHomeColleModel.init()
//                     model1.model_name = "测试1"
//                     model2.model_name = "测试2"
//                     model1.model_logo = "home_icon"
//                     model2.model_logo = "home_icon"
//                     self.rowArr.append(model1)
//                     self.rowArr.append(model2)
//                 }else {
//                     for idx in 0..<tempArr.count {
//                         let listDict = tempArr[idx]
//                         let model: RKHomeColleModel = JsonUtil.dictionaryToModel(listDict as! [String : Any], RKHomeColleModel.self) as! RKHomeColleModel
//                         self.rowArr.append(model)
//                     }
//                 }
    
                 self.collectionView!.reloadData()
                 
             }) { (error) in
                 self.show(text: (error as! String))
             }
         }
    
    
}
