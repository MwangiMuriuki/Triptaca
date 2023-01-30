//
//  AppDelegate.swift
//  Tripitaca
//
//  Created by Ernest Mwangi on 25/01/2023.
//

import UIKit
import IQKeyboardManagerSwift
import FirebaseCore
import FirebaseAuth
import FirebaseAnalytics

@main
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    var signInCallBack: (() -> ())?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true


        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        if (configureError != nil){
            print("Oooops! We have an error! \(configureError)")
        }

        GIDSignIn.sharedInstance().delegate = self

        return true
    }

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error != nil){
            print("Oooops! Login error! \(error)")
        }
        else {
            print("Hi \(user.profile.name ?? "User"), You have signed in successfully!!!")
        }
    }

    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url, sourceApplication: sourceApplication, annotation: annotation)
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


}

