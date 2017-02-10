//
//  AppleScriptInstaller.swift
//  Jirassic
//
//  Created by Cristian Baluta on 20/11/2016.
//  Copyright © 2016 Imagin soft. All rights reserved.
//

import Foundation

protocol AppleScriptInstallerProtocol {
    
    var scriptsDirectory: URL? {get}
    func getScriptsVersion (completion: @escaping (String) -> Void)
    func getJitVersion (completion: @escaping ([String: String]) -> Void)
    func saveJiraSettings (_ settings: String, completion: @escaping (Bool) -> Void)
    func getSafariUrl (completion: @escaping (String) -> Void)
    func copyFile (from: String, to: String, completion: @escaping (Bool) -> Void)
    func removeFile (from: String, completion: @escaping (Bool) -> Void)
}

class AppleScriptInstaller: AppleScriptInstallerProtocol {
    
    var scriptsDirectory: URL? {
        return nil
    }
    
    func getScriptsVersion (completion: @escaping (String) -> Void) {
        
    }
    
    func getJitVersion (completion: @escaping ([String: String]) -> Void) {
        
    }
    
    func saveJiraSettings (_ settings: String, completion: @escaping (Bool) -> Void) {
        
    }
    
    func getSafariUrl (completion: @escaping (String) -> Void) {
        
    }
    
    func copyFile (from: String, to: String, completion: @escaping (Bool) -> Void) {
        
//        let asc = NSAppleScript(source: "do shell script \"sudo cp \(bundledJitPath) \(jitInstallationPath)\" with administrator privileges")
//        if let response = asc?.executeAndReturnError(nil) {
//            print(response)
//            completion(true)
//        } else {
//            print("Could not copy Jit from \(bundledJitPath) to \(jitInstallationPath)")
//            completion(false)
//        }
    }
    
    func removeFile (from: String, completion: @escaping (Bool) -> Void) {
        
    }
}

//    func getJiraPasswordForUser (_ jiraUser: String) {
//
//        let task = Process()
//        task.launchPath = "/usr/bin/security"
//        task.arguments = ["find-generic-password", "-wa", jiraUser]
//        task.terminationHandler = { task in
//            DispatchQueue.main.async(execute: {
//                print(task)
//            })
//        }
//        task.launch()
//    }
    
