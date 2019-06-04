<%--
  Created by IntelliJ IDEA.
  User: jkkwjk
  Date: 2019/6/3
  Time: 22:52
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript">
    var timer = null;
    function tip_show(s,wclass) {
        $("#tip_span").text(s);
        // success绿色 info蓝色 danger红色
        $("#alert_div").attr('class','alert alert-'+wclass);
        my_show();
        setTimeout("my_hide();",1000);
    }
    function my_show(){
        var elemt = $("#tip");
        clearTimeout(timer);
        elemt.stop(true);
        elemt.css('display','inline');
        elemt.css('margin-top','0px');
        elemt.css('opacity','1');
    }
    function my_hide(){
        var elemt = $("#tip");
        elemt.stop(true);
        elemt.animate({'margin-top':'30px'},{queue:false,duration:400});
        elemt.animate({'opacity':'0'},{queue:false,duration:400});
        timer = setTimeout("$(\"#tip\").css('display','none')",400);
    }
</script> <!-- 动画 -->
<div id="tip" style="display: none;">
    <div class="alert alert-danger" role="alert" style="font-size:17px;text-align: center;padding: 10px;" id="alert_div">
        <span id="tip_span"></span>
    </div>
</div>
