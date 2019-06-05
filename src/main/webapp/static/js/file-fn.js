function get_next_file(start,folder) {
    if (has_next == 1 && isloding==false){
        isloding=true;
        $.post(base_path+"/file/getfile",{'start':start,'folder':folder},function (data) {
            $.each(data.data,function (i,item) {
                parse_file(item);
            });
            isloding=false;
            file_num += parseInt(data.file_num);
            has_next = data.has_next;
            $("#file_num").text(file_num);
        },'json');
    }
}

function search_file(name) {
    $.post(base_path+'/file/search',{'name':name},function (data) {
        $.each(data.data,function (i,item) {
            parse_file(item);
        });
        file_num += parseInt(data.file_num);
        $("#file_num").text(file_num);
    },'json');
}

function get_share_file() {
    $.post(base_path+'/share/get',function (data) {
        $.each(data.data,function (i,item) {
            var add ="<tr class=\"file_tr\" id=\"{rs_id}\" type={file_type} url={share_url}><td class=\"file_left\"><div class=\"checkbox_div\"><input type=\"checkbox\"></div><img src=\""+base_path+"/static/img/file/file_ico/{file_ico}.png\" class=\"file_img\"><a href=\"#\" class=\"a_file_name\" title='{share_time}'><span class=\"file_name\">{file_name}<span id='guoqi' style='color: red;margin-left: 10px;'>{share_guoqi}</span></span></a></td><td class=\"file_mid\">{file_size}</td><td class=\"file_right\">{file_time}</td></tr>\n";
            add = add.replace("{rs_id}",item.rs_id);
            add = add.replace("{file_type}",item.file_type);
            add = add.replace("{share_url}",item.share_url);
            add = add.replace("{share_time}","截止时间:"+item.share_time);
            add = add.replace("{share_guoqi}",item.share_guoqi);

            if (item.file_type==1){file_start++;}
            add = add.replace("{file_name}",item.file_name);
            add = add.replace("{file_size}",item.file_size);
            add = add.replace("{file_time}",item.file_time);
            add = add.replace("{file_ico}",item.file_ico);
            $("#file_table").append(add);
        });
        file_num += parseInt(data.file_num);
        $("#file_num").text(file_num);
    },'json');
}

function parse_file(item) {
    var add = template;
    add = add.replace("{rs_id}",item.rs_id);
    add = add.replace("{file_type}",item.file_type);
    if (item.file_type==1){file_start++;}
    add = add.replace("{file_name}",item.file_name);
    add = add.replace("{file_size}",item.file_size);
    add = add.replace("{file_time}",item.file_time);
    add = add.replace("{file_ico}",item.file_ico);
    $("#file_table").append(add);
}

function upload_step1(file){
    var fileReader = new FileReader();
    blobSlice = File.prototype.mozSlice || File.prototype.webkitSlice || File.prototype.slice,
        file,
        chunkSize = 2097152,
        chunks = Math.ceil(file.size / chunkSize),
        currentChunk = 0,
        spark = new SparkMD5();

    fileReader.onload = function(e) {
        spark.appendBinary(e.target.result);
        currentChunk++;

        if (currentChunk < chunks) {
            loadNext();
        }
        else {
            file_upload_submit(file,spark.end());
        }
    };
    function loadNext() {
        var start = currentChunk * chunkSize,
            end = start + chunkSize >= file.size ? file.size : start + chunkSize;

        fileReader.readAsBinaryString(blobSlice.call(file, start, end));
    }
    loadNext();
}

function cleanPage() {
    $("#file_table").empty();
    file_num = 0;
    file_start=0;
    has_next=1;
    $(".btn_group").css("display","none");
    $("#all_file").prop("checked",false);
    isloding=false;
}
function start_search(text) {
    folder_id_now = -1;
    has_next = 0;
    $("#ol_leader").empty();
    $("#ol_leader").append("<li fid=\"0\">"+text+"</li>");
    $("#search_display").find("button").attr('disabled',true);
}
function stop_search(fid,text) {
    cleanPage();
    folder_id_now = fid;
    has_next=1;
    $("#ol_leader").empty();
    $("#ol_leader").append("<li fid=\"0\">"+text+"</li>");
    $("#search_display").find("button").attr('disabled',false);
}

