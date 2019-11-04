//
//  SceneDelegate.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 28/10/2019.
//  Copyright © 2019 manu.test. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

        // Create the SwiftUI view that provides the window contents

        let accountManager = AccountManager.shared
        self.setupHardCodedAccount(accountManager: accountManager)

        // Hmm: that's painful
        // Factory instead?
        // protocolManager as @EnvironmentObject? Maybe account too?
        let account = accountManager.accounts.first!
        let protocolManager = accountManager.manager(protocolType: account.protocolType)!
        let roomListSource = protocolManager.roomListSource(account: account)

        let contentView = RoomListView(viewModel: RoomListViewModel(source: roomListSource))


        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    // TODO: Remove it
    private func setupHardCodedAccount(accountManager: AccountManager) {
        accountManager.registerProtocolManager(protocolType: ProtocolType.matrix, manager: MatrixManager())
        let account = MatrixAccount(homeserver: URL(string: "https://matrix.org")!,
                                    userId: "@superman:matrix.org",
                                    accessToken: "MDAxOGxvY2F0aW9uIG1hdHJpeC5vcmcKMDAxM2lkZW50aWZpZXIga2V5CjAwMTBjaWQgZ2VuID0gMQowMDI3Y2lkIHVzZXJfaWQgPSBAc3VwZXJtYW46bWF0cml4Lm9yZwowMDE2Y2lkIHR5cGUgPSBhY2Nlc3MKMDAyMWNpZCBub25jZSA9IHJaRjRSNSpVOjNPTCZNPTYKMDAyZnNpZ25hdHVyZSDwKgaV-qS3-6I3jvj-La7FZAwitRuMCSuerEx2If34Two")
        accountManager.addAccount(account: account)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

