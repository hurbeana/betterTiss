function showMobileNav() {
    let x = document.getElementsByClassName("myLinks");
    let inner = document.getElementsByClassName("innerList");
    let body = document.body;

    for (let y of inner) {
        if (y.style.display === "block") {
            y.style.display = "none";
        }
    }

    for (let y of x) {
        if (y.style.display === "block") {
            y.style.display = "none";
        } else {
            y.style.display = "block";
        }
    }
}

function openButtonMobileMenu(element) {
    let x = element.nextElementSibling;
    let body = document.body;
    let header = document.getElementById("header");

    if (x.style.display === "block") {
        x.style.display = "none";
        //element.parentNode.classlist.remove("btnActive");
    } else {
        x.style.display = "block";
        //element.parentNode.classlist.add("btnActive");
    }

    //body.style.paddingTop = header.style.height;
}

function openCollapsible(element) {
    let content = element.nextElementSibling;
    if (content.style.maxHeight){
        content.style.maxHeight = null;
    } else {
        content.style.maxHeight = content.scrollHeight + "px";
    }
}