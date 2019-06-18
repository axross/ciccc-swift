//
//  main.swift
//  CrazyContentCrawler
//
//  Created by Kohei Asai on 2019-06-18.
//  Copyright © 2019 Kohei Asai. All rights reserved.
//

import Foundation

func main() -> Void {
    let argv = ProcessInfo.processInfo.arguments
    let path = URL(fileURLWithPath: argv[1])
    
    printContentsOfDirectoryRecursively(at: path)
}

func printContentsOfDirectoryRecursively(at: URL, nodePrefix: String = "") -> Void {
    let contents = try! FileManager().contentsOfDirectory(at: at, includingPropertiesForKeys: [])
    
    for content in contents {
        let isLastContent = content == contents.last!
        let leafPrefix = isLastContent ? "└─" : "├─"
        
        print(nodePrefix + leafPrefix + " " + content.lastPathComponent)
        
        if isDirectory(at: content) {
            let nextNodePrefix = isLastContent ? "   " : "│  "
            
            printContentsOfDirectoryRecursively(at: content, nodePrefix: nodePrefix + nextNodePrefix)
        }
    }
}

func isDirectory(at: URL) -> Bool {
    var isDir = ObjCBool(true)
    
    FileManager.default.fileExists(atPath: at.path, isDirectory: &isDir)
    
    return isDir.boolValue
}

main()
