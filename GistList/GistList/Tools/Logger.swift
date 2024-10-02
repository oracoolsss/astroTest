//
//  Logger.swift
//  GistList
//
//  Created by Stepan Chernovskiy on 02.10.2024.
//

import Foundation

enum LogType {
    case error
    case info
}

class Logger {
    public static func log(_ info: String, type: LogType) {
        switch type {
        case .error:
            print("[ERROR]:\n\(info)")
        case .info:
            print("[INFO]:\n\(info)")
        }
    }
}
