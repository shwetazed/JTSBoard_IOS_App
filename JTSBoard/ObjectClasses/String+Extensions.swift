//
//  String+Extensions.swift
//  SalonatApp
//
//  Created by Apple on 23/04/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation

#if os(macOS)
    import AppKit
#elseif os(iOS)
    import UIKit
#endif

extension String {
    var convertHtml: NSAttributedString? {
        do {
            return try NSAttributedString(data: Data(utf8),
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
    var html2String: String {
        return convertHtml?.string ?? ""
    }
}

/*extension String{
    func convertHtml() -> NSAttributedString{
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do{
            return try NSAttributedString(data: Data(utf8),
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        }catch{
            return NSAttributedString()
        }
    }
}*/
