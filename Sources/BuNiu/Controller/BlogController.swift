//
//  BlogController.swift
//  BuNiu
//
//  Created by zhangxun on 2018/4/18.
//

import Foundation
import PerfectHTTP
import PerfectLib


class BlogController{
    //首页
    static func index(req:HTTPRequest,res:HTTPResponse){
        res.render(template: "blog/index")
    }
    
    //关于我
    static func about(req:HTTPRequest,res:HTTPResponse){
        res.render(template: "blog/about")
    }
    
    //慢生活
    static func life(req:HTTPRequest,res:HTTPResponse){
        res.render(template: "blog/life")
    }
    
    //碎言碎语
    static func doing(req:HTTPRequest,res:HTTPResponse){
        res.render(template: "blog/doing")
    }
    
    //技术分享
    static func techshare(req:HTTPRequest,res:HTTPResponse){
        res.render(template: "blog/techshare")
    }
    
    //Wiki
    static func wiki(req:HTTPRequest,res:HTTPResponse){
        res.render(template: "blog/wiki")
    }
    
    //留言版
    static func gustbook(req:HTTPRequest,res:HTTPResponse){
        res.render(template: "blog/gustbook")
    }
    
    //topic
    static func topicGetList(data: [String:Any]) throws -> RequestHandler {
        return {
            request, response in
            do{
                let page_no = request.param(name: "page_no")?.int ?? 1
                
                //blogindex=>0  bloglife=>1    blogdoing=>2  blogtechshare=>3
                let topic_type = request.param(name: "type") ?? "blogindex"
                
                let page_size = page_config.index_topic_page_size
                var total_count = 0
                total_count = try BlogDataService.get_topic_count(topic_type: topic_type)
                let total_page = Utils.total_page(total_count: total_count, page_size: page_size)
                
                let categorys  = BlogDataService.topic_get_all_bypage(topic_type: topic_type,page_no: page_no, page_size: page_size)
                
//                for category:TopicEntity  in categorys! {
//                    var str = category.content.substring(0, length: 100)
//                    category.content = str
//                }

                if categorys == nil {
                    try response.setBody(json: ["success":false])
                    response.completed()
                    return
                }
                let encoded = try? encoder.encode(categorys)
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
    
    //博客详情
    static func blogDetail(data: [String:Any]) throws -> RequestHandler {
        return {
            req,res in
            do {
                guard let topic_id = req.urlVariables["id"]?.int else {
                    res.render(template: "error", context: ["errMsg":"参数错误"])
                    return
                }
                let row = try BlogDataService.topic_get_byid(topic_id: topic_id)
                guard row.count > 0 else {
                    res.render(template: "error", context: ["errMsg":"您要查看的文章不存在或者您没有权限查看."])
                    return
                }
                let encoded = try? encoder.encode(row[0])
                if encoded != nil {
                    if let json = encodeToString(data: encoded!){
                        if let decoded = try json.jsonDecode() as? [String:Any] {
                            res.render(template: "blog/blogdetail", context: ["topic":decoded])
                        }
                    }
                }
            }catch{
                Log.error(message: "\(error)")
            }
        }
    }
    
}
