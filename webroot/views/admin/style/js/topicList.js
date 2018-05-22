(function (L) {
    var _this = null;
    L.TopicList = L.TopicList || {};
    _this = L.TopicList = {
        data: {

        },
        init: function () {
            _this.loadTopics("default");
            _this.initEvents();
        },
        initEvents: function(){
            _this.initDeleteTopic();
        },

        loadTopics: function(type, pageNo){
//            NProgress.start();
        	pageNo = pageNo || 1;
        	$.ajax({
	            url : '/admin/adminTopicList',
	            type : 'get',
	            cache: false,
	            data: {
	                page_no: 1,
	                type: type,
	            },
	            dataType : 'json',
	            success : function(result) {
//                   NProgress.done();
	                if(result.success){
	                	if(!result.data || (result.data && result.data.topics.length<=0)){
	                		$("#topics-body").html('<div class="alert alert-info" role="alert">此分类下没有任何内容</div>');
	                	}else{
	                		 _this.page(result, type, 1);
	                	}
	                }else{
	                    $("#topics-body").html('<div class="alert alert-danger" role="alert">'+result.msg+'</div>');
	                }
	            },
	            error : function() {
//                   NProgress.done();
					console.log("error")
	                $("#topics-body").html('<div class="alert alert-danger" role="alert">error to send request.</div>');
	            }
	        });
        },

        page: function(result, type, pageNo){
			var data = result.data || {};
			var $container = $("#topics-body");
			$container.empty();

			var tpl = $("#topic-item-tpl").html();
            var html = juicer(tpl, data);
            $container.html(html);

            var currentPage = data.currentPage;
            var totalPage = data.totalPage;
            var totalCount = data.totalCount;
            if (totalPage > 1) {
                $("#pagebar").show();
                $.fn.jpagebar({
                    renderTo : $("#pagebar"),
                    totalpage : totalPage,
                    totalcount : totalCount,
                    pagebarCssName : 'pagination2',
                    currentPage : currentPage,
                    onClickPage : function(pageNo) {
                        $.fn.setCurrentPage(this, pageNo);
                        $.ajax({
                            url : '/admin/adminTopicList',
                            type : 'get',
                            cache: false,
                            data: {
                                page_no: pageNo,
                                type: type,
                            },
                            dataType : 'json',
                            success : function(result) {
                                var data = result.data || {};
                                var $container = $("#topics-body");
                                $container.empty();

                                var tpl = $("#topic-item-tpl").html();
                                var html = juicer(tpl, data);
                                $container.html(html);
                            },
                            error : function() {
                                 $("#topics-body").html('<div class="alert alert-danger" role="alert">error to find topics page.</div>');
                            }
                        });
                    }
                });
            } else {
                $("#pagebar").hide();
            }
        },
 
        initDeleteTopic: function(){
        	$(document).on("click", ".delete-topic", function(){
        		var topic_id = $(this).attr("data-id");
        		$.ajax({
                    url : '/admin/adminTopic/'+topic_id+'/delete',
                    type : 'post',
                    data : {},
                    dataType : 'json',
                    success : function(result) {
                        if(result.success){
                            self.parent.document.getElementById("mainframe").src="/views/admin/topicList.html";
                        }else{
                            // L.Common.showTipDialog("提示", result.msg);
                            _this.showTipDialog("提示", result.msg);
                        }
                    },
                    error : function() {
                        // L.Common.showTipDialog("提示", "删除文章请求发生错误");
                        _this.showTipDialog("提示","删除文章请求发生错误");
                    }
                });
        	});
        },
 
 
        showTipDialog: function (title, content) {
            if (!content) {
                content = title;
                title = "Tips";
            }
            var d = dialog({
                title: title || 'Tips',
                content: content,
                width: 350,
                cancel: false,
                ok: function () {
                }
            });
            d.show();
        },
 
 
    };
}(APP));
