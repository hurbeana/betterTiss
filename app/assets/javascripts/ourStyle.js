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


/*
let coll = document.getElementsByClassName("collapsible");
let i;

for (i = 0; i < coll.length; i++) {
    coll[i].addEventListener("click", function() {
        this.classList.toggle("active");
        let content = this.nextElementSibling;
        if (content.style.maxHeight){
            content.style.maxHeight = null;
        } else {
            content.style.maxHeight = content.scrollHeight + "px";
        }
    });
}*/


function openCollapsible(element) {
    let content = element.nextElementSibling;
    if (content.style.maxHeight) {
        content.style.maxHeight = null;
        element.classList.toggle("active")
    } else {
        content.style.maxHeight = content.scrollHeight + "px";
        element.classList.toggle("active")
    }
}


/* for burger menu toggle */
function toggleBurgerMenu(x) {
    x.classList.toggle("change");
}


/* sort stuff */
function onSortClick(pOdSortAttr, sortClassName, sortBy) {
    let arrow = pOdSortAttr.firstElementChild;
    changeArrow(arrow);

    let isArrowUp = arrow.classList.contains("arrow_up");

    let sortContainer = $("#" + sortClassName);
    let cardsToSort = $("." + sortClassName);

    switch (sortBy) {
        case "title":
            mySort(sortContainer, cardsToSort, ".sort_title", isArrowUp);
            break;
        case "date":
            mySort(sortContainer, cardsToSort, ".sort_date", isArrowUp);
            break;
        default:
            break;
    }
}

function mySort(container, toSort, sortBy, asc) {
    let sorted = toSort.sort((a, b) => {
        let attr_a = $(a).find(sortBy).text();
        let attr_b = $(b).find(sortBy).text();
        if ((asc ? attr_a : attr_b) > (asc ? attr_b : attr_a)) {
            return 1;
        } else if ((asc ? attr_a : attr_b) < (asc ? attr_b : attr_a)) {
            return -1;
        } else {
            return 0;
        }
    });
    container.html(sorted);
}

function changeArrow(arrow) {
    if (arrow.classList.contains("arrow_up")) {
        arrow.classList.remove("arrow_up");
        arrow.classList.add("arrow_down");
    } else {
        arrow.classList.remove("arrow_down");
        arrow.classList.add("arrow_up");
    }
}