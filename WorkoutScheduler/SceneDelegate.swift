//
//  SceneDelegate.swift
//  WorkoutScheduler
//
//  Created by 土橋正晴 on 2025/01/17.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        openedFromWidget(connectionOptions.urlContexts)
    }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        openedFromWidget(URLContexts)
    }


    private func openedFromWidget(_ urlContexts: Set<UIOpenURLContext>) { }
    
}
