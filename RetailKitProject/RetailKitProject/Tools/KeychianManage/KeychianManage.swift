//
//  DSKeychianManage.swift
//  DawsonICMItem
//
//  Created by Sammy Chen on 4/11/2019.
//  Copyright © 2019 Geometry. All rights reserved.
//

import UIKit


enum KeychainError: Error {
    case lackAttributes
    case infoEmpty
    case unexpectedData
    case unhandledError(status: OSStatus)
}

class KeychianManage: NSObject {

    /// Get Token Of Current Account 获取活期账户令牌
    ///
    /// - Parameter account:
    /// - Returns: Token
    /// - Throws: KeychainError
    public class func fetchAllToken()throws -> [String:String]  {
        do {
            return try KeychianQuery.fetchAllKeychainData()
        } catch {
            throw error}
    }
    
    /// Get Token Of Current Account 
    ///
    /// - Parameter account: <#account description#>
    /// - Returns: Token
    /// - Throws: KeychainError
    public class func fetchCurrentToken(_ account:String)throws -> String?  {
        do {
            return try KeychianQuery.fetchKeychainData(account: account)
        } catch {
            throw error}
    }
    
    /// Update Token Of Existed Account 更新已有帐户的令牌
    ///
    /// - Parameters:
    ///   - Token_: <#Token_ description#>
    ///   - account_: <#account_ description#>
    /// - Throws: KeychainError
    public class func saveAccoutToken(_ account_:String, token_:String)throws {
        do {
            try KeychianQuery.saveKeychainData(account: account_, accoutInfo: token_)
        } catch {
            throw error}
    }

    /// Delete Token Of Existed Account 删除现有帐户的令牌
    ///
    /// - Parameter account_: <#account_ description#>
    /// - Throws: KeychainError
    public class func deleteAccoutInfo(_ account_:String)throws {
        do {
            try KeychianQuery.deleteKeychainData(account: account_)
        } catch {
            throw error}
    }
    
    /// Delete All Token
    ///
    /// - Throws: KeychainError
    public class func deleteAllAccoutInfo()throws {
        do {
            try KeychianQuery.deleteAllKeychainData()
        } catch {
            throw error}
    }
}
