//
//  AdminDataService.swift
//  BuNiu
//
//  Created by zhangxun on 2018/4/17.
//

import PerfectLib
import MySQL

struct AdminDataService {
    
    
    public static func login_by_username(username:String,paaword:String) throws -> [UserEntity] {
        let row:[UserEntity] = try pool.execute({ conn in
            try conn.query("select * from user where username=? and password=?",[username,paaword])
        })
        return row;
    }
    
    
    //获取category count
    public static func get_category_count() throws -> Int {
        do{
            let row:[Count] = try pool.execute{
                return try $0.query("select count(id) as c from category")
            }
            return row[0].count
        }catch{
            return 0
        }
    }
    //获取categorylist
    public static func category_get_all_bypage(page_no:Int,page_size:Int) -> [CategoryEntity]? {
        var page_no = page_no
        if page_no < 1 {
            page_no = 1
        }
        var row:[CategoryEntity]?
        do{
            row = try pool.execute({ conn in
                try conn.query("select c.* from category c " +
                    " order by c.id desc limit ?,?"
                    ,[(page_no - 1) * page_size,page_size]
                )
            })
        }catch{
            Log.error(message: "\(error)")
            return nil
        }
        return row;
    }
    //添加category
    public static func category_add(categoryname:String) throws -> Bool {
        
        return try pool.execute{
            try $0.query("insert into category (name) values(?) ON DUPLICATE KEY UPDATE create_time=CURRENT_TIMESTAMP ",[categoryname])
            }.insertedID > 0
    }
    //删除category
    public static func category_del(category_id:Int)throws -> Bool{
        return try pool.execute{
            try $0.query("delete from category where id=?",[category_id])
            }.affectedRows > 0
    }
    
    
    //根据categoryid 查询
    public static func category_get_byid(category_id:Int) throws -> [CategoryEntity] {
        return try pool.execute{
            try $0.query("select c.* from category c " +
                "where c.id=? " ,[category_id]
            )
        }
    }
    
    //uodate category
    public static func category_update(category_id:Int,categoryname:String) throws -> Bool {
        return try pool.execute{
            try $0.query("update category set name = ? where id=?",[categoryname,category_id])
            }.affectedRows > 0
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    //获取category count
    public static func get_topic_count() throws -> Int {
        do{
            let row:[Count] = try pool.execute{
                return try $0.query("select count(id) as c from topic")
            }
            return row[0].count
        }catch{
            return 0
        }
    }
    //获取categorylist
    public static func topic_get_all_bypage(page_no:Int,page_size:Int) -> [TopicEntity]? {
        var page_no = page_no
        if page_no < 1 {
            page_no = 1
        }
        var row:[TopicEntity]?
        do{
            row = try pool.execute({ conn in
                try conn.query("select c.* from topic c " +
                    " order by c.id desc limit ?,?"
                    ,[(page_no - 1) * page_size,page_size]
                )
            })
        }catch{
            Log.error(message: "\(error)")
            return nil
        }
        return row;
    }
    //添加category
    public static func topic_add(topictitle:String,topiccontent:String,category_id:Int) throws -> Bool {
        
        return try pool.execute{
            try $0.query("insert into topic (title,content,category_id) values(?,?,?) ON DUPLICATE KEY UPDATE create_time=CURRENT_TIMESTAMP ",[topictitle,topiccontent,category_id])
            }.insertedID > 0
    }
    
    //uodate category
    public static func topic_update(topic_id:Int,topictitle:String,category_id:Int,topiccontent:String) throws -> Bool {
        return try pool.execute{
            try $0.query("update topic set title = ?, content=?, category_id=?, update_time=? where id=?",[topictitle,topiccontent,category_id,Utils.now(),topic_id])
            }.affectedRows > 0
    }
    
    //根据categoryid 查询
    public static func topic_get_byid(topic_id:Int) throws -> [TopicEntity] {
        return try pool.execute{
            try $0.query("select c.* from topic c " +
                "where c.id=? " ,[topic_id]
            )
        }
    }
    
    //删除category
    public static func topic_del(topic_id:Int)throws -> Bool{
        return try pool.execute{
            try $0.query("delete from topic where id=?",[topic_id])
            }.affectedRows > 0
    }
}
