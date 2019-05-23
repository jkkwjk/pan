function get_next_file(start,folder) {
    if (has_next == 1){
        $.post(base_path+"/file/getfile",{'start':start,'folder':folder},function (data) {
            var template="<tr class=\"file_tr\" id=\"{rs_id}\" type={file_type}><td class=\"file_left\"><div class=\"checkbox_div\"><input type=\"checkbox\"></div><img src=\""+base_path+"/static/img/file/file_ico/{file_ico}.png\" class=\"file_img\"><a href=\"#\" class=\"a_file_name\"><span class=\"file_name\">{file_name}</span></a></td><td class=\"file_mid\">{file_size}</td><td class=\"file_right\">{file_time}</td></tr>\n";
            $.each(data.data,function (i,item) {
                var add = template.replace("{rs_id}",item.rs_id);
                add = add.replace("{file_type}",item.file_type);
                add = add.replace("{file_name}",item.file_name);
                add = add.replace("{file_size}",item.file_size);
                add = add.replace("{file_time}",item.file_time);
                add = add.replace("{file_ico}",item.file_ico);
                $("#file_table").append(add);
            });
            file_num += data.file_num;
            file_start += data.file_num;
            has_next = data.has_next;
            $("#file_num").text(file_num);
        },'json')
    }
}