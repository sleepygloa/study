//
//  UserInfoManager.swift
//  MyMemory
//
//  Created by seonho on 2022/05/12.
//

import UIKit

struct UserInfoKey{
    //저장에 사용할 키
    static let loginId = "LOGINID"
    static let account = "ACCOUNT"
    static let name = "NAME"
    static let profile = "PROFILE"
}

class UserInfoManager{
    var loginId : Int {
        get{
            return UserDefaults.standard.integer(forKey: UserInfoKey.loginId)
        }
        set(v){
            let ud = UserDefaults.standard
            ud.set(v, forKey: UserInfoKey.loginId)
            ud.synchronize()
        }
    }
    var account : String? {
        get{
            return UserDefaults.standard.string(forKey: UserInfoKey.account)
        }
        set(v){
            let ud = UserDefaults.standard
            ud.set(v, forKey: UserInfoKey.account)
            ud.synchronize()
        }
    }
    var name : String? {
        get{
            return UserDefaults.standard.string(forKey: UserInfoKey.name)
        }
        set(v){
            let ud = UserDefaults.standard
            ud.set(v, forKey: UserInfoKey.name)
            ud.synchronize()
        }
    }
    var profile : UIImage? {
        get{
            let ud = UserDefaults.standard
            if let _profile = ud.data(forKey: UserInfoKey.profile) {
                return UIImage(data: _profile)
            }else{
                return UIImage(named: "account.jpg")
            }
        }
        set(v){
            if v != nil {
                let ud = UserDefaults.standard
                ud.set(v!.pngData(), forKey: UserInfoKey.profile)
                ud.synchronize()
            }
        }
    }
    var isLogin : Bool {
        if self.loginId == 0 || self.account == nil {
            return false
        }else{
            return true
        }
    }
    
    func login(account: String, passwd: String) -> Bool {
        // TODO : 이 부분은 나중에 서버와 연동되는 코드로 대체될 예정입니다
        if account.isEqual("sqlpro@naver.com") && passwd.isEqual("1234") {
            let ud = UserDefaults.standard
            ud.set(100, forKey: UserInfoKey.loginId)
            ud.set(account, forKey: UserInfoKey.account)
            ud.set("재은씨", forKey: UserInfoKey.name)
            ud.synchronize()
            return true
        }else{
            return false
        }
    }
    
    func logout() -> Bool {
        let ud = UserDefaults.standard
        ud.removeObject(forKey: UserInfoKey.loginId)
        ud.removeObject(forKey: UserInfoKey.account)
        ud.removeObject(forKey: UserInfoKey.name)
        ud.removeObject(forKey: UserInfoKey.profile)
        ud.synchronize()
        return true
    }
}
