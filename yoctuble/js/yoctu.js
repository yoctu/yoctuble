jQuery(function($) {
    var panelList = $('#PanelList');
    panelList.sortable({
        handle: '.panel-heading', 
        update: function() {
            $('.panel', panelList).each(function(index, elem) {
                var $listItem = $(elem),newIndex = $listItem.index();
            });
        }
    });
});

function getCookie(name) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for(var i=0;i < ca.length;i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') c = c.substring(1,c.length);
        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
    }
    return null;
}

$(document).ready(function () {
    /**
     * @deprecated use page uniq value instead
     * @desc will set `active` class to menu element matching current url pathname
     **/
    $('.page-header .navbar ul.nav li.dropdown').each(function(index, htmlElement) {
        var item = $(htmlElement);
        var a = item.find('a').attr('class').split(" ");
        for (var i = 0; i < a.length; i++) {
            if(a[i] === window.location.pathname.replace("/","")) {
                item.addClass('active');
                return;
            }
        }
    });

    $("#yoctu_username").html('<span class="glyphicon glyphicon-user"></span> ' + getCookie('USERNAME') + ' <span class="glyphicon glyphicon-option-vertical"></span>');
    if (getCookie('USERNAME') != "") {
        $("#yoctu_logout").html('<li><a href="/logout" id="yoctu_logout_a"><i class="glyphicon glyphicon-log-out"></i> Logout</a></li>');
    }
});
