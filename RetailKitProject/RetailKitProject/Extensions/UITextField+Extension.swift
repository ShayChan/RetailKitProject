//
//  UITextField+Extension.swift
//  DawsonICMItem
//
//  Created by Sammy Chen on 29/10/2019.
//  Copyright © 2019 Geometry. All rights reserved.
//

import UIKit


// 默认字体大小
var maxTextNumberDefault = 16*ScreenScaleX

extension UITextField {
    
    // MARK: - 动画改变字体大小扩展
    /// 使用runtime给textField添加最大输入数属性,默认16
    var maxTextNumber: Int {
        set {
            objc_setAssociatedObject(self, &maxTextNumberDefault, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            if let max = objc_getAssociatedObject(self, &maxTextNumberDefault) as? Int {
                return max
            }
            return Int(16*ScreenScaleX)
        }
    }
    /// 添加判断数量方法
    func addChangeTextTarget() {
        self.addTarget(self, action: #selector(changeText), for: .editingChanged)
    }
    @objc func changeText() {
        //判断是不是在拼音状态,拼音状态不截取文本
        if let positionRange = self.markedTextRange {
            guard self.position(from: positionRange.start, offset: 0) != nil else {
                checkTextFieldText()
                return
            }
        } else {
            checkTextFieldText()
        }
    }
    /// 判断已输入字数是否超过设置的最大数.如果是则截取
    func checkTextFieldText() {
        guard (self.text?.length)! <= maxTextNumber  else {
            self.text = (self.text?.stringCut(end: maxTextNumber))!
            return
        }
    }
    
    // MARK: - 代理事件扩展
    private struct RuntimeKey {
        static let hw_TextFieldKey = UnsafeRawPointer.init(bitPattern: "hw_TextField".hashValue)
        /// ...其他Key声明
    }
    /// 运行时关联
    var hw: hw_TextField {
        set {
            objc_setAssociatedObject(self, UITextField.RuntimeKey.hw_TextFieldKey!, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            var obj = objc_getAssociatedObject(self, UITextField.RuntimeKey.hw_TextFieldKey!) as? hw_TextField
            if obj == nil { // 没有是手动创建 并进行绑定
                obj = hw_TextField.init(self)
                objc_setAssociatedObject(self, UITextField.RuntimeKey.hw_TextFieldKey!, obj, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
            return obj!
        }
    }
    
}

// MARK: - 动画改变字体大小扩展
extension String {

    var length: Int {
        ///更改成其他的影响含有emoji协议的签名
        return self.utf16.count
    }
    /// 截取第一个到第任意位置
    ///
    /// - Parameter end: 结束的位值
    /// - Returns: 截取后的字符串
    func stringCut(end: Int) -> String {
        if !(end <= count) { return self }
        let sInde = index(startIndex, offsetBy: end)
        return String(self[..<sInde])
    }
}

// MARK: - 代理事件扩展
class hw_TextField: NSObject, UITextFieldDelegate {
    private weak var tf: UITextField? // 定义属性用于临时记录
    /// 值改变回调
    var valuesChangeBlock: ((String)->())?
    /// 结束编辑回调(未输入是不会回调)
    var endEditingBlock: ((String)->())?
    /// 开始编辑
    var beginEditingBlock:(()->())?
    /// 是否是人民币输入
    @discardableResult
    func isMoeeyEidtor(_ isMoeey: Bool) -> hw_TextField {
        isMoeeyEidtor = isMoeey
        return self
    }
    private var _isMoeeyEidtor =  false
    private var pointlocation:Int = -1 // 用于记录小数点位置
    private var isMoeeyEidtor : Bool {
        set {
            _isMoeeyEidtor = newValue
            self.tf?.keyboardType = .decimalPad
        }
        get {
            return _isMoeeyEidtor
        }
    }
    
    convenience init(_ tf: UITextField) {
        self.init()
        self.tf = tf
        self.tf?.delegate = self
        self.tf!.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
    }
    @objc private func editingChanged() {
        if valuesChangeBlock == nil {return}
        valuesChangeBlock!(tf?.text ?? "")
    }
    
    override init() {
        super.init()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if endEditingBlock == nil {return}
        if (textField.text ?? "").isEmpty {return}
        endEditingBlock!(textField.text ?? "")
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if beginEditingBlock == nil {return}
        beginEditingBlock!()
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if isMoeeyEidtor == true {
            if string == "."{ // 记录小数点位置
                pointlocation = range.location
            }
            if range.location == 0 { // 首位不能为小数点
                if string == "." { return false }
            }
            if textField.text == "0"{
                if string == "." || string == "" {
                    return true
                } else {
                    return false
                }
            }
            if (textField.text?.contains("."))! { // 包含小数点 后面不能再输入小数点
                if string == "." {  return false }
            }
            if pointlocation != -1 {
                if range.location > pointlocation + 2 {  return false } // 小数点后2位
            }
        }
        return true
    }
    deinit {
        self.tf?.delegate = nil
    }
}
