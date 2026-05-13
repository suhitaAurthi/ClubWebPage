document.addEventListener("DOMContentLoaded", function () {
    const form = document.getElementById("form2");

    const username = document.getElementById("username");
    const password = document.getElementById("password");

    const usernameError = document.getElementById("usernameError");
    const passwordError = document.getElementById("passwordError");

    form.addEventListener("submit", function (e) {
        let isValid = true;

        usernameError.textContent = "";
        passwordError.textContent = "";

        if (username.value.trim() === "") {
            usernameError.textContent = "Username or email is required.";
            isValid = false;
        }

        if (password.value.trim() === "") {
            passwordError.textContent = "Password is required.";
            isValid = false;
        }

        if (password.value.trim().length > 0 && password.value.trim().length < 6) {
            passwordError.textContent = "Password must be at least 6 characters.";
            isValid = false;
        }

        if (!isValid) {
            e.preventDefault();
        }
    });
});