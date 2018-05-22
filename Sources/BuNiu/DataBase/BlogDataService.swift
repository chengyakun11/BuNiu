//
//  BlogDataService.swift
//  BuNiu
//
//  Created by zhangxun on 2018/4/18.
//

import PerfectLib
import MySQL

struct BlogDataService {
    
    
    //获取category count
    public static func get_topic_count(topic_type:String) throws -> Int {
        do{
            //blogindex=>0  bloglife=>1    blogdoing=>2  blogtechshare=>3
            
            
            switch topic_type {
            case "bloglife":
                let row:[Count] = try pool.execute{
                    return try $0.query("select count(id) as c from topic where category_id=?",[1])
                }
                return row[0].count
            case "blogdoing":
                let row:[Count] = try pool.execute{
                    return try $0.query("select count(id) as c from topic where category_id=?",[2])
                }
                return row[0].count
            case "blogtechshare":
                let row:[Count] = try pool.execute{
                    return try $0.query("select count(id) as c from topic where category_id=?",[3])
                }
                return row[0].count
            default:
                let row:[Count] = try pool.execute{
                    return try $0.query("select count(id) as c from topic")
                }
                return row[0].count
            }
            
        }catch{
            return 0
        }
    }
    //获取categorylist
    public static func topic_get_all_bypage(topic_type:String,page_no:Int,page_size:Int) -> [TopicEntity]? {
        var page_no = page_no
        if page_no < 1 {
            page_no = 1
        }
        var row:[TopicEntity]?
        do{
            
            switch topic_type {
            case "bloglife":
                row = try pool.execute({ conn in
                    try conn.query("select c.* from topic c " +
                        " where category_id=? order by c.id desc limit ?,?"
                        ,[1,(page_no - 1) * page_size,page_size]
                    )
                })
            case "blogdoing":
                row = try pool.execute({ conn in
                    try conn.query("select c.* from topic c " +
                        " where category_id=? order by c.id desc limit ?,?"
                        ,[2,(page_no - 1) * page_size,page_size]
                    )
                })
            case "blogtechshare":
                row = try pool.execute({ conn in
                    try conn.query("select c.* from topic c " +
                        " where category_id=? order by c.id desc limit ?,?"
                        ,[3,(page_no - 1) * page_size,page_size]
                    )
                })
            default:
                row = try pool.execute({ conn in
                    try conn.query("select c.* from topic c " +
                        " order by c.id desc limit ?,?"
                        ,[(page_no - 1) * page_size,page_size]
                    )
                })
            }
            
            
        }catch{
            Log.error(message: "\(error)")
            return nil
        }
        return row;
    }
    
    //根据topic_id 查询
    public static func topic_get_byid(topic_id:Int) throws -> [TopicEntity] {
        return try pool.execute{
            try $0.query("select c.* from topic c " +
                "where c.id=? " ,[topic_id]
            )
        }
    }
}
