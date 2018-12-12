$.ajax({
    type: "GET",
    url: "/ajaxlogout",
    success: function() {
        var ca = document.cookie.split(';');
        for(var i=0;i < ca.length; i++) {
            var spcook =  ca[i].split("=");
            document.cookie = spcook[0] + "=;expires=0;";
        }
        $("#navbar-header").hide();   
        return null;
    }
});
