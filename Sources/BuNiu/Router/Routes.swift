//
//  Routes.swift
//  Perfect-App-Template
//
//  Created by Jonathan Guthrie on 2017-02-20.
//	Copyright (C) 2017 PerfectlySoft, Inc.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the Perfect.org open source project
//
// Copyright (c) 2015 - 2016 PerfectlySoft Inc. and the Perfect project authors
// Licensed under Apache License v2.0
//
// See http://perfect.org/licensing.html for license information
//
//===----------------------------------------------------------------------===//
//

import PerfectHTTPServer
import PerfectLib
import PerfectHTTP
import OAuth2

func mainRoutes() -> [[String: Any]] {
    
    let dic = ApplicationConfiguration()
    
    GitHubConfig.appid = dic.appid
    GitHubConfig.secret = dic.secret
    
    GitHubConfig.endpointAfterAuth = dic.endpointAfterAuth
    GitHubConfig.redirectAfterAuth = dic.redirectAfterAuth
    

	var routes: [[String: Any]] = [[String: Any]]()

	routes.append(["method":"get", "uri":"/**", "handler":PerfectHTTPServer.HTTPHandler.staticFiles,
	               "documentRoot":"/Users/Kent/Downloads/BuNiu/webroot",
	               "allowRequestFilter":true,
	               "allowResponseFilters":true])
	


    
	//Handler for home page
    routes.append(["method":"get", "uri":"/", "handler":BlogController.index])
    //后台相关
    //admin
    routes.append(["method":"get", "uri":"/admin/adminLoginPage", "handler":adminController.adminLoginPage])
    routes.append(["method":"post", "uri":"/admin/adminLogin", "handler":adminController.adminLogin])
    routes.append(["method":"get", "uri":"/admin/adminIndex", "handler":adminController.adminIndex])
    routes.append(["method":"get", "uri":"/admin/adminInfo", "handler":adminController.adminInfo])
    //category
    routes.append(["method":"get", "uri":"/admin/adminCategoryList", "handler":adminController.adminCategoryList])
    routes.append(["method":"post", "uri":"/admin/adminAddCategory", "handler":adminController.adminAddCategory])
    routes.append(["method":"get", "uri":"/admin/adminAddCategoryPage", "handler":adminController.adminAddCategoryPage])
    routes.append(["method":"post", "uri":"/admin/adminUpdateCategory", "handler":adminController.adminUpdateCategory])
    routes.append(["method":"get", "uri":"/admin/adminCategory/{id}/update", "handler":adminController.adminUpdateCategoryPage])
    routes.append(["method":"post", "uri":"/admin/adminCategory/{id}/delete", "handler":adminController.adminDeleteCategory])
    
    
    //topic
    routes.append(["method":"get", "uri":"/admin/adminTopicList", "handler":adminController.adminTopicList])
    routes.append(["method":"post", "uri":"/admin/adminAddTopic", "handler":adminController.adminAddTopic])
    routes.append(["method":"get", "uri":"/admin/adminAddTopicPage", "handler":adminController.adminAddTopicPage])
    routes.append(["method":"post", "uri":"/admin/adminUpdateTopic", "handler":adminController.adminUpdateTopic])
    routes.append(["method":"get", "uri":"/admin/adminTopic/{id}/update", "handler":adminController.adminUpdateTopicPage])
    routes.append(["method":"post", "uri":"/admin/adminTopic/{id}/delete", "handler":adminController.adminDeleteTopic])
    
    //blog 前台相关
    routes.append(["method":"get", "uri":"/blog", "handler":BlogController.index])//首页
    routes.append(["method":"get", "uri":"/about", "handler":BlogController.about])//关于我
    routes.append(["method":"get", "uri":"/life", "handler":BlogController.life])//慢生活
    routes.append(["method":"get", "uri":"/doing", "handler":BlogController.doing])//碎言碎语
    routes.append(["method":"get", "uri":"/techshare", "handler":BlogController.techshare])//技术分享
    routes.append(["method":"get", "uri":"/wiki", "handler":BlogController.wiki])//Wiki
    routes.append(["method":"get", "uri":"/gustbook", "handler":BlogController.gustbook])//留言版
    //blog 前台请求数据
    routes.append(["method":"get", "uri":"/blog/topicGetList", "handler":BlogController.topicGetList])//首页
    routes.append(["method":"get", "uri":"/blog/topic/{id}/detail", "handler":BlogController.blogDetail])//首页
    
	return routes
}
