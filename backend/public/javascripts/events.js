function setAttributes(el, attrs) {
    for(var key in attrs) {
        el.setAttribute(key, attrs[key]);
    }
}
function createDOM(tag, className, attributeJson, innerHtml){
    var element = document.createElement(tag);
    element.className = className;
    setAttributes(element,attributeJson);
    if(className!=null){
        element.className = className;
    }
    if(innerHtml!=null){
        element.innerHTML = innerHtml;
    }
    return element
}

function getEventView(_id, title, imgSrc, category){
    var pd = createDOM('div','event',{},null);
    var img = createDOM('img','event-thumb',{src:(imgSrc?"/events/media/"+imgSrc+"_small":'https://image.flaticon.com/icons/png/128/3308/3308415.png')},null);

    var d1 = createDOM('div',null,{},null);
    var d2 = createDOM('div',null,{},null);
    var d21 = createDOM('div',null,{},null);
    var d21s = createDOM('span',null,{},title);
    var d22 = createDOM('div',null,{},null);
    var d22l = createDOM('label',null,{},'Inventory: ');
    var d22s = createDOM('span',null,{},'');
    var d23 = createDOM('div',null,{},null);
    var d23l = createDOM('label',null,{},'Category: ');
    var d23s = createDOM('span',null,{},(category)?category.toUpperCase():'NOT SELECTED');

    d1.appendChild(img);
    d21.appendChild(d21s);
    d22.appendChild(d22l);
    d22.appendChild(d22s);
    d23.appendChild(d23l);
    d23.appendChild(d23s);
    d2.appendChild(d21);
    d2.appendChild(d22);
    d2.appendChild(d23);
    pd.appendChild(d1);
    pd.appendChild(d2);

    pd.onclick = function(){

        window.location.href = window.location.href+"/"+_id;
    };

    return pd;

}

function getEventsPost(query){
    console.log(query);
    var eventsContainer = document.getElementById('events-container');
    $.ajax({
        url:'/admin/events',
        type:"POST",
        data:{query:query},
        beforeSend:function(){
            document.getElementById("progress-bar").hidden = false;
        },
        success:function(data){
            console.log(data);
            eventsContainer.innerHTML="";
            if(data.events.length>0){
                for(var i=0;i<data.events.length;i++){
                    eventsContainer.appendChild(getEventView(data.events[i]._id,data.events[i].title,data.events[i].image,data.events[i].category));
                }
            }else{
                eventsContainer.innerHTML="<div class='event'><center><h1>No data found</h1></center></div>";
            }

        },
        complete:function (){
            document.getElementById("progress-bar").hidden = true;

        },
        error:function(response){
            document.getElementById("progress-bar").hidden = true;
        }
    })

}

class Modal{
    constructor() {
        this.model = this.open();
    }

    open(){
        var t = this;
        var o = __cd('div','overlay',{},null);
        var a = __cd('div','modal-container',{},null);
        var b = __cd('span','modal-title',{},'Add event');
        var c = __cd('i','bx bxs-x-circle',{},null);
        var e = __cd('input',null,{'placeholder':'Enter title for event','type':'text'},null);
        var f = __cd('button','button',{},'Next');

        a.appendChild(b);
        a.appendChild(c);
        a.appendChild(__cd('br',null,{},null));
        a.appendChild(__cd('br',null,{},null));
        a.appendChild(e);
        a.appendChild(__cd('br',null,{},null));
        a.appendChild(__cd('br',null,{},null));
        a.appendChild(f);
        o.appendChild(a);
        c.addEventListener('click',function(){
           o.remove();
        });

        f.addEventListener('click',function(){
            if(e.value.length>0){
                t.create(e.value);

            }else{
                return alert('Enter a valid title');

            }


        });

        var g = document.getElementsByTagName('body')[0];
        g.insertBefore(o,g.childNodes[0]);

        return o;
    }

    create(i){
        $.ajax({
           url:'events/new',
           method:'post',
           data:{'title':i},
            success:function(res){
               window.location.href = 'events/'+res.event._id;
            },
            error:function(err){
               alert(err.responseText);
            }
        });
    }



}


function __cd(t,c,a,i){
    var e = document.createElement(t);
    if(c!=null)
        e.className = c;

    setAttributes(e,a);
    if(i!=null){
        e.innerHTML = i;
    }
    return e;
}

