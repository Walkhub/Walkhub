import UIKit

import BackgroundTasks
import Firebase
import Swinject
import Service

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: Container
    static var continer: Container {
        let continer = Container()
        continer.registerDependencies()
        return continer
    }

    // MARK: Application Lifecycle
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        FirebaseApp.configure()
        self.setFCM(application)

        self.registerBackgroundTasks()

        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        pushTerminateNotification()
    }

    // MARK: UISceneSession Lifecycle

    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(
        _ application: UIApplication,
        didDiscardSceneSessions sceneSessions: Set<UISceneSession>
    ) { }

}

// MARK: - Push Notification
extension AppDelegate: UNUserNotificationCenterDelegate {

    private func setFCM(_ application: UIApplication) {
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
        )
        application.registerForRemoteNotifications()
    }

    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        Messaging.messaging().apnsToken = deviceToken
    }

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        if #available(iOS 14.0, *) {
            completionHandler([.badge, .sound, .list, .banner])
        } else {
            completionHandler([.alert, .badge, .sound])
        }

    }

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        completionHandler()
    }

    private func pushTerminateNotification() {
        let push = UNMutableNotificationContent()
        push.title = "종료 알림"
        push.body = "백그라운드에서 앱을 종료하시면 기록이 랭킹에 반영되지 않습니다."
        let request = UNNotificationRequest(identifier: "TerminateNotification", content: push, trigger: nil)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }

}

// MARK: - Background Task
extension AppDelegate {

    private func registerBackgroundTasks() {
        BGTaskScheduler.shared.register(
            forTaskWithIdentifier: "com.walkhub.Walkhub.synchronizeExerciseRecord",
            using: nil
        ) { self.synchronizeDailyExerciseRecord(task: ($0 as? BGProcessingTask)!) }
    }

    private func synchronizeDailyExerciseRecord(task: BGProcessingTask) {

        Self.scheduleSynchronizeDailyExerciseRecordIfNeeded()

        let synchronizeDailyExerciseRecordUseCase = Self.continer
            .resolve(SynchronizeDailyExerciseRecordUseCase.self)!

        let disposable = synchronizeDailyExerciseRecordUseCase.excute()
            .subscribe(onCompleted: {
                task.setTaskCompleted(success: true)
            }, onError: { _ in
                task.setTaskCompleted(success: false)
            })

        task.expirationHandler = {
            disposable.dispose()
        }

    }

    static func scheduleSynchronizeDailyExerciseRecordIfNeeded() {
        let request = BGProcessingTaskRequest(identifier: "com.walkhub.Walkhub.synchronizeExerciseRecord")
        request.requiresNetworkConnectivity = true
        request.earliestBeginDate = Date(timeIntervalSinceNow: 3600)
        try? BGTaskScheduler.shared.submit(request)
    }

}
