$.fn.extend({
    isPhoneNumber:function(){
        var text = this.val();
        var reg = /^0?(13[0-9]|15[012356789]|18[0236789]|14[57])[0-9]{8}$/;
        return(reg.test(text));
    },
    isUserName:function(){
        var text = this.val();
        var reg = /^[a-zA-Z]{1}([a-zA-Z0-9]|[._]){3,19}$/;
        return(reg.test(text));
    },
    isPassword:function(){
        var text = this.val();
        var reg = /^.*(?=.{6,16})(?=.*\d)(?=.*[A-Z]{1,})(?=.*[a-z]{1,}).*$/;
        return(reg.test(text));
    },
    isTrueName:function(){
        var text = this.val();
        var reg = /[^\x00-\x80]/;
        return(reg.test(text));
    },
    isCardId:function(){
        var text = this.val();
        var reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
        return(reg.test(text));
    },
    isEmail:function(){
        var text = this.val();
        var reg = /^([0-9A-Za-z\-_\.]+)@([0-9A-Za-z]+\.[A-Za-z]{2,3}(\.[A-Za-z]{2})?)$/g;
        return(reg.test(text));
    },

});