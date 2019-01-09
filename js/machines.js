var m_status = [];
m_status[5]="CREATING";
m_status[0]="UNKNOWN";
m_status[10]="STOPPED";
m_status[15]="DELETING";
m_status[20]="RUNNING";
m_status[25]="STARTING";
m_status[30]="STOPING";

var hostname;
var hostid;

function showModelDetail () {
    $('#modal-text').html('<div align="center"><br><div class="loader"></div><br></div>');
    $.ajax({
        type: "GET",
        url: "/ajaxgetconfig?action=getmodeldetail&model=" + $("#select-model").val(),
        dataType: "json",
        success: function (data) {
            for (var key in data) {
                if (data[key].split(',')[0] == $("#select-model").val()) { 
                    var cpu = data[key].split(',')[2];
                    var cpuspeed = data[key].split(',')[3];
                    var ram = data[key].split(',')[1];
                    var disk = data[key].split(',')[4];
                    var price = data[key].split(',')[5];
                }
            }
            row = '<table class="table table-responsive">';
            row += '<tr><th colspan="2">'+$("#select-model").val()+'</th></tr>';
            row += "<tr><td>cpu #</td>";
            row += "<td>" + cpu + "</td></tr>";
            row += "<tr><td>cpu speed</td>";
            row += "<td>" + cpuspeed + "</td></tr>";
            row += "<tr><td>ram size</td>";
            row += "<td>" + ram + "</td></tr>";
            row += "<tr><td>disk size</td>";
            row += "<td>" + disk + "</td></tr>";
            row += "<tr><th>price</th>";
            row += "<th>" + price + "$</th></tr>";
            row += "</table>";
            $('#modal-text').html(row);
            $('#MessageModal').modal('show');
        }
    });
}

function start (hostname, m_id) {
    $('#QuestionModal').modal('show');
    $("#confirm-modal-yes").unbind('click').click(function () {
    $('#QuestionModal').modal('hide');
    $('#modal-text').html('<div align="center"><br><div class="loader"></div><br></div>');
    $('#MessageModal').modal('show');
    $.post("/ajaxmachines", { action: "start", id: m_id, name: hostname, env: $("#select-env").val(), project: $("#select-project").val() })
        .done(function (data_start) {
            $('#modal-text').html(data_start);
            inventory();
        });
    });
}

function stop (hostname, m_id) {
    $('#QuestionModal').modal('show');
    $("#confirm-modal-yes").unbind('click').click(function () {
    $('#QuestionModal').modal('hide');
    $('#modal-text').html('<div align="center"><br><div class="loader"></div><br></div>');
    $('#MessageModal').modal('show');
    $.post("/ajaxmachines", { action: "stop", id: m_id, name: hostname, env: $("#select-env").val(), project: $("#select-project").val() })
        .done(function (data_stop) {
            $('#modal-text').html(data_stop);
            inventory();
        });
    });
}

function remove (hostname, m_id) {
    $('#QuestionModal').modal('show');
    $("#confirm-modal-yes").unbind('click').click(function () {
    $('#QuestionModal').modal('hide');
    $('#modal-text').html('<div align="center"><br><div class="loader"></div><br></div>');
    $('#MessageModal').modal('show');
    $.post("/ajaxmachines", { action: "remove", id: m_id, name: hostname, env: $("#select-env").val(), project: $("#select-project").val() })
        .done(function (data_remove) {
            $('#modal-text').html(data_remove);
            inventory();
        });
    });
}

function create () {
    $('#QuestionModal').modal('show');
    $("#confirm-modal-yes").unbind('click').click(function () {
    $('#QuestionModal').modal('hide');
    $('#modal-text').html('<div align="center"><br><div class="loader"></div><br></div>');
    $('#MessageModal').modal('show');
    $.post("/ajaxmachines", { action: "create", env: $("#select-env").val(), project: $("#select-project").val(), model: $("#select-model").val()  })
        .done(function (data_create) {
            $('#modal-text').html(data_create);
            inventory();
        });
    });
}

function goresize () {
    $.ajax({
        type: "POST",
        url: "/ajaxmachines",
        dataType: "json",
        data: { action: "resize", env: $("#select-env").val(), id: hostid, type: $("#select-model").val(), hostname: hostname },
        success: function(data) {
            $('#ResizeModal').modal('hide');
        }
    });

}

function savecomment() {
    $.ajax({
        type: "POST",
        url: "/ajaxcomment",
        dataType: "json",
        data: { id: hostid, project: $("#select-project").val(), env: $("#select-env").val(), comment: $('#machineComment').val(), hostname: hostname },
        success: function(data) {
            $('#comment_'+hostid).html($('#machineComment').val());
            $('#CommentModal').modal('hide');
        }    
    });
}

function resize (myhostname, myhostid) {
    hostname = myhostname;
    hostid = myhostid;
    $('#ResizeModal').modal('show');
}

function viewmachinecomment (myhostid, myhostname, comment) {
    hostname = myhostname;
    hostid = myhostid;
    html = '<input type="text" class="form-control" id="machineComment" placeholder="Enter Comment" value="'+comment+'"/>';
    $('#modal-comment').html(html);
    $('#CommentModal').modal('show');
}

function inventory () {
    $('#inventory-table').html('<div align="center"><br><div class="loader"></div><br></div>');
    row = '<thead><tr><td>Hostname</td><td>Size</td><td>Comment</td><td>Services</td><td colspan="2">Status</td><td>Action</td></tr></thead>';
    $.ajax({
        type: "GET",
        url: "/ajaxinventory?project=" + $("#select-project").val()+ "&env="+$("#select-env").val(),
        dataType: "json",
        success: function(data) {
            for (key in data.machines) {
                    if (!data.machines[key].m_status) continue;
                    if (data.machines[key].m_status == 20 && !data.services[key]) continue;
                    label_color  = data.machines[key].current_state == 0 ? 'label-success' : 'label-danger';
                    label_status = data.machines[key].current_state == 0 ? 'online' : 'offline';
                    row += '<tr>';
                    row += '<td title="created on '+data.machines[key].creation_date+'">'+data.machines[key].host_name;
                    if (data.machines[key].m_comment == "NULL") data.machines[key].m_comment = "";
                    row += ' <a href="#" id="machine_comment" onclick="viewmachinecomment(\''+data.machines[key].id+'\', \''+data.machines[key].host_name+'\', \''+data.machines[key].m_comment+'\');"><span class="glyphicon glyphicon-info-sign"></span></td>';
                    row += '<td><div id="m_type_"'+data.machines[key].id+'">'+data.machines[key].m_type+'</div></td>';
                    row += '<td><div id="comment_'+data.machines[key].id+'">'+data.machines[key].m_comment+'</div></td>';
                    row += '<td>';
                    if (data.machines[key].m_status == 20) {
                        if (data.services[key].ESM.current_state == 0) {
                            if (data.services[key].ESM.plugin_output != "" ) {
                                esm = data.services[key].ESM.plugin_output;
                                services = esm.versions;
                                for (service in services) {
                                    var port=8000;
                                    var proto="http";
                                    switch(service.split('-')[0]) {
                                        case "logger": port=8001; break;
                                        case "mailer": port=8002; break;
                                        case "notification": port=8003; break;
                                        case "connect_idp": port=8004; break;
                                        case "filer": port=8005; break;
                                        case "bid": port=8006; break;
                                        case "audit": port=8007; break;
                                        case "transform": port=8008; break;
                                        case "translate": port=8009; break;
                                        case "chat": port=8010; break;
                                        case "connect": port=8011; break;
                                        case "payment": port=8012; break;
                                        case "locate": port=8013; break;
                                        case "shaq": port=8014; break;
                                        case "esm": port=8000; proto="https"; break;
                                        default : port=8000;
                                    }
                                    url = proto+"://"+data.machines[key].host_name+'.'+$("#select-env").val().split('-')[0]+'.'+$("#select-project").val()+'.ovh:'+port+'/';
                                    version = services[service];
                                    row += '<a href="'+url+'" target="_blank"><img title="'+service+' : '+version+'" src="https://logos.yoctu.com/logo-svg-white/'+service.split('-')[0]+'-white.svg" height="24px;" width="24px;" /></a> ';
                                }
                            }
                        }
                    }
                    row += '</td>';
                    row += '<td>'+m_status[data.machines[key].m_status]+'</td>';
                    row += '<td><span class="label '+label_color+'">'+label_status+'</span></td>';
                    row += '<td>';
                    if (data.machines[key].m_status == 20) {
                        if (data.services[key].ESM.current_state == 0) {
                            row += '<a href="https://'+data.machines[key].host_name+'.'+$("#select-project").val()+'.ovh:8000/" target="_blank"><span class="glyphicon glyphicon-eye-open" /></a>&nbsp;&nbsp;';
                            row += '<a href="#" onclick="stop(\''+data.machines[key].host_name+'\',\''+data.machines[key].id+'\');"><span class="glyphicon glyphicon-stop" /></a>&nbsp;&nbsp;';
                            row += '<a href="#" onclick="resize(\''+data.machines[key].host_name+'\',\''+data.machines[key].id+'\');"><span class="glyphicon glyphicon-upload" /></a>&nbsp;&nbsp;';
                        } else {
                            row += '<span class="glyphicon glyphicon-eye-open text-danger" />&nbsp;&nbsp;';
                            row += '<span class="glyphicon glyphicon-stop text-danger" />&nbsp;&nbsp;';
                        }
                    }
                    if (data.machines[key].m_status == 10) {
                        row += '<span class="glyphicon glyphicon-eye-open" />&nbsp;&nbsp;';
                        row += '<a href="#" onclick="start(\''+data.machines[key].host_name+'\',\''+data.machines[key].id+'\');"><span class="glyphicon glyphicon-play" /></a>&nbsp;&nbsp;';
                        row += '<a href="#" onclick="remove(\''+data.machines[key].host_name+'\',\''+data.machines[key].id+'\');"><span class="glyphicon glyphicon-remove-circle text-danger" /></a>&nbsp;&nbsp;'; 
                    }
                    row += '</td></tr>';
    		    $('#inventory-table').html(row);
            }
        }
    });
}

function getSelectOptionList () {
    $.ajax({
        type: "GET",
        url: "/ajaxgetconfig?action=getproject",
        dataType: "json",
        success: function(project) {
            $("#select-project").find('option').remove().end();
            for (key in project) {
                $('#select-project').append($('<option>', { value: project[key], text:project[key] }));
            }
            $("#select-project").val(project[0]);
        }
    });
    $.ajax({
        type: "GET",
        url: "/ajaxgetconfig?action=getenv",
        dataType: "json",
        success: function(env) {
            $("#select-env").find('option').remove().end();
            for (key in env) {
                if (key === 0) $("#select-env").val(env[key]);
                $('#select-env').append($('<option>', { value: env[key], text: env[key] }));
            }
            inventory();
        }
    });
    $.ajax({
        type: "GET",
        url: "/ajaxgetconfig?action=getmodel",
        dataType: "json",
        success: function(model) {
            $("#select-model").find('option').remove().end();
            $("#select-model-2").find('option').remove().end();
            for (key in model) {
                $('#select-model').append($('<option>', { value: model[key].split(',')[0], text: model[key].split(',')[0] }));
                $('#select-model-2').append($('<option>', { value: model[key].split(',')[0], text: model[key].split(',')[0] }));
            }
            $("#select-model").val(project[0]);
            $("#select-model-2").val(project[0]);
        }
    });

}

getSelectOptionList();
