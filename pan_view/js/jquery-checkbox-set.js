(function ($) {
    $.fn.extend({
        "set_checked": function (b) {
            this.prop("checked",b);
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
    has_any_check: function(){
        var len = $(":checked[id!='all_file']").length;
        if (len!=0) {
            return true;
        }
        else {
            return false;
        }
    }
});