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

function getProductView(_id,title,imgSrc,category){
    var pd = createDOM('div','product',{},null);
    var img = createDOM('img','product-thumb',{src:(imgSrc?"/products/media/"+imgSrc+"_small":'https://image.flaticon.com/icons/png/128/3308/3308415.png')},null);

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

function getProductsPost(query){
    console.log(query);
    var productsContainer = document.getElementById('products-container');
    $.ajax({
        url:'/admin/products',
        type:"POST",
        data:{query:query},
        beforeSend:function(){
            document.getElementById("progress-bar").hidden = false;
        },
        success:function(data){
            console.log(data);
            productsContainer.innerHTML="";
            if(data.products.length>0){
                for(var i=0;i<data.products.length;i++){
                    productsContainer.appendChild(getProductView(data.products[i]._id,data.products[i].title,data.products[i].image,data.products[i].category));
                }
            }else{
                productsContainer.innerHTML="<div class='product'><center><h1>No data found</h1></center></div>";
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
        var b = __cd('span','modal-title',{},'Add Product');
        var c = __cd('i','bx bxs-x-circle',{},null);
        var e = __cd('input',null,{'placeholder':'Enter title for product','type':'text'},null);
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
           url:'products/new',
           method:'post',
           data:{'title':i},
            success:function(res){
               window.location.href = 'products/'+res.product._id;
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

