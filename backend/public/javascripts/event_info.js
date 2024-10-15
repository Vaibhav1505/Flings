var json = {};
var optionsArray = [];
var selectedVariants = [];
var existingVariants = [];


class Variant{
    constructor(obj) {
        this.obj= obj;
        this.d = this.getView();
    }
    getCheckBox(){
        return this.d.getElementsByTagName('input')[0];
    }
    getViewObject(){return this.d};
    getJson(){return this.obj}
    getVariantId(){return this.obj._id;}
    geteventId(){return this.obj.thing_id;}
    getImage(){return this.obj.image;}
    getTitle(){return this.obj.title;}
    getPrice(){return this.obj.price;}
    getQuantity(){return this.obj.inventory_quantity;}

    updateField(field,value,cb){
        $.ajax({
            url:'/admin/variants/'+this.getVariantId(),
            method:'PUT',
            data:{_id:this.getVariantId(),thing_id:this.geteventId(),field:field,value:value},
            success:function(data,textStatus,xhr){
                cb(xhr,textStatus);
            },
            error:function(xhr,textStatus,err){
                cb(xhr,textStatus);
            }
        })
    }

    deleteVariant(cb){
        $.ajax({
            url:'/admin/events/'+this.geteventId()+"/variants/"+this.getVariantId(),
            method:'DELETE',
            data:{},
            success:function(data,textStatus,xhr){
                cb(xhr,textStatus);
            },
            error:function(xhr,textStatus,err){
                cb(xhr,textStatus);
            }
        })
    }

    getView(){
        var v = this;
        var d = __cd('div','variant-preview',{},null);
        var d1 = __cd('div',null,{},null);
        var d1e = __cd('input',null,{type:'checkbox'},null)
        var d2 = __cd('div',null,{},null);
        var d2e = __cd('img',null,{src:"/admin/events/media/"+this.getImage()+"_small"},null);
        var d3 = __cd('div',null,{},null);
        var d3e = __cd('span',null,{},this.getTitle());
        var d4 = __cd('div',null,{},null);
        var d4e = __cd('input',null,{type:'number',value:this.getPrice()},null);
        var d4b = __cd('span','small-text-button',{hidden:true},'Save');
        var d5 = __cd('div',null,{},null);
        var d5e = __cd('input',null,{type:'number',value:this.getQuantity()},null);
        var d5b = __cd('span','small-text-button',{hidden:true},'Save');
        var d6 = __cd('div',null,{},null);
        var d6b = __cd('button','button',{},'<i class=\'bx bxs-trash\'></i>');
        d6b.style.fontSize = "16px";

        d6.appendChild(d6b);

        d1e.addEventListener('change',function(){
            d.classList.toggle('selected');
            if(d1e.checked){selectedVariants.push(v);}else{selectedVariants.remove(v)}
        });

        d1.appendChild(d1e);
        d2.appendChild(d2e);
        d3.appendChild(d3e);
        d4.appendChild(d4e);
        d4.appendChild(d4b);
        d5.appendChild(d5e);
        d5.appendChild(d5b);
        d.appendChild(d1);
        d.appendChild(d2);
        d.appendChild(d3);
        d.appendChild(d4);
        d.appendChild(d5);
        d.appendChild(d6);

        d4e.style.display ='block';
        d5e.style.display='block';
        d4e.addEventListener('change',function (){
            d4b.hidden = false;
        });
        d5e.addEventListener('change',function (){
            d5b.hidden = false;
        });

        d4b.addEventListener('click',function (){
            v.updateField('price',d4e.value,function(xhr,textStatus){
                if(xhr.status==200){
                    console.log('success');
                    d4b.hidden = true;
                }else{
                    console.log('error');
                }
            });
        });

        d5b.addEventListener('click',function (){
            v.updateField('inventory_quantity',d5e.value,function(xhr,textStatus){
                if(xhr.status==200){
                    console.log('success');
                    d5b.hidden = true;
                }else{
                    console.log('error');
                }
            });
        });

        d6b.addEventListener('click',function(){
            new Modal('confirm',"Are you sure you want to remove this variant?",function (){
                v.deleteVariant(function(xhr,textStatus){
                    if(xhr.status==200){
                        d.remove();
                    }else{
                        console.log('error');
                    }
                });
            }) ;
        });

        document.querySelector('#variants').appendChild(d);
        existingVariants.push(v);
        return d;
    }

}
function selectAllVariants(checkbox){
    selectedVariants = [];
    for(var i=0;i<existingVariants.length;i++){
        var a = existingVariants[i];
        var b = a.getViewObject();
        var c = a.getCheckBox();

        if(checkbox.checked){
            c.checked = true;
            if(!b.classList.contains('selected'))
                b.classList.add('selected');

            selectedVariants.push(existingVariants[i]);

        }else{
            c.checked = false;
            if(b.classList.contains('selected'))
                b.classList.remove('selected');

            selectedVariants.remove(existingVariants[i]);

        }
    }


}
class Modal{
    constructor(type,msg,func) {
        this.type = type;
        this.msg = msg;
        this.func = func;
        this.model = this.open();

    }


    open() {
        var t = this;
        var o = __cd('div', 'overlay', {}, null);
        var a = __cd('div', 'modal-container', {}, null);
        var b = __cd('span',null,{},t.msg);
        var d = __cd('div',null,{},null);
        var e = __cd('button','button',{},null);
        var f = __cd('button','button black',{},null);
        d.appendChild(e);
        e.style.marginTop = "24px"
        f.style.marginLeft = "16px";
        f.style.marginTop = "24px";


        if(t.type=='alert'){
            e.innerHTML = "OK";
            e.addEventListener('click',function () {
                o.remove();
            });
        }else if(t.type=='confirm'){
            e.innerHTML = "Yes";
            e.addEventListener('click',function () {
                t.func();
                o.remove();
            });
            f.innerHTML = "No";
            f.addEventListener('click',function () {
                o.remove();
            });
            d.appendChild(f);
        }else{
            throw 'Invalid dialog type';
        }


        a.appendChild(b);
        a.appendChild(d);
        o.appendChild(a);

        var g = document.getElementsByTagName('body')[0];
        g.insertBefore(o,g.childNodes[0]);
        return o;
    }


}


class Option{
    constructor(name,values,thing_id) {
        this.name = name;
        this.thing_id = thing_id;
        this.values = values;
    }

    getJson(){
        return {"name":this.name,"values":this.values,"thing_id":this.thing_id};
    }

    getViewModel(){
        var o = this;

        var a = __cd('div','variant-option-container padding-16',{},null);
        var b = __cd('div','first-part',{},null);
        var c = __cd('div','second-part',{},null);
        var d = __cd('input',null,{'type':'text'},null);
        var e = __cd('div',null,{},null);
        var f = __cd('span',null,{},"Option Name");
        var g = __cd('div','small-text-button',{},null);
        var h =__cd('span',null,{},"Remove")
        var i = __cd('div',null,{},null);
        var j = __cd('div',null,{},null);
        i.style.display = 'inline';
        j.style.width = '100%';
        j.style.display = "block";
        j.style.height ='auto';
        var k = __cd('div',null,{contentEditable:true},null);
        k.style.width = '100%';
        k.style.height = 'auto';
        k.style.display = 'block';

        i.appendChild(j);
        i.appendChild(k);

        d.addEventListener('change',function(){
            if(this.value.length>0){
                o.name = this.value;
            }
        });
        k.setAttribute("placeholder","Seperate options with a comma");
        k.addEventListener('focus',function (){
            if(d.value.length>0){

            }else{
                new Modal('alert','Enter option name first!',null);
                return false;
            }
        });
        k.addEventListener('keyup',function(event){
            if(event.keyCode==188){
                var t = this.textContent;
                t = t.replace(/,\s*$/, "");

                var tag = __cd('div','value-tag',{},"<span>"+t+"</span>");
                var iTag = __cd('i','bx bxs-x-square',{},'');
                tag.style.marginTop = "8px";
                this.innerHTML="";
                tag.appendChild(iTag);
                j.appendChild(tag);

                iTag.addEventListener('click',function(){
                    o.values.remove(t);
                    tag.remove();

                });
                o.values.push(t);
            }

        });
        h.onclick = function (){
            new Modal('confirm',"Are you sure you want to remove this option?",function (){
                for(var index=0;index<optionsArray.length;index++){
                    console.log(optionsArray[index].getJson());

                }
                a.parentElement.removeChild(a);
                optionsArray.remove(o);
                console.log("===========AFTER===============");
                for(var index=0;index<optionsArray.length;index++){
                    console.log(optionsArray[index].getJson());

                }
                if(optionsArray.length==0)
                    document.querySelector("#save-variants").hidden = true;

            });


        };

        e.appendChild(f);
        b.appendChild(e);
        b.appendChild(__cd('br','',{},null));
        b.appendChild(d);

        g.appendChild(h);
        c.appendChild(g);
        c.appendChild(__cd('br','',{},null));

        c.appendChild(i);

        a.appendChild(b);
        a.appendChild(c);

        return a;
    }
}
function changePageTitle(elem){
    var pt = document.getElementsByClassName('page-title')[0];
    pt.innerHTML = elem.value;
}

function setAttributes(el, attrs) {
    for(var key in attrs) {
        el.setAttribute(key, attrs[key]);
    }
}
function __cd(tag, className, attributeJson, innerHtml){
    var element = document.createElement(tag);
    if(className!=null)
        element.className = className;

    setAttributes(element,attributeJson);
    if(innerHtml!=null){
        element.innerHTML = innerHtml;
    }
    return element
}


function showVariantOptions(element){
    if(element.checked)
        document.getElementById("variant-container").hidden = false;
    else
        document.getElementById('variant-container').hidden = true
}

function initialize(elementId,value){
    document.getElementById(elementId).value = value;
}
Array.prototype.remove = function(elem) {
    var indexElement = this.findIndex(el => el === elem);
    if (indexElement != -1)
        this.splice(indexElement, 1);
    return this;
};

function getLastParamUrl(){
    return window.location.href.substring(window.location.href.lastIndexOf('/') + 1);
}

class Media{
    constructor(obj) {
        this.obj = obj;
        document.getElementById('media-container').appendChild(this.getView());
        this.hideAllPopups();

    }
    getMediaId(){
        return this.obj._id;
    }
    geteventId(){
        return this.obj.thing_id;
    }
    getCreatedAt(){
        return moment.unix(this.obj.created_at).format("DD MMM YYYY hh:mm A");
    }

    getThumbImgSrc(){
        return location.protocol+'//'+location.host+"/events/media/"+this.getMediaId()+'_small';
    }

    getLargeImgSrc(){
        return location.protocol+'//'+location.host+"/events/media/"+this.getMediaId();

    }

    setAsDefault(cb){
        $.ajax({
            url:'/admin/events/'+this.geteventId(),
            type:"PUT",
            data:{_id:this.geteventId(),field:'image',value:this.getMediaId()},
            success:function(data,textStatus,xhr){
                cb(xhr,textStatus);
            },
            error:function(xhr,textStatus,err){
                cb(xhr,textStatus);
            }
        });
    }

    removeMedia(cb){
        $.ajax({
            url:'/admin/media/remove/'+this.getMediaId(),
            method:'put',
            data:{_id:this.getMediaId(),thing_id:this.geteventId()},
            success:function(data,textStatus,xhr){
                cb(xhr,textStatus);
            },
            error:function(xhr,textStatus,err){
                cb(xhr,textStatus);
            }
        });
    }

    hideAllPopups(){
        window.onclick = function(event) {
            if (event.target.className!="bx bx-dots-vertical-rounded") {
                var p = document.getElementsByClassName("popup-content");
                var i;
                for (i = 0; i < p.length; i++) {
                    p[i].hidden = true;
                }
            }
        }
    }

    getLargeImage(){
        window.open(this.getLargeImgSrc(),'_blank');

    }


    getView(){
        var t = this;
        var a = __cd('div','uploaded-media',{title:"Uploaded on "+this.getCreatedAt()},null);
        var g = __cd('img',null,{src:t.getThumbImgSrc(),loading:'lazy'},null);
        g.addEventListener('click',function(){
            t.getLargeImage();
        });
        var b = __cd('div','popup-container',{},null);
        var c = __cd('i','bx bx-dots-vertical-rounded',{},null);
        var d = __cd('div','popup-content',{hidden:true},null);
        var e = __cd('span',null,{},'Set as default');
        var f = __cd('span',null,{},'Remove');

        d.appendChild(e);
        d.appendChild(f);

        c.addEventListener('click',function(){
            d.hidden = false;
        });

        e.addEventListener('click',function (){
            new Modal('confirm','Are you sure want to set this media as default/main for this event?',function () {
                t.setAsDefault(function(xhr,textStatus){
                    if(xhr.status==201){
                        document.getElementById('image').src=t.getThumbImgSrc();
                    }
                });
            });


        });

        f.addEventListener('click',function (){
            new Modal('confirm',"Are you sure you want to remove this media?",function (){
                t.removeMedia(function(xhr,textStatus){
                    if(xhr.status==201){
                        a.remove();
                    }
                });
            });
        });

        b.appendChild(c);
        b.appendChild(d);
        a.appendChild(g);
        a.appendChild(b);


        return a;
    }
}





//session storage logic
class Session extends Map {
    set(id, value) {
        if (typeof value === 'object') value = JSON.stringify(value);
        sessionStorage.setItem(id, value);
    }

    get(id) {
        const value = sessionStorage.getItem(id);
        try {
            return JSON.parse(value);
        } catch (e) {
            return value;
        }
    }
}

class event{
    constructor(a) {
        this._id = a._id;
        this.type = a.type;
        this.title = a.title;
        this.media = a.media;
        this.created_at = a.created_at;
        this.updated_at = a.updated_at;
        this.options = a.options;
        this.category = a.category;
        this.status = a.status;
        this.price = a.price;
        this.cost = a.cost;
        this.variants = a.variants;
        this.tags = a.tags;
    }
    getId(){
        return this._id;
    }
    getTitle(){
        return this.title;
    }

}

function updateEvent(_id,domElement,beforeSend,complete,cb){
    $.ajax({
        url:'/admin/events/'+_id,
        type:"PUT",
        data:{_id:_id,field:domElement.id,value:getFieldValue(domElement)},
        beforeSend:beforeSend,
        complete:complete,
        success:function(data,textStatus,xhr){
            cb(xhr,textStatus);
        },
        error:function(xhr,textStatus,err){
            cb(xhr,textStatus);
        }
    });
}

function getFieldValue(domElement){
    if(domElement.id=='description')
        return $('#'+domElement.id). summernote('code');
    else if(domElement.id=='online')
        return domElement.checked;
    else
        return domElement.value;
}

function addSaveListeners(){
    var arr = document.getElementsByClassName('field');
    for(var i=0;i<arr.length;i++){

        const save = arr[i].getElementsByTagName('span')[0];
        const field = arr[i].children[1];
        if(field.id=="description"){
            $('#description').on('summernote.change', function(we, contents, $editable) {
                save.hidden = false;
            });


        }else{
            field.addEventListener('change',function(){
                save.hidden = false;
            });
        }



        function beforeSend(){
            save.innerHTML=('Saving...')
            save.classList.add('loading-text');
        }
        function complete(){
            save.innerHTML = ('Save');
            save.classList.remove('loading-text');
        }
        save.addEventListener('click',function(){
            updateEvent(getLastParamUrl(),field,beforeSend,complete,function(xhr,textStatus){
                if(xhr.status==201){
                    save.hidden = true;
                }else if(xhr.status==400||xhr.status==500||xhr.status==404){
                    save.hidden = false;
                }else{
                    save.hidden = true;
                }
            });
        });

    }

    document.querySelector("#online").addEventListener('change',function(){
       var a = document.querySelector('#venue-card');
        (this.checked)?a.hidden=true:a.hidden=false;
    });

    document.querySelector("#add-option").addEventListener('click',function (){
        var option = new Option("",[],getLastParamUrl());
        optionsArray.push(option);
        document.querySelector("#save-variants").hidden = false;
        document.getElementById("options").appendChild(option.getViewModel());
        for(var index=0;index<optionsArray.length;index++){
            console.log(optionsArray[index].getJson());

        }
    });

    document.querySelector('#save-variants').addEventListener('click',function(){
        var empty = false;
        for(var i=0;i<optionsArray.length;i++){
            var o = optionsArray[i].getJson();
            if(o.name.length<1||o.name.length==''||o.values.length==0){
                empty = true;
                break;
            }
        }

        if(empty)
            return new Modal('alert',"Option name and values cannot be blank. Either remove it or fill valid name and values",null);

        var optArray =[];

        for(var i=0;i<optionsArray.length;i++){
            optArray.push(optionsArray[i].getJson());
        }


        $.ajax({
            url:'/admin/events/'+getLastParamUrl()+"/options",
            method:'post',
            data:{options:JSON.stringify(optArray),thing_id:getLastParamUrl()},
            success:function(data,textStatus,xhr){
                console.log(xhr.status);
            }
        });


    });
}