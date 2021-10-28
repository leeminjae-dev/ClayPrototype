
import SwiftUI
import Firebase
import FirebaseFirestore

// Configuring Firebase Push Notifications...
// See my Full Push Notification Video..
// Link in Description...

// Intializng Firebase And CLoud Messaging...

class AppDelegate: NSObject,UIApplicationDelegate{
   
    let gcmMessageIDKey = "gcm.message_id"
   
    @State var morningTime = 12
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        
        FirebaseApp.configure()
        
        // Setting Up Cloud Messaging...
        
        Messaging.messaging().delegate = self
    
        // Setting Up Notifications...
        
//        Notification(time: Int(firebaseData.userTimeToDisPlay["userMorningTime"]!)!, ment: "아침 식사 기록 시간입니다!")
//        Notification(time: Int(firebaseData.userTimeToDisPlay["userLaunchTime"]!)!, ment: "점심 식사 기록 시간입니다!")
//        Notification(time: Int(firebaseData.userTimeToDisPlay["userDinnerTime"]!)!, ment: "저녁 식사 기록 시간입니다!")
        
     
        
        if #available(iOS 10.0, *) {
          // For iOS 10 display notification (sent via APNS)
          UNUserNotificationCenter.current().delegate = self

          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_, _ in })
        } else {
          let settings: UIUserNotificationSettings =
          UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          application.registerUserNotificationSettings(settings)
        }

        application.registerForRemoteNotifications()
        return true
    }
  
    func Notification(morningTime : Int, morningMinute: Int, morningMent : String, launchTime : Int, launchMinute : Int, launchMent : String, dinnerTime : Int, dinnerMinute : Int, dinnerMent : String ){
        
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .sound, .badge], completionHandler: {userDidAllow, error in
            //if userDidAllow : do something if you want to
        })
        
        let morningContent = UNMutableNotificationContent()
        morningContent.title = "클레이"
        morningContent.body = morningMent
        morningContent.sound = .default
        
        let launchContent = UNMutableNotificationContent()
        launchContent.title = "클레이"
        launchContent.body = launchMent
        launchContent.sound = .default
        
        let dinnerContent = UNMutableNotificationContent()
        dinnerContent.title = "클레이"
        dinnerContent.body = dinnerMent
        dinnerContent.sound = .default
        
     
        var morningDateComponents = DateComponents()
        morningDateComponents.hour = morningTime
        morningDateComponents.minute = morningMinute
        
        var launchDateComponents = DateComponents()
        launchDateComponents.hour = launchTime
        launchDateComponents.minute = launchMinute
        
        var dinnerDateComponents = DateComponents()
        dinnerDateComponents.hour = dinnerTime
        dinnerDateComponents.minute = dinnerMinute
        
        let morningTrigger = UNCalendarNotificationTrigger(dateMatching: morningDateComponents, repeats: true)
        let launchTrigger = UNCalendarNotificationTrigger(dateMatching: launchDateComponents, repeats: true)
        let dinnerTrigger = UNCalendarNotificationTrigger(dateMatching: dinnerDateComponents, repeats: true)
        //Set your content
      
       
        let morningRequest = UNNotificationRequest(
            identifier: "morningPush", content: morningContent, trigger: morningTrigger
        )
        let launchRequest = UNNotificationRequest(
            identifier: "launchPush", content: launchContent, trigger: launchTrigger
        )
        let dinnerRequest = UNNotificationRequest(
            identifier: "dinnerPush", content: dinnerContent, trigger: dinnerTrigger
        )
        
        UNUserNotificationCenter.current().add(morningRequest, withCompletionHandler: nil)
        UNUserNotificationCenter.current().add(launchRequest, withCompletionHandler: nil)
        UNUserNotificationCenter.current().add(dinnerRequest, withCompletionHandler: nil)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {

        // DO Something With Message Data Here....
      if let messageID = userInfo[gcmMessageIDKey] {
        print("Message ID: \(messageID)")
      }
        
      // Print full message.
      print(userInfo)

      completionHandler(UIBackgroundFetchResult.newData)
    }
    
    // In order to receive notifications you need implement thsese methods...
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
    }

}

// CLoud Messaging...
extension AppDelegate: MessagingDelegate{
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
    
        // Store this token to firebase and retrieve when to send message to someone....
        let dataDict:[String: String] = ["token": fcmToken ?? ""]
        print("\(String(describing: firebaseData.userTimeToDisPlay["userMorningTime"]!))asdasdasdasdasdasdasasdasdasdasdasd")
        // Store token in Firestore For Sending Notifications From Server in Future...
        
        print(dataDict)
    }
}

// User Notifications...[AKA InApp Notifications...]

@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {

  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    let userInfo = notification.request.content.userInfo

    // DO Something With MSG Data...
    
    if let messageID = userInfo[gcmMessageIDKey] {
      print("Message ID: \(messageID)")
    }

    print(userInfo)

    completionHandler([[.banner,.badge, .sound]])
  }

  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse,
                              withCompletionHandler completionHandler: @escaping () -> Void) {
    let userInfo = response.notification.request.content.userInfo
    if let messageID = userInfo[gcmMessageIDKey] {
      print("Message ID: \(messageID)")
    }

    // DO Something With MSG Data...
    print(userInfo)

    completionHandler()
  }
}

