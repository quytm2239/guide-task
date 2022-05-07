//
//  ExtensionDelegate.swift
//  VMeasure WatchKit Extension
//
//  Created by Tran Manh Quy on 29/04/2022.
//

import WatchKit

class ExtensionDelegate: NSObject, WKExtensionDelegate {
    
    private var extendedSession: WKExtendedRuntimeSession?
    static var current: ExtensionDelegate? {
       return (WKExtension.shared().delegate as? ExtensionDelegate)
    }
    let backgroundSyncingSchedulingInterval: Double = 60 // 60 mins
    
    func startExtendedSession() {
        print("startExtendedSession()")
        if extendedSession != nil {
            NSObject.cancelPreviousPerformRequests(withTarget: self,
                                                   selector: #selector(delayStopExtendedSession), object: nil)
            let timeout = 900 // Defaults[.kSyncTimeAfterWorkout]
            self.perform(#selector(delayStopExtendedSession), with: nil, afterDelay: TimeInterval(timeout))
            return
        }
        if extendedSession == nil { extendedSession = WKExtendedRuntimeSession() }
        extendedSession?.delegate = self
        if WKExtension.shared().applicationState == .active {
            extendedSession?.start()
        }
    }

    func applicationDidFinishLaunching() {
        // Perform any final initialization of your application.
    }

    func applicationDidBecomeActive() {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        startExtendedSession()
    }

    func applicationWillResignActive() {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, etc.
    }

    func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
        // Sent when the system needs to launch the application in the background to process tasks. Tasks arrive in a set, so loop through and process each one.
        for task in backgroundTasks {
            // Use a switch statement to check the task type
            switch task {
            case let backgroundTask as WKApplicationRefreshBackgroundTask:
                // Be sure to complete the background task once you’re done.
                backgroundTask.setTaskCompletedWithSnapshot(false)
            case let snapshotTask as WKSnapshotRefreshBackgroundTask:
                // Snapshot tasks have a unique completion call, make sure to set your expiration date
                snapshotTask.setTaskCompleted(restoredDefaultState: true, estimatedSnapshotExpiration: Date.distantFuture, userInfo: nil)
            case let connectivityTask as WKWatchConnectivityRefreshBackgroundTask:
                // Be sure to complete the connectivity task once you’re done.
                connectivityTask.setTaskCompletedWithSnapshot(false)
            case let urlSessionTask as WKURLSessionRefreshBackgroundTask:
                // Be sure to complete the URL session task once you’re done.
                urlSessionTask.setTaskCompletedWithSnapshot(false)
            case let relevantShortcutTask as WKRelevantShortcutRefreshBackgroundTask:
                // Be sure to complete the relevant-shortcut task once you're done.
                relevantShortcutTask.setTaskCompletedWithSnapshot(false)
            case let intentDidRunTask as WKIntentDidRunRefreshBackgroundTask:
                // Be sure to complete the intent-did-run task once you're done.
                intentDidRunTask.setTaskCompletedWithSnapshot(false)
            default:
                // make sure to complete unhandled task types
                task.setTaskCompletedWithSnapshot(false)
            }
        }
    }

}

extension ExtensionDelegate: WKExtendedRuntimeSessionDelegate {
    // MARK:- Extended Runtime Session Delegate Methods
    func extendedRuntimeSessionDidStart(_ extendedRuntimeSession: WKExtendedRuntimeSession) {
        print("Extended Session started!")
        
        let timeout = 900 // Defaults[.kSyncTimeAfterWorkout]
        self.perform(#selector(delayStopExtendedSession), with: nil, afterDelay: TimeInterval(timeout))
    }
    
    @objc func delayStopExtendedSession() {
        print("Extended Session will be ended manually!")
        self.extendedSession?.invalidate()
    }

    func extendedRuntimeSessionWillExpire(_ extendedRuntimeSession: WKExtendedRuntimeSession) {
        print("Extended Session Will Expire: \(extendedRuntimeSession.expirationDate ?? Date())")
    }
        
    func extendedRuntimeSession(_ extendedRuntimeSession: WKExtendedRuntimeSession, didInvalidateWith reason: WKExtendedRuntimeSessionInvalidationReason, error: Error?) {
        print("Extended Session Ended: [reason] \(reason)")
        print("Extended Session Ended: [error] \(error?.localizedDescription)")
        self.extendedSession = nil
    }
}
