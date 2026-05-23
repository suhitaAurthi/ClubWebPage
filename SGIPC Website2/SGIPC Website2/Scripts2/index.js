document.addEventListener("DOMContentLoaded", function () {
    // Hamburger Menu Toggle
    const hamburgerToggle = document.getElementById("hamburger-toggle");
    const sidebar = document.querySelector(".sidebar");
    const hamburger = document.querySelector(".hamburger");
    const sidebarLinks = document.querySelectorAll(".sidebar-link");
    const authLinks = document.querySelectorAll(".auth-links a");
    const menuSearch = document.getElementById("menuSearch") || document.querySelector(".sidebar-search input");

    // Close sidebar when clicking outside
    // document.addEventListener("click", function (event) {
    //     if (!hamburgerToggle || !sidebar || !hamburger) return;
    //
    //     const clickedHamburger = hamburger.contains(event.target);
    //     const clickedSidebar = sidebar.contains(event.target);
    //
    //     if (!clickedHamburger && !clickedSidebar) {
    //         hamburgerToggle.checked = false;
    //     }
    // });

    // Close sidebar after clicking a menu link
    // sidebarLinks.forEach(function (link) {
    //     link.addEventListener("click", function () {
    //         if (hamburgerToggle) {
    //             hamburgerToggle.checked = false;
    //         }
    //     });
    // });

    // Close sidebar after clicking an auth link
    // authLinks.forEach(function (link) {
    //     link.addEventListener("click", function () {
    //         if (hamburgerToggle) {
    //             hamburgerToggle.checked = false;
    //         }
    //     });
    // });

    // Sidebar search filter
    if (menuSearch) {
        menuSearch.addEventListener("input", function () {
            const searchText = menuSearch.value.toLowerCase().trim();
            sidebarLinks.forEach(function (link) {
                const linkText = link.textContent.toLowerCase().trim();
                link.style.display = linkText.includes(searchText) ? "flex" : "none";
            });
        });
    }

    // Highlight active page link
    const currentPage = window.location.pathname.split("/").pop().toLowerCase();
    sidebarLinks.forEach(function (link) {
        const linkPage = link.getAttribute("href").toLowerCase();
        link.classList.remove("active");
        if (linkPage === currentPage || (currentPage === "" && linkPage === "index.aspx")) {
            link.classList.add("active");
        }
    });

    // Learn more button - redirects to about page
    const learnMoreBtn = document.querySelector(".cta-button");
    if (learnMoreBtn) {
        learnMoreBtn.addEventListener("click", function (event) {
            event.preventDefault();
            window.location.href = "about.aspx";
        });
    }
});