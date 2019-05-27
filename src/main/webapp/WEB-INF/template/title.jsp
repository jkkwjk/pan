<div id="title">
    <div id="title_left" style="background-image: url(${pageContext.request.contextPath}/static/img/file/logo.png);"></div>
    <div id="title_main">
        <ul class="ul_my" id="ul_title">
            <li class="li_float_left li_title title_active" style="margin-left: 10px;">
                <a href="#" class="a_block">文件</a>
            </li>
            <li class="li_float_left li_title">
                <a href="#" class="a_block">分享</a>
            </li>
        </ul>
        <div id="title_right">
            <div id="user_name_group">
                <img src="${pageContext.request.contextPath}/static/img/user/default.jpg" id="user_name_img">
                <div id="user_name">用户名</div>
                <span class="glyphicon glyphicon-chevron-down" style="margin-right: 20px;"></span><!--向下箭头-->

                <div id="user_name_animation_nomal"><!--隐藏动画-->
                    <div id="user_name_animation_top" style="background-image: url(${pageContext.request.contextPath}/static/img/file/user-level-bg-0.png);"><!--顶部-->
                        <div id="user_name_animation_top_img_bg">
                            <img id="user_name_animation_top_img" src="${pageContext.request.contextPath}/static/img/user/default.jpg">
                        </div>
                        <span id="user_name_animation_top_username">用户名</span>
                    </div>

                    <div id="user_name_animation_main">
                        <ul class="ul_my">
                            <a href="#" class="a_user_name_animation"><li>个人资料</li></a>
                            <!-- 无二级密码跳设置 有跳修改密码-->
                            <a href="#" class="a_user_name_animation"><li>二级密码</li></a>
                            <a href="#" class="a_user_name_animation"><li>退出</li></a>
                        </ul>
                    </div>
                </div>
            </div>
            <input type="text" class="form-control" placeholder="搜索文件" aria-describedby="basic-addon1" style="display: inline;width: 200px;border-radius: 100px;">
            <button class="btn_search" style="font-size: 100%;margin-left: -35px;">
                <span class="glyphicon glyphicon-search" style="margin-left: 5px;font-size: 15px;"></span>
            </button>

        </div>
    </div>
</div>