const thumbnails = document.querySelectorAll(".img-thumb");
thumbnails.forEach((item, i) => {
    item.addEventListener('click', function() {
        // Set hover property for this img
        item.classList.add("hover");

        // Unset hover property for other imgs
        for (var j = 0; j < thumbnails.length; j++) {
            if (j != i) {
                thumbnails[j].classList.remove("hover");
            }
        }

        // Set main image on page
        var basename = item.querySelector("img").getAttribute("data-basename");
        var el = document.querySelector(".main-img img");
        el.setAttribute("src", "/assets/images/" + basename + "_full.jpg");
    })
  });
