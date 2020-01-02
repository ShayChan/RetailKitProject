//
//  RKSigninPageVC.swift
//  RetailKitProject
//
//  Created by Sammy Chen on 28/11/2019.
//  Copyright © 2019 Geometry. All rights reserved.
//

import UIKit

// f2936cb1c862bb99c0dae9396532f5e2   高德地图AppKey
//let kCalloutViewSignVCMargin: CGFloat = -8

// 照片赋值
//typealias SetValueSignVCBlock = (_ photo:UIImage) ->()

class RKSigninPageVC: DSBaseTableViewVC {

    
    static var page :NSInteger = 0
    var setValueVCBlock :SetValueVCBlock?
    //  选中的门店
    var seletStore:String?
    // 地图
    var mapView: MAMapView!
    // 定位按钮
    var gpsButton: UIButton!
    // 已经添加过标注
    var isHaveAnnotationView:Bool?
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 开启定位
        mapView.isShowsUserLocation = true
        mapView.userTrackingMode = MAUserTrackingMode.follow
        ///设置缩放比例，数值为3-20
        mapView.zoomLevel = 15;
        
        if !isHaveAnnotationView! {
            // 进来添加标注
//            addAnnotationWithCooordinate(coordinate: mapView.centerCoordinate)
        }
        
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationItem.title = "考勤"
        self.rowArr = [1,2,3,4]
        isHaveAnnotationView = false
        prepareUI()
        initMapView()
        initMapUI()
    }
        
    // MARK: - 点击方法
    
    private func takePhotoBlockVCClick() {
        // 拍照
        print("~~~~~ 拍照")
        showBottomAlert()
    }
    
    private func scalePhotoBlockVCClick(photoImg: UIImage) {
        // 点击照片放大
        print("~~~~~ 点击照片放大")
        self.view.addSubview(bigPhotoView)
        self.photoImgView.image = photoImg
    }
    
    @objc func imageBgViewClick() {
        // 拍照
        print("~~~~~ 点击了背景")
        self.bigPhotoView.removeFromSuperview()
        
    }
        
    // MARK: - UIMainBackgroundColor
    private func prepareUI() {
        
        self.view.backgroundColor = MainBackgroundColor
        self.view.addSubview(self.mainTableView)
        mainTableView.snp_makeConstraints({ (make) in
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.top.equalTo(self.view)
            make.bottom.equalTo(self.view)
        })
        mainTableView.register(RKLocationCell.self, forCellReuseIdentifier: "RKLocationCell")
        mainTableView.register(RKSeletedStoreCell.self, forCellReuseIdentifier: "RKSeletedStoreCell")
        mainTableView.register(RKTakePhotoCell.self, forCellReuseIdentifier: "RKTakePhotoCell")
        mainTableView.register(RKSignCell.self, forCellReuseIdentifier: "RKSignCell")
        mainTableView.estimatedRowHeight = 150*ScreenScaleY
        mainTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        mainTableView.backgroundColor = UIColor.white
        
    }
    
// MARK: - 列表数据源
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowArr.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        if indexPath.row==0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RKLocationCell", for: indexPath) as! RKLocationCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.backgroundColor = UIColor.white
            return cell
        }
        else if indexPath.row==1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RKSeletedStoreCell", for: indexPath) as! RKSeletedStoreCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.backgroundColor = UIColor.white
            if self.seletStore != nil {
                // 选中的门店
                cell.detailLabel.text = self.seletStore
//                cell.titleLabel.textColor = UIColor.black
            }
            return cell
        }
        else if indexPath.row==2 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "RKTakePhotoCell", for: indexPath) as! RKTakePhotoCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.backgroundColor = UIColor.white
            self.setValueVCBlock = cell.setValueBlock
            cell.takePhotoBlockClick = { ()
                // 拍照
                self.takePhotoBlockVCClick()
            }
            cell.scalePhotoBlockClick = { (photoImg: UIImage) in
                // 点击照片放大
                self.scalePhotoBlockVCClick(photoImg: photoImg)
            }
            return cell
        }
        else if indexPath.row==3 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "RKSignCell", for: indexPath) as! RKSignCell
                cell.selectionStyle = UITableViewCell.SelectionStyle.none
                cell.backgroundColor = UIColor.white
//            cell.checkBtnUpClick = { ()
//                self.navigationController?.popViewController(animated: true)
//                // 打卡成功刷新
//                NotificationCenter.default.post(name: NSNotification.Name("SuccessCheckRefresh"), object: self, userInfo: nil)
//            }
                return cell
        }
        return UITableViewCell.init()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            
        return UITableView.automaticDimension
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row==1 {
            
            let arr = NSMutableArray.init(array: ["金海湾门店","客村门店","鹭江门店","天河门店","海珠门店","中大门店"])
            let pickerView = RKPickerView.init(self, arr, .position)
            pickerView.pickerViewShow()
        }
    }
    
    // MARK: - 懒加载
//    lazy var mapView :UILabel = {
//        let view = UILabel.init()
//        view.text = "我是高德地图"
//        view.backgroundColor = .white
//        return view
//    }()
    lazy var bigPhotoView :UIView = {
        let bigPhotoView = UIView.init()
        // 背景透明 子控件不透明
        bigPhotoView.backgroundColor = UIColor(white: 0, alpha: 0.8)
        bigPhotoView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(imageBgViewClick))
        bigPhotoView.addGestureRecognizer(singleTapGesture)
        bigPhotoView.isUserInteractionEnabled = true
        bigPhotoView.addSubview(self.photoImgView)
        return bigPhotoView
    }()
    lazy var photoImgView :UIImageView = {
        let photoImgView = UIImageView.init()
        photoImgView.backgroundColor = UIColor.white
        photoImgView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenWidth)
        photoImgView.center = CGPoint.init(x: kScreenWidth / 2.0, y: (kScreenHeight - (IS_IPHONEXAll ?88 :64) - (IS_IPHONEXAll ?83 :49)) / 2.0)
//        photoImgView.center = CGPoint.init(x: kScreenWidth / 2.0, y: kScreenHeight / 2.0)
        photoImgView.contentMode = .scaleAspectFill
        return photoImgView
    }()
}

// MARK: - 地图
extension RKSigninPageVC: MAMapViewDelegate {
    
    // MARK: - 配置地图
        private func initMapView() {
            
            // 初始化地图
            mapView = MAMapView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 330*ScreenScaleX))
            mapView.delegate = self
            mainTableView.tableHeaderView = mapView
                                
            // 开启定位
            mapView.isShowsUserLocation = true
            mapView.userTrackingMode = MAUserTrackingMode.follow
            ///设置缩放比例，数值为3-20
            mapView.zoomLevel = 15;
            mapView.autoresizingMask = [UIView.AutoresizingMask.flexibleHeight, UIView.AutoresizingMask.flexibleWidth]

        }
    // MARK: - mapUI
    private func initMapUI() {
        
        gpsButton = self.makeGPSButtonView()
        gpsButton.center = CGPoint.init(x: kScreenWidth - gpsButton.bounds.width / 2 - 20, y:mapView.bounds.size.height -  gpsButton.bounds.width / 2 - 10)
        mapView.addSubview(gpsButton)
        gpsButton.autoresizingMask = [UIView.AutoresizingMask.flexibleTopMargin , UIView.AutoresizingMask.flexibleRightMargin]
        
    }
    
    //MARK: - MAMapViewDelegate
        func mapView(_ mapView: MAMapView!, didAddAnnotationViews views: [Any]!) {
            let annoationview = views.first as! MAAnnotationView
            
            if(annoationview.annotation .isKind(of: MAUserLocation.self)) {
                let rprt = MAUserLocationRepresentation.init()
    //            rprt.fillColor = UIColor.red.withAlphaComponent(0.4)
    //            rprt.strokeColor = UIColor.gray
    //            rprt.image = UIImage.init(named: "userPosition")
    //            rprt.lineWidth = 3
                
                // 精度圈
                rprt.showsAccuracyRing = false
                // 定位蓝点的图标
                rprt.image = UIImage.init(named: "ziyuan")
                // 执行
                mapView.update(rprt)
            }
        }
    
    // 添加标注图
    func addAnnotationWithCooordinate(coordinate: CLLocationCoordinate2D) {
        let annotation: MAPointAnnotation? = MAPointAnnotation()
        annotation?.coordinate = coordinate
        annotation?.title = "AutoNavi"
        annotation?.subtitle = "CustomAnnotationView"
        mapView.addAnnotation(annotation)
    }
    
    func makeGPSButtonView() -> UIButton! {
        let ret = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        ret.backgroundColor = UIColor.white
        ret.layer.cornerRadius = 4
        ret.setImage(UIImage.init(named: "gpsStat"), for: UIControl.State.normal)
        ret.addTarget(self, action: #selector(self.gpsAction), for: UIControl.Event.touchUpInside)
        return ret
    }
    
    @objc func gpsAction() {
        if(self.mapView.userLocation.isUpdating && self.mapView.userLocation.location != nil) {
            self.mapView.setCenter(self.mapView.userLocation.location.coordinate, animated: true)
            self.gpsButton.isSelected = true
        }
    }
    // MARK: - 自定义标注图
    func mapView(_ mapView: MAMapView!, viewFor annotation: MAAnnotation!) -> MAAnnotationView! {
        if annotation is MAPointAnnotation {
            
            let customReuseIndetifier: String = "CustomAnnotationView"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: customReuseIndetifier) as? CustomAnnotationView
            if annotationView == nil {
                isHaveAnnotationView = true
                annotationView = CustomAnnotationView.init(annotation: annotation, reuseIdentifier: customReuseIndetifier)
                annotationView?.backgroundColor = UIColor(white: 1, alpha: 0)
                annotationView?.canShowCallout = false
                annotationView?.isDraggable = true
                annotationView?.calloutOffset = CGPoint.init(x: 0, y: -5)
                // centerOffset
                annotationView?.centerOffset = CGPoint.init(x: 0, y: -44)
            }
//            annotationView?.portrait = UIImage.init(named: "hema")
//            annotationView?.name = "河马"
            return annotationView
        }
        return nil
    }
        
    //  点击标注
    func mapView(_ mapView: MAMapView!, didSelect view: MAAnnotationView!) {
        if view is CustomAnnotationView {
            let cusView = view as! CustomAnnotationView
            var frame: CGRect = cusView.convert(cusView.calloutView.frame, to: mapView)
            frame = frame.inset(by: UIEdgeInsets.init(top: kCalloutViewMargin, left: kCalloutViewMargin, bottom: kCalloutViewMargin, right: kCalloutViewMargin))
            if !mapView.frame.contains(frame) {
                let offset: CGSize = offsetToContainRect(innerRect: frame, outerRect: mapView.frame)
                var theCenter: CGPoint = mapView.center
                theCenter = CGPoint.init(x: theCenter.x - offset.width, y: theCenter.y - offset.height)
                let coordinate: CLLocationCoordinate2D = mapView.convert(theCenter, toCoordinateFrom: mapView)
                mapView.setCenter(coordinate, animated: true)
            }
        }
    }
    
    func offsetToContainRect(innerRect: CGRect, outerRect: CGRect) -> CGSize {
        let nudgeRight: CGFloat = CGFloat.maximum(0, outerRect.minX - innerRect.minX)
        let nudgeLeft: CGFloat = CGFloat.minimum(0, outerRect.maxX - innerRect.maxX)
        let nudgeTop: CGFloat = CGFloat.maximum(0, outerRect.minY - innerRect.minY)
        let nudgeBottom: CGFloat = CGFloat.minimum(0, outerRect.maxY - innerRect.maxY)
        return CGSize.init(width: nudgeLeft == 0 ? 0 : nudgeRight , height: nudgeTop == 0 ? 0: nudgeBottom)
    }
}

// MARK: - 拍照
extension RKSigninPageVC:UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
    // 拍照功能
    func showBottomAlert() {
        self.goCamera()

        // 底部弹框
//        let alertController=UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
//        let cancel=UIAlertAction(title:"取消", style: .cancel, handler: nil)
//        let takingPictures=UIAlertAction(title:"拍照", style: .default) {
//            action in
//            self.goCamera()
//        }
//        let localPhoto=UIAlertAction(title:"本地图片", style: .default) {
//            action in
//            self.goImage()
//        }
//        alertController.addAction(cancel)
//        alertController.addAction(takingPictures)
//        alertController.addAction(localPhoto)
//        self.present(alertController, animated:true, completion:nil)
    }

    // 拍照与本地相册方法
    func goCamera() {
                    
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let  cameraPicker = UIImagePickerController()
            cameraPicker.delegate = self
            cameraPicker.allowsEditing = true
            cameraPicker.sourceType = .camera
//            cameraPicker.cameraDevice = .front
            // 在需要的地方present出来
            self.present(cameraPicker, animated: true, completion: nil)
        } else {
            print("不支持拍照")
            self.show(text: "该设备不支持拍照")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        print("获得照片============= \(info)")
        let image : UIImage = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        // 显示设置的照片
//      imgView.image = image
        if (self.setValueVCBlock != nil) {
            self.setValueVCBlock!(image)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
//    // 去相册
//    func goImage() {
//
//        let photoPicker =  UIImagePickerController()
//        photoPicker.delegate = self
//        photoPicker.allowsEditing = true
//        photoPicker.sourceType = .photoLibrary
//        //在需要的地方present出来
//        self.present(photoPicker, animated: true, completion: nil)
//
//    }
    
}

// MARK: - 选择框
extension RKSigninPageVC:PickerDelegate {

    func selectedNonPosition(_ pickerView: RKPickerView, _ positionStr: String) {
        self.show(text: "请选择门店")
    }
    
    func selectedPosition(_ pickerView: RKPickerView, _ positionStr: String) {
        self.seletStore = positionStr
        if seletStore != nil {
            let indexPath = IndexPath(item: 1, section: 0)
            mainTableView.reloadRows(at: [indexPath], with: .none)
        }
    }
    
    func selectedAddress(_ pickerView: RKPickerView, _ procince: AddressModel, _ city: AddressModel, _ area: AddressModel) {
        
    }
    
    func selectedDate(_ pickerView: RKPickerView, _ dateStr: Date) {
        
    }
    
    func selectedGender(_ pickerView: RKPickerView, _ genderStr: String) {
        
    }
    
    
}
