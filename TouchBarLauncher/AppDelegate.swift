//
//  AppDelegate.swift
//  TouchBarLauncher
//
//  Created by Sash Zats on 10/28/16.
//  Copyright © 2016 Sash Zats. All rights reserved.
//
//  Modified by syscl to enhance the function of TouchBarLauncher
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    
    private let bundle = Bundle(path: "/Applications/Xcode.app/Contents/Frameworks/DFRSupportKit.framework")!
    private var controller: NSWindowController?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        bundle.load()
        createTouchBar()
        showTouchBar()
    }
    
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        showTouchBar()
        return true
    }

    private func createTouchBar() {
        let cls: AnyClass = NSClassFromString("IDETouchBarSimulatorHostWindowController")!
        let sel = NSSelectorFromString("simulatorHostWindowController")
        let result = (cls as! NSObjectProtocol).perform(sel).takeUnretainedValue()
        controller = result as? NSWindowController
        // syscl/lighting/Yating Zhou enhancement
        // syscl hide the toucharIcon
        controller?.window?.collectionBehavior = [.canJoinAllSpaces, .transient]
        controller?.window?.delegate = self
        // syscl movable?
        controller?.window?.isMovableByWindowBackground = false;
        // syscl use background texture
        controller?.window?.styleMask = NSWindowStyleMask.texturedBackground
    }
    
    private func showTouchBar() {
        controller?.window?.makeKeyAndOrderFront(self)
    }
}

extension AppDelegate: NSWindowDelegate {
    func windowWillClose(_ notification: Notification) {
        NSApp.terminate(self)
    }
}
