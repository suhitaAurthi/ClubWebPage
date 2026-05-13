document.addEventListener("DOMContentLoaded", function () {
    const hamburgerToggle = document.getElementById("hamburger-toggle");
    const sidebar = document.querySelector(".sidebar");
    const hamburger = document.querySelector(".hamburger");
    const sidebarLinks = document.querySelectorAll(".sidebar-link");
    const authLinks = document.querySelectorAll(".auth-links a");

    const menuSearch =
        document.getElementById("menuSearch") ||
        document.querySelector(".sidebar-search input");

    if (!hamburgerToggle || !sidebar || !hamburger) {
        return;
    }

    // Close sidebar when clicking outside
    document.addEventListener("click", function (event) {
        const clickedHamburger = hamburger.contains(event.target);
        const clickedSidebar = sidebar.contains(event.target);

        if (clickedHamburger || clickedSidebar) {
            return;
        }

        hamburgerToggle.checked = false;
    });

    // Close sidebar after clicking a menu link
    sidebarLinks.forEach(function (link) {
        link.addEventListener("click", function () {
            hamburgerToggle.checked = false;
        });
    });

    // Close sidebar after clicking an auth link (login/register)
    authLinks.forEach(function (link) {
        link.addEventListener("click", function () {
            hamburgerToggle.checked = false;
        });
    });

    // Sidebar search filter
    if (menuSearch) {
        menuSearch.addEventListener("input", function () {
            const searchText = menuSearch.value.toLowerCase().trim();

            sidebarLinks.forEach(function (link) {
                const linkText = link.textContent.toLowerCase().trim();

                if (linkText.includes(searchText)) {
                    link.style.display = "flex";
                } else {
                    link.style.display = "none";
                }
            });
        });
    }

    // Automatically active current page link
    const currentPage = window.location.pathname.split("/").pop().toLowerCase();

    sidebarLinks.forEach(function (link) {
        const linkPage = link.getAttribute("href").toLowerCase();

        link.classList.remove("active");

        if (linkPage === currentPage || currentPage === "" && linkPage === "index.aspx") {
            link.classList.add("active");
        }
    });
});