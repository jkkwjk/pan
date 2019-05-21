<!-- 页面复用: 左列表 顶部列表 设置active即可 -->
<%@ page import="com.jkk.service.AttrToken" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/default.css"> <!--link_tag -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/file.css"> <!--link_tag -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/title.css"> <!--link_tag -->

    <title>在线网盘-全部文件</title>
    <script src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/jquery-checkbox-set.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/title.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/file.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
    <script src="${pageContext.request.contextPath}/static/js/file-fn.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {

            $(".a_file_name").click(function () {

                alert("${sessionScope[AttrToken.USER].name}");
            })
        });
    </script> <!-- 事件处理 -->
    <script type="text/javascript">

    </script> <!-- 页面加载完成 -->
</head>
<body>
    <div id="warp" style="min-width: 1100px;user-select: none;">
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
        <div id="main">
            <div id="main_left" style="position: relative;">
                <ul class="ul_my">
                    <a href="#" class="a_left" style="margin-top: 10px;" id="left_list_active"> <!--bug可能-->
                        <li class="li_left">
                            <span class="glyphicon glyphicon-folder-open" id="glyphicon_li_left"></span> <!--图标-->
                            全部文件
                        </li>
                    </a>
                    <a href="#" class="a_left"><li class="li_left">图片</li></a>
                    <a href="#" class="a_left"><li class="li_left">视频</li></a>
                    <a href="#" class="a_left"><li class="li_left">音乐</li></a>
                    <a href="#" class="a_left"><li class="li_left">文档</li></a>
                    <a href="#" class="a_left"><li class="li_left">其他</li></a>
                    <a href="#" class="a_left">
                        <li class="li_left">
                            <span class="glyphicon glyphicon-paperclip" id="glyphicon_li_left"></span>
                            我的分享
                        </li>
                    </a>
                    <a href="#" class="a_left">
                        <li class="li_left">
                            <span class="glyphicon glyphicon-trash" id="glyphicon_li_left"></span>
                            回收站
                        </li>
                    </a>
                </ul>
                <div id="left_bottom">
                    <div id="left_process_bar">
                        <!-- 进度条示例 -->
                        <div class="progress" style="height: 5px;">
                            <!-- 进度条填充 -->
                            <div class="progress-bar" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%;"></div>
                        </div>
                    </div>
                    <!-- 后端交互 -->
                    <div style="font-size: 10px;">
                        <span id="span_used_capacity">800MB</span>
                        <span>/</span>
                        <span id="span_all_capacity">1G</span>
                    </div>
                    
                </div>
            </div>
            <div id="main_main">
                <div id="main_main_top">
                    <div class="btn-group">
                        <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <span class="glyphicon glyphicon-cloud-upload" style="margin-right: 2px;"></span>上传
                        </button>
                        <ul class="dropdown-menu">
                            <li><a href="#">上传文件</a></li>
                            <li role="separator" class="divider" style="margin: 2px 0;"></li>
                            <li><a href="#">上传文件夹</a></li>
                        </ul>
                    </div>
                    <button type="button" class="btn btn-light button_main_main_top" style="border: 1px #C3EAFF solid;">
                        <span class="glyphicon glyphicon-hdd" style="margin-right: 2px;"></span> 新建文件夹
                    </button>
                    <div class="btn-group button_main_main_top" id="btn_group" style="display: none;">
                        <button id="btn_download" type="button" class="btn btn-default button_main_main_top">
                            <span class="glyphicon glyphicon-cloud-download" style="margin-right: 2px;"></span>下载
                        </button>
                        <button id="btn_share" type="button" class="btn btn-default button_main_main_top">
                            <span class="glyphicon glyphicon-tags" style="margin-right: 2px;"></span>
                            分享
                        </button>
                        <button id="btn_delete" type="button" class="btn btn-default button_main_main_top">删除</button>
                        <button id="btn_rename" type="button" class="btn btn-default button_main_main_top">重命名</button>
                    </div>
                </div>

                <div style="padding-right: 20px;padding-left: 20px;">
                    <span>全部文件</span>
                    <div style="float: right">
                        <span id="file_load_all">已全部加载</span>
                        <span>,共</span>
                        <span id="file_num">1</span>
                        <span>个</span>
                    </div>
                </div>

                <div style="height: 20px;margin-top: 5px;">
                    <div id="filehead_left">
                        <input type="checkbox" id="all_file">
                        <span class="span_file_attr">文件名</span>
                    </div>
                    <div id="filehead_mid">
                        <span class="span_file_attr">大小</span>
                    </div>
                    <div id="filehead_right">
                        <span class="span_file_attr">修改日期</span>
                    </div>
                </div>
                <div id="file_main" style="">
                    <table id="file_table">
                        <%--1代表文件夹--%>
                        <tr class="file_tr" id="{rs_id}" type={file_type}><td class="file_left"><div class="checkbox_div"><input type="checkbox"></div><img src="${pageContext.request.contextPath}/static/img/file/file_ico/{file_type}.png" class="file_img"><a href="#" class="a_file_name"><span class="file_name">{file_name}</span></a></td><td class="file_mid">{file_size}</td><td class="file_right">{file_time}</td></tr>
                        <tr class="file_tr" id="{rs_id}" type=0><td class="file_left"><div class="checkbox_div"><input type="checkbox"></div><img src="${pageContext.request.contextPath}/static/img/file/file_ico/{file_type}.png" class="file_img"><a href="#" class="a_file_name"><span class="file_name">{file_name}</span></a></td><td class="file_mid">{file_size}</td><td class="file_right">{file_time}</td></tr>
                        <tr class="file_tr" id="{rs_id}" type=1><td class="file_left"><div class="checkbox_div"><input type="checkbox"></div><img src="${pageContext.request.contextPath}/static/img/file/file_ico/{file_type}.png" class="file_img"><a href="#" class="a_file_name"><span class="file_name">{file_name}</span></a></td><td class="file_mid">{file_size}</td><td class="file_right">{file_time}</td></tr>
                        <tr class="file_tr" id="{rs_id}" type=1><td class="file_left"><div class="checkbox_div"><input type="checkbox"></div><img src="${pageContext.request.contextPath}/static/img/file/file_ico/{file_type}.png" class="file_img"><a href="#" class="a_file_name"><span class="file_name">{file_name}</span></a></td><td class="file_mid">{file_size}</td><td class="file_right">{file_time}</td></tr>
                        <tr class="file_tr">
                            <td class="file_left">
                                <div class="checkbox_div">
                                    <input type="checkbox" name="" id="">
                                </div>
                                <img src="${pageContext.request.contextPath}/static/img/file/file_ico/folder.png" class="file_img">
                                <a href="#" class="a_file_name"><span class="file_name">麻瓜编程2017</span></a>
                            </td>
                            <td class="file_mid">34</td>
                            <td class="file_right">34</td>
                        </tr>
                        <tr class="file_tr">
                            <td class="file_left">
                                <div class="checkbox_div">
                                    <input type="checkbox" name="" id="">
                                </div>
                                <img src="${pageContext.request.contextPath}/static/img/file/file_ico/folder.png" class="file_img">
                                <a href="#" class="a_file_name"><span class="file_name">麻瓜编程2017</span></a>
                            </td>
                            <td class="file_mid">34</td>
                            <td class="file_right">34</td>
                        </tr>
                        <tr class="file_tr">
                            <td class="file_left">
                                <div class="checkbox_div">
                                    <input type="checkbox" name="" id="">
                                </div>
                                <img src="${pageContext.request.contextPath}/static/img/file/file_ico/folder.png" class="file_img">
                                <a href="#" class="a_file_name"><span class="file_name">麻瓜编程2017</span></a>
                            </td>
                            <td class="file_mid">34</td>
                            <td class="file_right">34</td>
                        </tr>
                        <tr class="file_tr">
                            <td class="file_left">
                                <div class="checkbox_div">
                                    <input type="checkbox" name="" id="">
                                </div>
                                <img src="${pageContext.request.contextPath}/static/img/file/file_ico/folder.png" class="file_img">
                                <a href="#" class="a_file_name"><span class="file_name">麻瓜编程2017</span></a>
                            </td>
                            <td class="file_mid">34</td>
                            <td class="file_right">34</td>
                        </tr>
                        <tr class="file_tr">
                            <td class="file_left">
                                <div class="checkbox_div">
                                    <input type="checkbox" name="" id="">
                                </div>
                                <img src="${pageContext.request.contextPath}/static/img/file/file_ico/folder.png" class="file_img">
                                <a href="#" class="a_file_name"><span class="file_name">麻瓜编程2017</span></a>
                            </td>
                            <td class="file_mid">34</td>
                            <td class="file_right">34</td>
                        </tr>
                        <tr class="file_tr">
                            <td class="file_left">
                                <div class="checkbox_div">
                                    <input type="checkbox" name="" id="">
                                </div>
                                <img src="${pageContext.request.contextPath}/static/img/file/file_ico/folder.png" class="file_img">
                                <a href="#" class="a_file_name"><span class="file_name">麻瓜编程2017</span></a>
                            </td>
                            <td class="file_mid">34</td>
                            <td class="file_right">34</td>
                        </tr>
                        <tr class="file_tr">
                            <td class="file_left">
                                <div class="checkbox_div">
                                    <input type="checkbox" name="" id="">
                                </div>
                                <img src="${pageContext.request.contextPath}/static/img/file/file_ico/folder.png" class="file_img">
                                <a href="#" class="a_file_name"><span class="file_name">麻瓜编程2017</span></a>
                            </td>
                            <td class="file_mid">34</td>
                            <td class="file_right">34</td>
                        </tr>
                        <tr class="file_tr">
                            <td class="file_left">
                                <div class="checkbox_div">
                                    <input type="checkbox" name="" id="">
                                </div>
                                <img src="${pageContext.request.contextPath}/static/img/file/file_ico/folder.png" class="file_img">
                                <a href="#" class="a_file_name"><span class="file_name">麻瓜编程2017</span></a>
                            </td>
                            <td class="file_mid">34</td>
                            <td class="file_right">34</td>
                        </tr>
                        <tr class="file_tr">
                            <td class="file_left">
                                <div class="checkbox_div">
                                    <input type="checkbox" name="" id="">
                                </div>
                                <img src="${pageContext.request.contextPath}/static/img/file/file_ico/folder.png" class="file_img">
                                <a href="#" class="a_file_name"><span class="file_name">麻瓜编程2017</span></a>
                            </td>
                            <td class="file_mid">34</td>
                            <td class="file_right">34</td>
                        </tr>
                        <tr class="file_tr">
                            <td class="file_left">
                                <div class="checkbox_div">
                                    <input type="checkbox" name="" id="">
                                </div>
                                <img src="${pageContext.request.contextPath}/static/img/file/file_ico/folder.png" class="file_img">
                                <a href="#" class="a_file_name"><span class="file_name">麻瓜编程2017</span></a>
                            </td>
                            <td class="file_mid">34</td>
                            <td class="file_right">34</td>
                        </tr>
                        <tr class="file_tr">
                            <td class="file_left">
                                <div class="checkbox_div">
                                    <input type="checkbox" name="" id="">
                                </div>
                                <img src="${pageContext.request.contextPath}/static/img/file/file_ico/folder.png" class="file_img">
                                <a href="#" class="a_file_name"><span class="file_name">麻瓜编程2017</span></a>
                            </td>
                            <td class="file_mid">34</td>
                            <td class="file_right">34</td>
                        </tr>
                        <tr class="file_tr">
                            <td class="file_left">
                                <div class="checkbox_div">
                                    <input type="checkbox" name="" id="">
                                </div>
                                <img src="${pageContext.request.contextPath}/static/img/file/file_ico/folder.png" class="file_img">
                                <a href="#" class="a_file_name"><span class="file_name">麻瓜编程2017</span></a>
                            </td>
                            <td class="file_mid">34</td>
                            <td class="file_right">34</td>
                        </tr>
                        <tr class="file_tr">
                            <td class="file_left">
                                <div class="checkbox_div">
                                    <input type="checkbox" name="" id="">
                                </div>
                                <img src="${pageContext.request.contextPath}/static/img/file/file_ico/folder.png" class="file_img">
                                <a href="#" class="a_file_name"><span class="file_name">麻瓜编程2017</span></a>
                            </td>
                            <td class="file_mid">34</td>
                            <td class="file_right">34</td>
                        </tr>


                    </table>
                </div>
            </div>
            
        </div>
    </div>
</body>
</html>