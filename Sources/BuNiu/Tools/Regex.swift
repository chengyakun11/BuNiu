//
//  MyRegex.swift
//  Perfect
//
//  Created by apple on 2018/4/24.
//
//

import Foundation

import Foundation

struct Regex {
    let regex: NSRegularExpression?
    
    init(_ pattern: String) {
        regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
    }
    
    func match(input: String) -> Bool {
        if let matches = regex?.matches(in: input,
                                                options: [],
                                                range: NSMakeRange(0, (NSString(string:input)).length)) {
            return matches.count > 0
        }
        else {
            return false
        }
    }
}

