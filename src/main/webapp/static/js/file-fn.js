function get_next_file(start) {
    $.post(base_path+"/file/getfile",{'start':start},function (data) {
        var template="<tr class=\"file_tr\" id=\"{rs_id}\" type={file_type}><td class=\"file_left\"><div class=\"checkbox_div\"><input type=\"checkbox\"></div><img src=\"${pageContext.request.contextPath}/static/img/file/file_ico/{file_ico}.png\" class=\"file_img\"><a href=\"#\" class=\"a_file_name\"><span class=\"file_name\">{file_name}</span></a></td><td class=\"file_mid\">{file_size}</td><td class=\"file_right\">{file_time}</td></tr>\n";
        $.each(data.data,function (i,item) {
            var add = template.replace("{rs_id}",item.rs_id);
            add = add.replace("{file_type}",item.file_type);
            add = add.replace("{file_name}",item.file_name);
            add = add.replace("{file_size}",item.file_size);
            add = add.replace("{file_time}",item.file_time);
            add = add.replace("{file_ico}",item.file_ico);
            $("#file_table").append(add);
        });

        $("#file_num").val($("#file_num").val()+data.file_num);
        file_num = file_num+data.file_num;

    },'json')
}