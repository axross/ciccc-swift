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
    let url = URL(fileURLWithPath: argv[1])
    
    do {
        try printContentsOfDirectoryRecursively(at: url)
    } catch {
        print(error);
    }
}

func printContentsOfDirectoryRecursively(at url: URL, nodePrefix: String = "") throws -> Void {
    let contents = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: [])
    
    for content in contents {
        let isLastContent = content == contents.last!
        let leafPrefix = isLastContent ? "└─" : "├─"
        let entryType = getEntryType(at: content)
        
        print(nodePrefix + leafPrefix + " " + content.lastPathComponent)
        
        if (entryType == .directory) {
            let nextNodePrefix = isLastContent ? "   " : "│  "
            
            try printContentsOfDirectoryRecursively(at: content, nodePrefix: nodePrefix + nextNodePrefix)
        }
    }
}

func getEntryType(at url: URL) -> EntryType {
    var isDir = ObjCBool(true)
    
    FileManager.default.fileExists(atPath: url.path, isDirectory: &isDir)
    
    return isDir.boolValue ? .directory : .file
}

enum EntryType {
    case directory
    case file
}

main()
