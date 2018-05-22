//
//  adminController.swift
//  BuNiu
//
//  Created by zhangxun on 2018/4/17.
//

import Foundation
import PerfectHTTP
import PerfectLib

class adminController{
    
    //到登录页面
    static func adminLoginPage(req:HTTPRequest,res:HTTPResponse){
        res.render(template: "admin/login")
    }
    //登录
    static func adminLogin(data: [String:Any]) throws -> RequestHandler {
        return {
            req,res in
            
            let username = req.param(name: "username")
            var password = req.param(name: "password")
            
            do{
                guard username != nil && password != nil else {
                    try res.setBody(json: ["success": false,"msg":"用户名和密码不得为空."])
                    res.completed()
                    return
                }

                password = Utility.encode(message: password!)
                var isExist = false
                var user:UserEntity?
                
                let users =  try AdminDataService.login_by_username(username: username!, paaword: password!)
                if users.count > 0 {
                    isExist  = true
                    user = users[0]
                }
                
                guard isExist != false else {
                    try res.setBody(json: ["success":false,"msg":"用户名或密码错误，请检查!"])
                    res.completed()
                    return
                }
                
                guard req.session != nil else {
                    try res.setBody(json: ["success":false,"msg":"withhout session"])
                    return
                }
                
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale.current //设置时区，时间为当前系统时间
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"//输出样式
                let ct = user!.create_time
                let stringDate = dateFormatter.string(from:ct!)
                
                //配置sesssion
                let sessionDic:[String:Any] = ["username":user!.username,
                                               "userid":user!.id,
                                               "userpic":user!.avatar,
                                               "create_time":stringDate]
                req.session!.data.updateValue(sessionDic, forKey: "user")
                try res.setBody(json: ["success":true,"msg":"登录成功"])
                res.completed()
            }catch{
                Log.error(message: "\(error)")
            }
        }
    }
    //登录后到后台主页
    static func adminIndex(data: [String:Any]) throws -> RequestHandler {
        return {
            req,res in
            

            
            res.render(template: "admin/index")
        }
    }
    
    //登录后到后台主页
    static func adminInfo(data: [String:Any]) throws -> RequestHandler {
        return {
            req,res in
            res.render(template: "admin/info")
        }
    }

    //==========================================category
    //分类category列表
    static func adminCategoryList(data: [String:Any]) throws -> RequestHandler {
        return {
            request, response in
            do{
                let page_no = request.param(name: "page_no")?.int ?? 1
                let page_size = page_config.index_topic_page_size
                var total_count = 0
                total_count = try AdminDataService.get_category_count()
                let total_page = Utils.total_page(total_count: total_count, page_size: page_size)
                
                let categorys = AdminDataService.category_get_all_bypage(page_no: page_no, page_size: page_size)
                if categorys == nil {
                    try response.setBody(json: ["success":false])
                    response.completed()
                    return
                }
                let encoded = try? encoder.encode(categorys)
                if encoded != nil {
                    if let json = String(data: encoded!,encoding:.utf8){
                        if let decoded = try json.jsonDecode() as? [[String:Any]] {
                            let dic:[String:Any] = ["totalCount":total_count,"totalPage":total_page,"currentPage":page_no,"categorys":decoded]
                            try response.setBody(json: ["success":true,"data":dic])
                        }
                    }
                }
                response.completed()
            }catch{
                Log.error(message: "\(error)")
            }
        }
    }
    //添加分类category
    static func adminAddCategory(data: [String:Any]) throws -> RequestHandler {
        return {
            req,res in
            do {
                let categoryname = req.param(name: "categoryname")
                let result =  try AdminDataService.category_add(categoryname: categoryname!)
                if result {
                    try res.setBody(json: ["success":true,"msg":"like successfully."])
                    res.completed()
                }else{
                    try res.setBody(json: ["success":false,"msg":"保存分类到数据库失败"])
                    res.completed()
                }
            }catch{
                Log.error(message: "\(error)")
            }
        }
    }
    //添加分类
    static func adminAddCategoryPage(data: [String:Any]) throws -> RequestHandler {
        return {
            req,res in
            res.render(template: "admin/categoryAdd")
        }
    }
    //编辑分类category
    static func adminUpdateCategory(data: [String:Any]) throws -> RequestHandler {
        return {
            req,res in
            
            do {
                guard let categoryid = req.param(name: "categoryid")?.int else {
                    try res.setBody(json: ["success":false,"msg":"获取删除分类ID失败"])
                    res.completed()
                    return
                }
                
                let categoryname = req.param(name: "categoryname")
                
                let judge =  try AdminDataService.category_update(category_id: categoryid, categoryname: categoryname!)
                guard judge != false else{
                    try res.setBody(json: ["success":false,"msg":"编辑分类失败"])
                    res.completed()
                    return
                }
                try res.setBody(json: ["success":true,"msg":"编辑分类成功"])
                res.completed()
            }catch{
                Log.error(message: "\(error)")
            }
        }
    }
    //编辑分类category 页面
    static func adminUpdateCategoryPage(data: [String:Any]) throws -> RequestHandler {
        return {
            req,res in
            do {
                guard let category_id = req.urlVariables["id"]?.int else {
                    res.render(template: "error", context: ["errMsg":"参数错误"])
                    return
                }
                let row = try AdminDataService.category_get_byid(category_id: category_id)
                guard row.count > 0 else {
                    res.render(template: "error", context: ["errMsg":"您要编辑的分类不存在或者您没有权限编辑."])
                    return
                }
                let encoded = try? encoder.encode(row[0])
                if encoded != nil {
                    if let json = encodeToString(data: encoded!){
                        if let decoded = try json.jsonDecode() as? [String:Any] {
                            res.render(template: "admin/categoryAdd", context: ["category":decoded])
                        }
                    }
                }
            }catch{
                Log.error(message: "\(error)")
            }
        }
    }
    
    
    //删除分类category
    static func adminDeleteCategory(data: [String:Any]) throws -> RequestHandler {
        return {
            req,res in
            do {
                guard let category_id = req.urlVariables["id"]?.int else {
                    try res.setBody(json: ["success":false,"msg":"获取删除分类ID失败"])
                    res.completed()
                    return
                }
                let judge =  try AdminDataService.category_del(category_id: category_id)
                guard judge != false else{
                    try res.setBody(json: ["success":false,"msg":"删除分类失败"])
                    res.completed()
                    return
                }
                try res.setBody(json: ["success":true,"msg":"删除分类成功"])
                res.completed()
            }catch{
                Log.error(message: "\(error)")
            }
        }
    }
    
    
    
    //==========================================topic
    //分类topic列表
    static func adminTopicList(data: [String:Any]) throws -> RequestHandler {
        return {
            request, response in
            do{
                let page_no = request.param(name: "page_no")?.int ?? 1
                let page_size = page_config.index_topic_page_size
                var total_count = 0
                total_count = try AdminDataService.get_topic_count()
                let total_page = Utils.total_page(total_count: total_count, page_size: page_size)
                
                let topics = AdminDataService.topic_get_all_bypage(page_no: page_no, page_size: page_size)
                if topics == nil {
                    try response.setBody(json: ["success":false])
                    response.completed()
                    return
                }
                let encoded = try? encoder.encode(topics)
                if encoded != nil {
                    if let json = String(data: encoded!,encoding:.utf8){
                        if let decoded = try json.jsonDecode() as? [[String:Any]] {
                            let dic:[String:Any] = ["totalCount":total_count,"totalPage":total_page,"currentPage":page_no,"topics":decoded]
                            try response.setBody(json: ["success":true,"data":dic])
                        }
                    }
                }
                response.completed()
            }catch{
                Log.error(message: "\(error)")
            }
        }
    }
    //添加分类topic
    static func adminAddTopic(data: [String:Any]) throws -> RequestHandler {
        return {
            req,res in
            do {
                let topictitle = req.param(name: "topictitle")
                let topiccontent = req.param(name: "topiccontent")
//                let topicid = req.param(name: "topicid")
                let category_id = req.param(name: "category_id")?.int
                let result =  try AdminDataService.topic_add(topictitle: topictitle!, topiccontent: topiccontent!, category_id: category_id!)
                if result {
                    try res.setBody(json: ["success":true,"msg":"like successfully."])
                    res.completed()
                }else{
                    try res.setBody(json: ["success":false,"msg":"保存分类到数据库失败"])
                    res.completed()
                }
            }catch{
                Log.error(message: "\(error)")
            }
        }
    }
    //添加分类
    static func adminAddTopicPage(data: [String:Any]) throws -> RequestHandler {
        return {
            req,res in
            res.render(template: "admin/topicAdd")
        }
    }
    //编辑分类topic
    static func adminUpdateTopic(data: [String:Any]) throws -> RequestHandler {
        return {
            req,res in
            
            do {
                guard let topicid = req.param(name: "topicid")?.int else {
                    try res.setBody(json: ["success":false,"msg":"获取删除分类ID失败"])
                    res.completed()
                    return
                }
                
                let topictitle = req.param(name: "topictitle")
                let topiccontent = req.param(name: "topiccontent")
                let category_id = req.param(name: "category_id")?.int
                
                let judge =  try AdminDataService.topic_update(topic_id: topicid, topictitle: topictitle!, category_id: category_id!, topiccontent: topiccontent!)
                guard judge != false else{
                    try res.setBody(json: ["success":false,"msg":"编辑分类失败"])
                    res.completed()
                    return
                }
                try res.setBody(json: ["success":true,"msg":"编辑分类成功"])
                res.completed()
            }catch{
                Log.error(message: "\(error)")
            }
        }
    }
    //编辑分类topic 页面
    static func adminUpdateTopicPage(data: [String:Any]) throws -> RequestHandler {
        return {
            req,res in
            do {
                guard let topic_id = req.urlVariables["id"]?.int else {
                    res.render(template: "error", context: ["errMsg":"参数错误"])
                    return
                }
                let row = try AdminDataService.topic_get_byid(topic_id: topic_id)
                guard row.count > 0 else {
                    res.render(template: "error", context: ["errMsg":"您要编辑的分类不存在或者您没有权限编辑."])
                    return
                }
                let encoded = try? encoder.encode(row[0])
                if encoded != nil {
                    if let json = encodeToString(data: encoded!){
                        if let decoded = try json.jsonDecode() as? [String:Any] {
                            res.render(template: "admin/topicAdd", context: ["topic":decoded])
                        }
                    }
                }
            }catch{
                Log.error(message: "\(error)")
            }
        }
    }
    
    
    //删除分类topic
    static func adminDeleteTopic(data: [String:Any]) throws -> RequestHandler {
        return {
            req,res in
            do {
                guard let topic_id = req.urlVariables["id"]?.int else {
                    try res.setBody(json: ["success":false,"msg":"获取删除分类ID失败"])
                    res.completed()
                    return
                }
                let judge =  try AdminDataService.topic_del(topic_id: topic_id)
                guard judge != false else{
                    try res.setBody(json: ["success":false,"msg":"删除分类失败"])
                    res.completed()
                    return
                }
                try res.setBody(json: ["success":true,"msg":"删除分类成功"])
                res.completed()
            }catch{
                Log.error(message: "\(error)")
            }
        }
    }
    
    
    
}
