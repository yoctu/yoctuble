function ReallyAddIt() {
    try {
        JSON.parse($("#instanceJson").val());
    } catch (e) {
        $('#CMDBAddModal').modal('hide');
        $('#modal-comment').html("not a JSON Useless DEV !!!!");
        $('#CommentModal').modal('show');
        return;
    }
    var project = $("#select-cmdb-project").val();
    var env = $("#select-cmdb-env").val();
    var app = $("#select-cmdb-app").val();
    var instance = $("#instanceName").val();
    $.ajax({
        type: "POST",
        data: JSON.stringify({ instance: instance }),
        contentType: "application/json",
        url: "https://cmdb.dev.yoctu.com/v1/project/"+project+"/environment/"+env+"/application/"+app+"/instances",
        dataType: "json",
        success: function (result) {
            $.ajax({
                type: "POST",
                contentType: "application/json",
                data: $("#instanceJson").val(),
                url: "https://cmdb.dev.yoctu.com/v1/app/project/"+project+"/environment/"+env+"/application/"+app+"/instance/"+instance+"/section/specific",
                dataType: "json",
                success: function (data) {
                    $('#CMDBAddModal').modal('hide');
                    cmdb();
                }
            });
        }
    });
}

function deleteIt(instance) {
    $("#confirm-modal-yes").unbind('click').click(function () {
        ReallyDeleteIt(instance);
    });
    $("#QuestionModal").modal('show');
}

function ReallyDeleteIt(instance) {
    var project = $("#select-cmdb-project").val();
    var env = $("#select-cmdb-env").val();
    var app = $("#select-cmdb-app").val();
    $.ajax({
        type: "DELETE",
        contentType: "application/json",
        url: "https://cmdb.dev.yoctu.com/v1/project/"+project+"/environment/"+env+"/application/"+app+"/instance/"+instance,
        dataType: "json",
        success: function (result) {
            cmdb();
            $("#QuestionModal").modal('hide');
        }
    });
}

function addIt() {
    $("#instanceName").val("");
    $("#instanceJson").val("");
    $("#CMDBAddModal").modal('show');
}

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
            let result = '<div align="right"><button class="btn btn-default btn-danger" onclick="addIt();"><span class="glyphicon glyphicon-plus"></span></button></div><br>';
            result += '<table id="cmdb" class="table responsive"><th>Instance Name</th><th>Action</th>';
            for (let instance in data) {
                result += '</tr><td>' + data[instance] + '</td><td>';
                result += '<a onclick="showSpecific(\''+data[instance]+'\');"> <span class="glyphicon glyphicon-eye-open"></span> ';
                result += '<a onclick="deleteIt(\''+data[instance]+'\');"> <span class="glyphicon glyphicon-remove"></span> ';
                result += '</td></tr>';
            }
            result += '</table>';
            $('#inventory-table').html(result);
        }
    });
    
}
