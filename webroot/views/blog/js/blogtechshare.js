(function (L) {
    var _this = null;
    L.BlogTechshare = L.BlogTechshare || {};
    _this = L.BlogTechshare = {
        data: {

        },
        init: function () {
            _this.loadTopics("blogtechshare");
            _this.initEvents();
        },
        initEvents: function(){
 
        },

        loadTopics: function(type, pageNo){
        	pageNo = pageNo || 1;
        	$.ajax({
	            url : '/blog/topicGetList',
	            type : 'get',
	            cache: false,
	            data: {
                    page_no: 1,
                    type: type,
	            },
	            dataType : 'json',
	            success : function(result) {
	                if(result.success){
	                	if(!result.data || (result.data && result.data.topics.length<=0)){
	                		$("#topics-boby").html('<div class="alert alert-info" role="alert">此分类下没有任何内容</div>');
	                	}else{
                            _this.page(result, type, 1);
	                	}
	                }else{
	                    $("#topics-boby").html('<div class="alert alert-danger" role="alert">'+result.msg+'</div>');
	                }
	            },
	            error : function() {
					console.log("error")
	                $("#topics-boby").html('<div class="alert alert-danger" role="alert">error to send request.</div>');
	            }
	        });
        },

        page: function(result, type, pageNo){
			var data = result.data || {};
			var $container = $("#topics-boby");
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
                            url : '/blog/topicGetList',
                            type : 'get',
                            cache: false,
                            data: {
                                page_no: pageNo,
                                type: type,
                            },
                            dataType : 'json',
                            success : function(result) {
                                var data = result.data || {};
                                var $container = $("#topics-boby");
                                $container.empty();

                                var tpl = $("#topic-item-tpl").html();
                                var html = juicer(tpl, data);
                                $container.html(html);
                            },
                            error : function() {
                                 $("#topics-boby").html('<div class="alert alert-danger" role="alert">error to find categorys page.</div>');
                            }
                        });
                    }
                });
            } else {
                $("#pagebar").hide();
            }
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
