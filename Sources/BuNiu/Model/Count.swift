//
//  Count.swift
//  Perfect
//
//  Created by apple on 2018/4/24.
//
//

import Foundation
import MySQL

//用于展示个数

struct Count: QueryRowResultType, QueryParameterDictionaryType {
    
    
    let count: Int
    
    static func decodeRow(r: QueryRowResult) throws -> Count {
        return try Count(
            count: r <| 0
        )
    }
    func queryParameter() throws -> QueryDictionary {
        
        return QueryDictionary([
            "count":count
            ])
    }
}
