//
//  AppDelegate.swift
//  MacMessagerie
//
//  Created by Emmanuel ROHEE on 05/04/2020.
//  Copyright © 2020 manu.test. All rights reserved.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the window contents.
        //let contentView = ContentView()
        
        
        
        let factoryManager = ProtocolDataFactoryManager.shared
        factoryManager.registerFactory(protocolName: ProtocolName.matrix, factory: MatrixDataFactory())

        let accountManager = SecureAccountManager()

        // Create the SwiftUI view that provides the window contents
        let homeViewModel = HomeViewModel(accountManager: accountManager)
        let contentView = HomeView(viewModel: homeViewModel, state: homeViewModel.state)


        // Create the window and set the content view. 
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

