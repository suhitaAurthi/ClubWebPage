document.addEventListener("DOMContentLoaded", function () {
    const form = document.getElementById("form2");

    const roll = document.getElementById("roll");
    const password = document.getElementById("password");

    const rollError = document.getElementById("rollError");
    const passwordError = document.getElementById("passwordError");

    document.querySelectorAll(".password-toggle").forEach(function (button) {
        button.addEventListener("click", function (e) {
            e.preventDefault();

            const input = document.getElementById(button.dataset.target);
            const icon = button.querySelector(".material-symbols-outlined");

            if (!input || !icon) {
                return;
            }

            const isHidden = input.type === "password";

            input.type = isHidden ? "text" : "password";
            icon.textContent = isHidden ? "visibility_off" : "visibility";
            button.setAttribute("aria-label", isHidden ? "Hide password" : "Show password");
        });
    });

    if (!form || !roll || !password || !rollError || !passwordError) {
        return;
    }

    form.addEventListener("submit", function (e) {
        let isValid = true;

        rollError.textContent = "";
        passwordError.textContent = "";

        if (roll.value.trim() === "") {
            rollError.textContent = "Roll or email is required.";
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
