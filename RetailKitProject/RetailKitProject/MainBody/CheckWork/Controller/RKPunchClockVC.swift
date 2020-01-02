//
//  RKPunchClockVC.swift
//  RetailKitProject
//
//  Created by Sammy Chen on 29/11/2019.
//  Copyright © 2019 Geometry. All rights reserved.
//

import UIKit


class RKPunchClockVC: UIViewController,LTSCalendarEventSource {
    
    // 日期中的事件
    var eventsByDate:NSMutableDictionary?
    // 显示当前选中的日期
    var label: UILabel?
    // 日历对象
    var manager: LTSCalendarManager?
    // 定时器
    var timerManager: PQ_TimerManager?
    // 当天
    var currentDay :String?
    
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        // 监听通知
        NotificationCenter.default.addObserver(self, selector: #selector(successCheckRefreshClick), name: NSNotification.Name(rawValue:"SuccessCheckRefresh"), object: nil)

    }
    
    // 打卡成功 进行刷新
    @objc func successCheckRefreshClick() {
        
        requestRecordDetail(seleteDay: currentDay!) {[weak self] (model) in
            
            let currModel = model as! RKDailyRecordModel
            if currModel.on_photo != nil && currModel.off_photo != nil {
                // 关闭计时器
                self!.timerManager?.pq_close()
            }
            if (self!.manager!.calenderScrollView!.refreshBlock != nil) {
                self!.manager!.calenderScrollView!.refreshBlock(["on_time":currModel.on_time as Any,"on_address":currModel.on_address as Any,"on_photo":currModel.on_photo as Any,"off_time":currModel.off_time as Any,"off_address":currModel.off_address as Any,"off_photo":currModel.off_photo as Any])
            }
        }
    }
    
    // 开启定时器
    func creatTimer() {
        
        timerManager = PQ_TimerManager.pq_createTimer(with: PQ_TIMERTYPE_CREATE_OPEN, updateInterval: 1, repeatInterval: 1, update: {
            // 从当前时间开始计时
            let timeStr = NSDate.getInternetDateString()
            if (self.manager!.calenderScrollView!.refreshCurrentTimeBlock != nil) {
                self.manager!.calenderScrollView!.refreshCurrentTimeBlock(timeStr)
            }
        })
    }
    
    private func prepareUI() {
        
        self.manager = LTSCalendarManager.init()
        self.manager!.eventSource = self
        self.manager!.weekDayView = LTSCalendarWeekDayView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 44))
        self.manager?.weekDayView.backgroundColor = UIColor.white
        self.view.addSubview(self.manager!.weekDayView)
        
        var scroH:CGFloat = 0
        if IS_IPHONEXAll {
            scroH = kScreenHeight - self.manager!.weekDayView.frame.maxY - 83 - 88
        }
        else {
            scroH = kScreenHeight - self.manager!.weekDayView.frame.maxY - 49 - 64
        }
        self.manager!.calenderScrollView = LTSCalendarScrollView.init(frame: CGRect(x: 0, y: self.manager!.weekDayView.frame.maxY, width: kScreenWidth, height: scroH))
        self.view.addSubview(self.manager!.calenderScrollView)
        self.automaticallyAdjustsScrollViewInsets = false
        // 跳转去打卡
        self.manager!.calenderScrollView.upBtnSrollBlock = { ()
            self.navigationController?.pushViewController(RKCheckWorkVC.init(), animated: true)
        }
        self.manager!.calenderScrollView.calendarScrollViewPhotoBlock = { [weak self] (photo) in
            
            self!.view.addSubview(self!.bigPhotoView)
            self!.photoImgView.kf.setImage(with: URL(string: photo!))
        }
        self.manager!.calenderScrollView.bounces = false
        self.manager!.calenderScrollView.backgroundColor = UIColor.white
    }
    
    
    @objc func imageBgViewClick() {
        // 拍照
//        print("~~~~~ 点击了背景")
        self.bigPhotoView.removeFromSuperview()
        
    }
    // 点击日期进行刷新
    func calendarDidSelectedDate(_ date: Date!) {
        
        let dateStr = date.dateFormatterWeekWithDate(date)
//        print("~~~~~~~~~ 选中的日期 %@",dateStr)
        if (self.manager!.calenderScrollView!.seleteCurrentDate != nil) {
            self.manager!.calenderScrollView!.seleteCurrentDate(date)
        }
        
        // 请求当天考勤数据
        let formatter = DateFormatter()
        let timeZone = TimeZone.init(identifier: "UTC")
        formatter.timeZone = timeZone
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = "yyyy-MM-dd"
        let str3 = formatter.string(from: date)
        // 选中日期 如果不是今天就刷新
        if !date.isToday() {
//            print("~~~~~~~~~ 不是今天")
            // 打开计时器
            self.creatTimer()
        }else {
            // 记录今天
            currentDay = str3
        }
        requestRecordDetail(seleteDay: str3) {[weak self] (model) in
//            print("~~~~~~~~~ 显示打卡详情")
            
            if model is String {
                
                print("~~~~~")
                if (self!.manager!.calenderScrollView!.refreshBlock != nil) {
                    self!.manager!.calenderScrollView!.refreshBlock(["on_time":"" as Any,"on_address":"" as Any,"on_photo":"" as Any,"off_time":"" as Any,"off_address":"" as Any,"off_photo":"" as Any])
                }
                return
            }
            
            let currModel = model as! RKDailyRecordModel
            if currModel.on_photo != nil && currModel.off_photo != nil {
                // 关闭计时器
                self!.timerManager?.pq_close()
            }else {
                // 打开计时器
                self!.creatTimer()
            }
            if (self!.manager!.calenderScrollView!.refreshBlock != nil) {
                self!.manager!.calenderScrollView!.refreshBlock(["on_time":currModel.on_time as Any,"on_address":currModel.on_address as Any,"on_photo":currModel.on_photo as Any,"off_time":currModel.off_time as Any,"off_address":currModel.off_address as Any,"off_photo":currModel.off_photo as Any])
            }
        }
    }
    
    private func requestRecordDetail(seleteDay :String ,success: @escaping successBlock) {
        
        NetworkTools.sharedInstance.getRecordDetailRequst(parameArr: [seleteDay], success: { (respond) in
            
            let dict = respond as! [String : Any]
            let dataDict = dict["data"]
            if !(dataDict is [String : Any]) {
//                print("~~~~~~~~~ 请求当天考勤成功")
                success("")
                return;
            }
            let model: RKDailyRecordModel = JsonUtil.dictionaryToModel(dataDict as! [String : Any], RKDailyRecordModel.self) as! RKDailyRecordModel
//            print("~~~~~~~~~ 请求当天考勤成功")
            success(model)
        }) { (error) in
            self.show(text: (error as! String))
        }
    }
    // 照片显示
    lazy var bigPhotoView :UIView = {
        let bigPhotoView = UIView.init()
        // 背景透明 子控件不透明
        bigPhotoView.backgroundColor = UIColor(white: 0, alpha: 0.9)
        bigPhotoView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(imageBgViewClick))
        bigPhotoView.addGestureRecognizer(singleTapGesture)
        bigPhotoView.isUserInteractionEnabled = true
        bigPhotoView.addSubview(self.photoImgView)
        return bigPhotoView
    }()
    lazy var photoImgView :UIImageView = {
        let photoImgView = UIImageView.init()
        photoImgView.backgroundColor = UIColor.black
        photoImgView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenWidth)
        photoImgView.center = CGPoint.init(x: kScreenWidth / 2.0, y: (kScreenHeight - (IS_IPHONEXAll ?88 :64) - (IS_IPHONEXAll ?83 :49)) / 2.0)
        photoImgView.contentMode = .scaleAspectFill
        return photoImgView
    }()
    
    deinit {
        // perform the deinitialization
//        print("~~~~~~~~~ 控制器销毁了")

    }
}
