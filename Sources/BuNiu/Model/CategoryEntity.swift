//
//  CategoryEntity.swift
//  BuNiu
//
//  Created by zhangxun on 2018/4/17.
//

import Foundation
import MySQL
import PerfectLib


struct CategoryEntity: QueryRowResultType, QueryParameterDictionaryType, Codable {
    
    
    let id: Int
    let name: String
    let create_time: Date
    
    
    static func decodeRow(r: QueryRowResult) throws -> CategoryEntity {
        return try CategoryEntity(
            id: r <| 0,
            name:r <| "name",
            create_time: r <| "create_time"
        )
    }
    
    func queryParameter() throws -> QueryDictionary {
        return QueryDictionary([
            "id":id
            ])
    }
    
    
    
    
    
    
}
