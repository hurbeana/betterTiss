function showMobileNav() {
    let x = document.getElementsByClassName("myLinks");
    let body = document.body;

    for (let y of x) {
        if (y.style.display === "block") {
            y.style.display = "none";
            body.style.paddingTop = '52px';
        } else {
            y.style.display = "block";
            body.style.paddingTop = '207px';
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

    body.style.paddingTop = header.style.height;
}