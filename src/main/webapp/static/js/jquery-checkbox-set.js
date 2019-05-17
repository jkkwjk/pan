(function ($) {
    $.fn.extend({
        "set_checked": function (b) {
            this.prop("checked",b);
            $.each(this,function(i,item){
                if ($(item).attr('id')!="all_file"){
                    if (b==true){
                        $(item).parent().parent().parent().css('background-color','rgba(65, 159, 247, 0.18)');
                    }else {
                        $(item).parent().parent().parent().removeAttr('style');
                    }
                }
            });
        },
        "get_checked": function() {
            return !this.prop("checked");
        },
        "check_all": function() {
            $("input[type='checkbox']").set_checked(true);
        },
        "uncheck_all": function() {
            $(":checked").set_checked(false);
        }
    });
    $.fn.extend({
        "only_select": function () {
            $(":checked").set_checked(false);
            this.set_checked(true);
        }
    });
})(jQuery);
jQuery.extend({
    set_elemt_check: function(elemt,check) {
        elemt.set_checked(check);
    },
    check_num: function(){
        var len = $(":checked[id!='all_file']").length;
        return len;
    }
});