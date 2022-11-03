//
//  ResourceUtil.swift
//  Port Watch
//
//  Created by Marco Thümmler on 06.09.22.
//

import SwiftUI

final class ResourceUtil {
    
    private static var names = [Int32: String]()
    private static var icons = [Int32: Image]()
    private static var nsImages = [Int32: NSImage]()
    private static let defaultIcon = Image(nsImage: NSWorkspace.shared.icon(for: .unixExecutable))
    
    private init() {}
    
    static func processName(for processId: String, processes: [NSRunningApplication] = NSWorkspace.shared.runningApplications) -> String {
        guard let pid = Int32(processId) else {
            return ""
        }
        if let processName = names[pid] {
            return processName
        }
        if pid == 0 {
            names[pid] = "kernel_task"
            return "kernel_task"
        }
        if let name = processes.first(where: { $0.processIdentifier == pid })?.localizedName {
            names[pid] = name
            return name
        }
        let nameBuffer = UnsafeMutablePointer<Int8>.allocate(capacity: Int(MAXPATHLEN))
        defer {
            nameBuffer.deallocate()
        }
        let nameLength = proc_name(pid, nameBuffer, UInt32(MAXPATHLEN))
        let name = nameLength > 0 ? String(cString: nameBuffer) : nil
        if let name = name {
            names[pid] = name
            return name
        }
        let pathBuffer = UnsafeMutablePointer<UInt8>.allocate(capacity: Int(MAXPATHLEN))
        defer {
            pathBuffer.deallocate()
        }
        let pathLength = proc_pidpath(pid, pathBuffer, UInt32(MAXPATHLEN))
        let path = pathLength > 0 ? String(cString: pathBuffer) : ""
        names[pid] = path
        return path
    }
    
    static func icon(for processId: String, processes: [NSRunningApplication] = NSWorkspace.shared.runningApplications) -> Image {
        guard let pid = Int32(processId) else {
            return defaultIcon
        }
        if let image = icons[pid] {
            return image
        }
        if let icon = processes.first(where: { $0.processIdentifier == pid })?.icon {
            let image = Image(nsImage: icon)
            icons[pid] = image
            nsImages[pid] = icon
            return image
        }
        icons[pid] = defaultIcon
        return defaultIcon
    }
    
    static func nsImage(for processId: String) -> NSImage {
        guard let pid = Int32(processId) else {
            return NSWorkspace.shared.icon(for: .unixExecutable)
        }
        if let image = nsImages[pid] {
            return image
        }
        return NSWorkspace.shared.icon(for: .unixExecutable)
    }
}
