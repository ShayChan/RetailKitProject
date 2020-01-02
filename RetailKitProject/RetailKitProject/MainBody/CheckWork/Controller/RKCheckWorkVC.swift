//
//  RKCheckWorkVC.swift
//  RetailKitProject
//
//  Created by Sammy Chen on 28/11/2019.
//  Copyright © 2019 Geometry. All rights reserved.
//

import UIKit

// f2936cb1c862bb99c0dae9396532f5e2   高德地图AppKey
let kCalloutViewMargin: CGFloat = -8


// 照片赋值
typealias SetValueVCBlock = (_ photo:UIImage) ->()

class RKCheckWorkVC: DSBaseTableViewVC,MAMapViewDelegate,AMapLocationManagerDelegate {

    let defaultLocationTimeout = 6
    let defaultReGeocodeTimeout = 6
    
    static var page :NSInteger = 0
    var setValueVCBlock :SetValueVCBlock?
    //  选中的门店
    var seletStore: String?
    //  选中的门店模型
    var seletStoreModel: RKStoreModel?
    // 门店列表
    var storeListArr = [String]()
    // 门店列表模型
    var storeModelArr = [RKStoreModel]()
    // 地图
    var mapView: MAMapView!
    // 定位按钮
    var gpsButton: UIButton!
    // 定位
    var completionBlock: AMapLocatingCompletionBlock!
    lazy var locationManager = AMapLocationManager()
    // 经纬度
    static var currentLocation: CLLocation!
    // 打卡地址
    var recordAddress = ""
    // 已经添加过标注
    var isHaveAnnotationView:Bool?
    // 定时器
    var timerManager: PQ_TimerManager?
    // 瞬时时间
    var currentTime = ""
    // 照片
    var photo :UIImage?
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 打开计时器
        creatTimer()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 关闭计时器
        timerManager?.pq_close()
        print("~~~~~ ")
    }
    
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
        initLocationManager()
    }
    
    // 开启定时器
    func creatTimer() {
        
        timerManager = PQ_TimerManager.pq_createTimer(with: PQ_TIMERTYPE_CREATE_OPEN, updateInterval: 1, repeatInterval: 1, update: {
            // 从当前时间开始计时
            let timeStr = NSDate.getInternetDateString()
            self.currentTime = timeStr
            let indexPath = IndexPath(item: 3, section: 0)
            self.mainTableView.reloadRows(at: [indexPath], with: .none)
        })
    }
        
    // MARK: - 点击方法
    
    // 打卡功能
    private func checkBtnUpClickSuccessClick() {
        // 打卡
        print("~~~~~ 打卡")
        // 照片
        if self.photo == nil {
            self.show(text: "请拍照打卡")
            return
        }
        // 上传照片
        
        // 测试 上传照片
        NetworkTools.sharedInstance.requestUpload(urlString: "http://base-serve-icmcenter.gpossible.com/uploadFile/retailkit?unzip=true", params: ["":""], images: [self.photo!], success: { (respond) in

            let dict = respond as! [String : Any]
            let photoStr = dict["data"] as! String
            
            let photoAllStr = String(format: "http://base-serve-icmcenter.gpossible.com%@", photoStr)
            
            self.getDailyRecordData(completionBlock: { [weak self] in
                
                self?.navigationController?.popViewController(animated: true)
                NotificationCenter.default.post(name: NSNotification.Name("SuccessCheckRefresh"), object: self, userInfo: nil)
                
            }, photoStr: photoAllStr)
            
            
        }) { (error) in
            self.show(text: (error as! String))
        }
    }
    
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
        mainTableView.register(RKCheckBtnCell.self, forCellReuseIdentifier: "RKCheckBtnCell")
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "RKCheckBtnCell", for: indexPath) as! RKCheckBtnCell
                cell.selectionStyle = UITableViewCell.SelectionStyle.none
                cell.backgroundColor = UIColor.white
            cell.checkBtnUpClick = { ()
                self.checkBtnUpClickSuccessClick()
            }
            cell.currentTime = self.currentTime
            return cell
        }
        return UITableViewCell.init()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row==1 {
            
            getStoreData { (storeList) in
                let arr = NSMutableArray.init(array: storeList)
                let pickerView = RKPickerView.init(self, arr, .position)
                pickerView.pickerViewShow()
            }
        }
    }
    
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
        photoImgView.contentMode = .scaleAspectFill
        return photoImgView
    }()
    
    
    deinit {
        print("~~~~~~~~~ 控制器销毁了")
    }
}

// MARK: - 地图
extension RKCheckWorkVC {
    
    // 定位回调
    func amapLocationManager(_ manager: AMapLocationManager!, didUpdate location: CLLocation!, reGeocode: AMapLocationReGeocode?) {
        print("location:{lat:\(location.coordinate.latitude); lon:\(location.coordinate.longitude); accuracy:\(location.horizontalAccuracy);};");
//        weak var weakSelf = self
//        weakSelf?.currentLocation = location
        if let reGeocode = reGeocode {
            NSLog("reGeocode:%@", reGeocode)
        }
    }
   
    // MARK: - 配置地图
    private func initMapView() {
        
        // 初始化地图
        mapView = MAMapView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 330*ScreenScaleX))
        weak var weakSelf = self
        mapView.delegate = weakSelf!
        mainTableView.tableHeaderView = mapView
        // 开启定位
        mapView.isShowsUserLocation = true
        mapView.userTrackingMode = MAUserTrackingMode.follow
        //设定定位的最小更新距离
        mapView.distanceFilter=16.0
        //设定定位精度
        mapView.desiredAccuracy = kCLLocationAccuracyBestForNavigation
//        mapView.desiredAccuracy = kCLLocationAccuracyBest
        //追踪用户的location更新
        mapView.setUserTrackingMode(MAUserTrackingMode.follow, animated: true)
        ///设置缩放比例，数值为3-20
        mapView.zoomLevel = 15;
        //是否显示罗盘，默认为YES
        mapView.showsCompass = false
        //是否显示比例尺，默认为YES
        mapView.showsScale = false
        mapView.autoresizingMask = [UIView.AutoresizingMask.flexibleHeight, UIView.AutoresizingMask.flexibleWidth]
        
    }
    // MARK: - 开始定位
    private func initLocationManager() {
        
        weak var weakSelf = self
        locationManager.delegate = weakSelf
        locationManager.distanceFilter = 16.0
        // 带逆地理信息的一次定位（返回坐标和地址信息）
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        //   定位超时时间，最低2s，此处设置为2s
        locationManager.locationTimeout = defaultLocationTimeout
        //   逆地理请求超时时间，最低2s，此处设置为2s
        locationManager.reGeocodeTimeout = defaultReGeocodeTimeout
        locationManager.pausesLocationUpdatesAutomatically = true
        locationManager.allowsBackgroundLocationUpdates = true

//         带逆地理（返回坐标和地址信息）。将下面代码中的 true 改成 false ，则不会返回地址信息。
        locationManager.requestLocation(withReGeocode: true, completionBlock: { (location: CLLocation?, reGeocode: AMapLocationReGeocode?, error: Error?) in

            if let error = error {
                let error = error as NSError

                if error.code == AMapLocationErrorCode.locateFailed.rawValue {
                    //定位错误：此时location和regeocode没有返回值，不进行annotation的添加
                    NSLog("定位错误:{\(error.code) - \(error.localizedDescription)};")
                    return
                }
                else if error.code == AMapLocationErrorCode.reGeocodeFailed.rawValue
                    || error.code == AMapLocationErrorCode.timeOut.rawValue
                    || error.code == AMapLocationErrorCode.cannotFindHost.rawValue
                    || error.code == AMapLocationErrorCode.badURL.rawValue
                    || error.code == AMapLocationErrorCode.notConnectedToInternet.rawValue
                    || error.code == AMapLocationErrorCode.cannotConnectToHost.rawValue {

                    //逆地理错误：在带逆地理的单次定位中，逆地理过程可能发生错误，此时location有返回值，regeocode无返回值，进行annotation的添加
                    NSLog("逆地理错误:{\(error.code) - \(error.localizedDescription)};")
                }
                else {
                    //没有错误：location有返回值，regeocode是否有返回值取决于是否进行逆地理操作，进行annotation的添加
                }
            }
            var addressInfo: String = ""
            if let location = location {
                NSLog("location:%@", location)
                RKCheckWorkVC.currentLocation = location
                addressInfo.append("经纬度：\(location.coordinate) \n")
            }
            if let reGeocode = reGeocode {

                addressInfo.append("国家：\(String(describing: reGeocode.country))\n")
                addressInfo.append("省份：\(String(describing: reGeocode.province))\n")
                addressInfo.append("城市：\(String(describing: reGeocode.city))\n")
                addressInfo.append("区：\(String.init(format: "%@", reGeocode.district))\n")
                addressInfo.append("街道：\(String.init(format: "%@", reGeocode.street))\n")
                addressInfo.append(contentsOf: "详细地址：\(String(describing: reGeocode.formattedAddress))\n")
            }
            print("~~~~ ：%@",addressInfo)
            print("~~~~ 定位地址为：%@",String(format: "%@",reGeocode!.formattedAddress))
            self.recordAddress = String(format: "%@",reGeocode!.formattedAddress)
        })
        locationManager.locatingWithReGeocode = true
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
                annotationView?.centerOffset = CGPoint.init(x: 0, y: -44)
            }
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
extension RKCheckWorkVC:UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
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
            weak var weakSelf = self
            cameraPicker.delegate = weakSelf!
            cameraPicker.allowsEditing = true
            cameraPicker.sourceType = .camera
//            cameraPicker.cameraDevice = .front
            self.present(cameraPicker, animated: true, completion: nil)
        } else {
            print("不支持拍照")
            self.show(text: "该设备不支持拍照")
        }
    }
    
    // MARK: - 获取到照片
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

//        print("获得照片============= \(info)")
        let image : UIImage = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
                
//        let jpegImageData = image.jpegData(compressionQuality: 0.5)
//        let jpegImageStr = String(data: jpegImageData!, encoding: String.Encoding.utf8)
//        photoStr = jpegImageStr!
        
        self.photo = image
        // 显示设置的照片
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
//    }
    
}

// MARK: - 选择框
extension RKCheckWorkVC:PickerDelegate {
    
    func selectedNonPosition(_ pickerView: RKPickerView, _ positionStr: String) {
        self.show(text: "请选择门店")
    }
    
    func selectedPosition(_ pickerView: RKPickerView, _ positionStr: String) {
        self.seletStore = positionStr
        if seletStore != nil {
            let indexPath = IndexPath(item: 1, section: 0)
            mainTableView.reloadRows(at: [indexPath], with: .none)
        }
        // 选中的门店模型
        if !storeListArr.isEmpty {
            for idx in 0..<storeModelArr.count {
                let model :RKStoreModel = storeModelArr[idx]
                if positionStr == model.store_name {
                    self.seletStoreModel = model
                }
            }
        }
    }
    
    func selectedAddress(_ pickerView: RKPickerView, _ procince: AddressModel, _ city: AddressModel, _ area: AddressModel) {
        
    }
    
    func selectedDate(_ pickerView: RKPickerView, _ dateStr: Date) {
        
    }
    
    func selectedGender(_ pickerView: RKPickerView, _ genderStr: String) {
        
    }
    
    // MARK: - 获取门店列表
    private func getStoreData(completionBlock: @escaping (_ storeList: [Any]) -> ()) {
        // 外部项目代码 经度 纬度
        var projectCode = UserDefaults.standard.object(forKey: "projectCode") as? String
        if projectCode == nil {
            projectCode = ""
        }
        var scheduleCode = UserDefaults.standard.object(forKey: "schedule_code") as? String
        if scheduleCode == nil {
            scheduleCode = ""
        }
        let longitude = RKCheckWorkVC.currentLocation.coordinate.longitude
        let latitude = RKCheckWorkVC.currentLocation.coordinate.latitude
        var longitudeStr = ""
        var latitudeStr = ""
        if longitude != 0 {
            longitudeStr = String(format: "%lf", RKCheckWorkVC.currentLocation.coordinate.longitude)
        }
        if latitude != 0 {
            latitudeStr = String(format: "%lf", RKCheckWorkVC.currentLocation.coordinate.latitude)
        }
        
        NetworkTools.sharedInstance.getStroeListRequst(parameArr: [projectCode!,scheduleCode!,longitudeStr,latitudeStr], success: { (respond) in
            
            if !self.storeModelArr.isEmpty {
                self.storeModelArr.removeAll()
            }
            if !self.storeListArr.isEmpty {
                self.storeListArr.removeAll()
            }
            let dict = respond as! [String : Any]
            let dataDict = dict["data"] as! [String : Any]
            let tempArr = dataDict["list"] as! [Any]
            self.storeListArr.append("请选择门店")
            for idx in 0..<tempArr.count {
                let listDict = tempArr[idx]
                let model: RKStoreModel = JsonUtil.dictionaryToModel(listDict as! [String : Any], RKStoreModel.self) as! RKStoreModel
                model.storeId = model._id?["$oid"]
                self.storeModelArr.append(model)
                self.storeListArr.append(model.store_name!)
                UserDefaults.standard.set(model.storeId, forKey: "store_Id")
                UserDefaults.standard.synchronize()
            }
            completionBlock(self.storeListArr)
        }) { (error) in
            self.show(text: (error as! String))
        }
    }
    
    // MARK: - 下班打卡
    func getDailyRecordData(completionBlock: @escaping () -> () , photoStr: String) {
        
        // 外部项目id 经度 纬度
        var projectId = UserDefaults.standard.object(forKey: "projectId") as? String
        if projectId == nil {
           projectId = ""
        }
        // 门店id
        if seletStoreModel?.storeId == nil {
            seletStoreModel?.storeId = ""
            self.show(text: "请选择门店")
            return
        }
        // 照片
        if self.photo == nil {
            self.show(text: "请拍照打卡")
            return
        }
        // 打卡类型
        let date = NSDate.getInternet()

        //如果是今天的时间
        if !date.isToday() {
            print("~~~ 不是今天的时间")
            UserDefaults.standard.set(nil, forKey: "Did_DailyRecord")
            UserDefaults.standard.synchronize()
        }
        let did_DailyRecord = UserDefaults.standard.object(forKey: "Did_DailyRecord")
        var dailyRecordType = ""
        if did_DailyRecord == nil {
            // 上班卡
            dailyRecordType = "on"
            UserDefaults.standard.set(dailyRecordType, forKey: "Did_DailyRecord")
            UserDefaults.standard.synchronize()
        }else {
            // 下班卡
            dailyRecordType = "off"
            UserDefaults.standard.set(nil, forKey: "Did_DailyRecord")
            UserDefaults.standard.synchronize()
        }
//        // 测试
//        if dailyRecordType == "off" {
//            dailyRecordType = "on"
//        }
        // 地址
        var longitude = String(format: "%lf", RKCheckWorkVC.currentLocation.coordinate.longitude)
        if longitude.length==0 {
            longitude = ""
        }
        var latitude = String(format: "%lf", RKCheckWorkVC.currentLocation.coordinate.latitude)
        if latitude.length==0 {
            latitude = ""
        }
        
        NetworkTools.sharedInstance.getDailyRecordRequst(parameArr: [projectId!,seletStoreModel!.storeId!,dailyRecordType,self.recordAddress,longitude,latitude,photoStr], success: { (respond) in

            let dict = respond as! [String : Any]
            let str = dict["message"] as! String
            self.show(text: String(format: "测试：%@", str))
            completionBlock()
        }) { (error) in
            self.show(text: (error as! String))
        }
    }
}
