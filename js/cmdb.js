function showSpecific(instance) {
    var project = $("#select-cmdb-project").val();
    var env = $("#select-cmdb-env").val();
    var app = $("#select-cmdb-app").val();
    $('#modal-comment').html("");
    $.ajax({
        type: "GET",
        url: "https://cmdb.dev.yoctu.com/v1/app/project/"+project+"/environment/"+env+"/application/"+app+"/instance/"+instance+"/section/specific",
        dataType: "json",
        success: function (data) {
            $('#modal-comment').html('<pre id="json">'+JSON.stringify(data,undefined,2)+'</pre>');
            $('#CommentModal').modal('show');
        }
    });
}

function cmdb() {
    $('#inventory-table').html('<div align="center"><br><div class="loader"></div><br></div>');
    var project = $("#select-cmdb-project").val();
    var env = $("#select-cmdb-env").val();
    var app = $("#select-cmdb-app").val();
    $.ajax({
        type: "GET",
        url: "https://cmdb.dev.yoctu.com/v1/project/"+project+"/environment/"+env+"/application/"+app+"/instances",
        dataType: "json",
        success: function (data) {
            let result = '<table id="cmdb" class="table responsive"><th>Instance Name</th><th>Action</th>';
            for (let instance in data) {
                result += '</tr><td>' + data[instance] + '</td><td><a onclick="showSpecific(\''+data[instance]+'\');"><span class="glyphicon glyphicon-eye-open"></span></td></tr>';
                
            }
            result += '</table>';
            $('#inventory-table').html(result);
        }
    });
    
}
