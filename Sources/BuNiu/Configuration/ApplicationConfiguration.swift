//
//  Configation.swift
//  Perfect
//
//  Created by apple on 2018/4/24.
//
//


struct page_config {
    static let index_topic_page_size = 5 //-- 首页每页文章数
}


//白名单(不判断处理登录)
let whitelist = [
    "^/m1",
    "^/m2",
    "^/index$",
    "^/ask$",
    "^/wiki$",
    "^/wiki/$",
    "^/wiki/[0-9a-zA-Z-_]+",
    "^/share$",
    "^/category/[0-9]+$",
    "^/topics/all$",
    "^/topic/[0-9]+/view$",
    "^/topic/[0-9]+/query$",
    "^/comments/all$",
    "^/user/[0-9a-zA-Z-_]+/index$",
    "^/user/[0-9a-zA-z-_]+/topics$",
    "^/user/[0-9a-zA-z-_]+/collects$",
    "^/user/[0-9a-zA-z-_]+/comments$",
    "^/user/[0-9a-zA-z-_]+/follows$",
    "^/user/[0-9a-zA-z-_]+/fans$",
    "^/user/[0-9a-zA-z-_]+/hot_topics$",
    "^/user/[0-9a-zA-z-_]+/like_topics$",
    "^/verification/",
    "^/login$",
    "^/email-verification",
    "^/auth/sign_up$",
    "^/about$",
    "^/to/github$",
    "^/register$",
    "^/auth/response/github",
    "^/error/$",
    "^/search/$",
    
    
    "^/admin/adminLoginPage$",
    "^/blog$",
    "^/life$",
    "^/doing$",
    "^/techshare$",
    "^/gustbook$",
]


#if os(Linux)
    struct ApplicationConfiguration {
        let baseURL =  "https://BuNiu"
        let baseDomain = "localhost"
        let mysqldbname  = "blog"
        let mysqlhost = "127.0.0.1"
        let mysqlport = 3306
        let mysqlpwd = "OZ3%48i.Ys,n"
        let mysqluser =  "root"
        let httpport =  8181
        let pwd_secret = "xxxxxxxxxxxxxxxx" //-- 用于存储密码的盐, 16位数
        
        //重定向
        let endpointAfterAuth = "https://BuNiu/auth/response/github"
        let redirectAfterAuth = "https://BuNiu/register"
        
        let appid = "be10650a64cea7214597"
        let secret = "4809540e7284c8ce12dd2f7f3ba93e17db3e9438"
    }
    
#else
    struct ApplicationConfiguration {
        let baseURL =  "http://localhost:8181"
        let baseDomain = "localhost"
        let mysqldbname  = "blog"
        let mysqlhost = "127.0.0.1"
        let mysqlport = 3306
        let mysqlpwd = "OZ3%48i.Ys,n"
        let mysqluser =  "root"
        let httpport =  8181
        let pwd_secret = "xxxxxxxxxxxxxxxx" //-- 用于存储密码的盐 16位数
        
        //重定
        let endpointAfterAuth = "http://localhost:8181/auth/response/github"
        let redirectAfterAuth = "http://localhost:8181/register"
        
        let appid = "be10650a64cea7214597"
        let secret = "4809540e7284c8ce12dd2f7f3ba93e17db3e9438"
    }
#endif









