//
//  SceneDelegate.swift
//  EasyMatch
//
//  Created by Нуридин Сафаралиев on 11/6/24.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        self.setupWindow(with: scene)
        self.checkAuthentication()
    }

    private func setupWindow(with scene: UIScene){
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        self.window?.makeKeyAndVisible()
        
    }

    

    
    public func checkAuthentication(){
        if Auth.auth().currentUser == nil{
            let vc = LoginController()
            let nav = UINavigationController(rootViewController: vc)
            self.window?.rootViewController = nav
        } else {
            let tabBarController = TabBarController()
            self.window?.rootViewController = tabBarController
            
//            let vc = HomeController()
//            let nav = UINavigationController(rootViewController: vc)
//            nav.modalPresentationStyle = .fullScreen
//            self.window?.rootViewController = nav
            
        }
            
    }

}

