//
//  AppDelegate.swift
//  Msg-Notification
//
//  Created by seonho on 2022/03/28.
//

import UIKit
import UserNotifications


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if #available(iOS 11.0, *){
            //경고창, 배지, 사운드를 사용하는 알림 환경정보를 생성하고, 사용자의 동의 여부 창을 실행
            let notiCenter = UNUserNotificationCenter.current()
            notiCenter.requestAuthorization(options: [.alert, .badge, .sound]) {
                (didAllow, e) in
            }
            //notiCenter.delegate = self
        }else{
            //경고창, 배지, 사운드를 사용하는 알림 환경 정보를 생성하고, 이를 애플리케이션에 저장
            let setting = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(setting)
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


    //앱이 활성화 상태를 잃었을때
    func applicationWillResignActive(_ application: UIApplication) {
        if #available(iOS 10.0, *){ //UserNotification 프레임워크를 이용한 로컬 알림 (iOS 10 이상)
            //알림 동의 여부를 확인
            UNUserNotificationCenter.current().getNotificationSettings{
                settings in if settings.authorizationStatus == UNAuthorizationStatus.authorized{
                    //알림 콘텐츠 객체
                    let nContent = UNMutableNotificationContent()
                    nContent.badge = 1
                    nContent.title = "로컬 알림 메시지"
                    nContent.subtitle = "준비된 내용이 아주 많아요! 얼른 다시 앱을 열어주세요!"
                    nContent.body = "앗! 왜 나갔어요! 어서 들어오세요!"
                    nContent.sound = UNNotificationSound.default
                    nContent.userInfo = ["name" : "홍길동"]
                    
                    //알림 발송 조건 객체
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval:5, repeats : false)
                    
                    //알림 요청 객체
                    let request = UNNotificationRequest(identifier:"wakeup", content:nContent, trigger:trigger)
                    
                    //노티피케이션 센터에 추가
                    UNUserNotificationCenter.current().add(request)
                }else{
                    print("사용자가 동의하지않음")
                }
            
            }
        }else{ //UILocalNotification 객체를 이용한 로컬 알림 (IOS 9 이하)
            //알림 설정 확인
            let setting = application.currentUserNotificationSettings
            //알림 성정이 되어 있지 않다면, 로컬 알림도 보내도 받을 수 없으므로 종료함
            guard setting?.types != .none else {
                print("Can't schedule")
                return
            }
            
            //로컬 알람 인스턴스 생성
            let noti = UILocalNotification()
            noti.fireDate = Date(timeIntervalSinceNow: 10) //10초후 발송
            noti.timeZone = TimeZone.autoupdatingCurrent //현재 위치에 따라 타임존 설정
            noti.alertBody = "얼른 다시 접속하세요!!!" //표시될 메시지
            noti.alertAction = "학습하기" //잠금 상태 일 때 표시될 액션
            noti.applicationIconBadgeNumber = 1 //앱 아이콘 모서리에 표시될 배지
            noti.soundName = UILocalNotificationDefaultSoundName //로컬 알람 도착시 사운드
            noti.userInfo = ["name":"홍길동"]
            
            //생성된 알람 객체를 스케쥴러에 등록
            application.scheduleLocalNotification(noti)
        }
    }
    
    //앱 실행 도중 알림 메시지가 도착한 경우
    @available(iOS 10.0, *)
    func userNotification(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void){
        if notification.request.identifier == "wakeup"{
            let userInfo = notification.request.content.userInfo
            print(userInfo["name"]!)
        }
        
        //알림 배너 띄우기
        completionHandler([.alert, .badge, .sound])
    }

    
    //사용자가 알림 메시지를 클릭 했을 경우
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping() -> Void){
        if response.notification.request.identifier == "wakeup" {
            let userInfo = response.notification.request.content.userInfo
            print(userInfo["name"]!)
        }
        completionHandler()
    }
}

