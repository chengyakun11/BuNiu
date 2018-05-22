(function (L) {
    var _this = null;
    L.CategoryList = L.CategoryList || {};
    _this = L.CategoryList = {
        data: {

        },
        init: function () {
            _this.loadTopics("default");
            _this.initEvents();
        },
        initEvents: function(){
            _this.initDeleteCategory();
        },

        loadTopics: function(type, pageNo){
//            NProgress.start();
        	pageNo = pageNo || 1;
        	$.ajax({
	            url : '/admin/adminCategoryList',
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
	                	if(!result.data || (result.data && result.data.categorys.length<=0)){
	                		$("#categorys-body").html('<div class="alert alert-info" role="alert">此分类下没有任何内容</div>');
	                	}else{
	                		 _this.page(result, type, 1);
	                	}
	                }else{
	                    $("#categorys-body").html('<div class="alert alert-danger" role="alert">'+result.msg+'</div>');
	                }
	            },
	            error : function() {
//                   NProgress.done();
					console.log("error")
	                $("#categorys-body").html('<div class="alert alert-danger" role="alert">error to send request.</div>');
	            }
	        });
        },

        page: function(result, type, pageNo){
			var data = result.data || {};
			var $container = $("#categorys-body");
			$container.empty();

			var tpl = $("#category-item-tpl").html();
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
                            url : '/admin/adminCategoryList',
                            type : 'get',
                            cache: false,
                            data: {
                                page_no: pageNo,
                                type: type,
                            },
                            dataType : 'json',
                            success : function(result) {
                                var data = result.data || {};
                                var $container = $("#categorys-body");
                                $container.empty();

                                var tpl = $("#category-item-tpl").html();
                                var html = juicer(tpl, data);
                                $container.html(html);
                            },
                            error : function() {
                                 $("#categorys-body").html('<div class="alert alert-danger" role="alert">error to find categorys page.</div>');
                            }
                        });
                    }
                });
            } else {
                $("#pagebar").hide();
            }
        },
 
        initDeleteCategory: function(){
        	$(document).on("click", ".delete-category", function(){
        		var category_id = $(this).attr("data-id");
        		$.ajax({
                    url : '/admin/adminCategory/'+category_id+'/delete',
                    type : 'post',
                    data : {},
                    dataType : 'json',
                    success : function(result) {
                        if(result.success){
                            self.parent.document.getElementById("mainframe").src="/views/admin/categoryList.html";
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
