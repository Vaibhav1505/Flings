
function initEntry(a/*string*/,b/*string*/,c/*number*/){
    var p = document.getElementById('progress-bar');

    $.ajax({
        url:'entry',
        type:'post',
        data:{a:a.value,b:b.value,c:c},
        beforeSend:function(){
            p.hidden = false;
        },
        success:function(d){
            setCookie('at',d.at,30);
            window.location.href = "home";
            p.hidden = true;
            },
        error:function(d){
            p.hidden = true;
            alert(d.responseText);
        }

    });
}

function add_e(){document.getElementsByTagName("button")[0].addEventListener('click',function(){
    var a = this.parentElement.parentElement.getElementsByTagName("input")[0];
    var b = this.parentElement.parentElement.getElementsByTagName("input")[1];

    if(a.value.length<1||b.value.length<1)
        return alert("Enter valid credentials");

    initEntry(a,b,Date.now());});
}

function setCookie(cName, cValue, expDays) {
    let date = new Date();
    date.setTime(date.getTime() + (expDays * 24 * 60 * 60 * 1000));
    const expires = "expires=" + date.toUTCString();
    document.cookie = cName + "=" + cValue + "; " + expires + "; path=/";
}