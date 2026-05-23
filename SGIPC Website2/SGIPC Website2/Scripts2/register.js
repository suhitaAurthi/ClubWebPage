document.addEventListener("DOMContentLoaded", function () {
    const form = document.getElementById("form2");

    const fullname = document.getElementById("fullname");
    const username = document.getElementById("username");
    const email = document.getElementById("email");
    const password = document.getElementById("password");
    const confirmPassword = document.getElementById("confirmPassword");

    const confirmPasswordError = document.getElementById("confirmPasswordError");

    form.addEventListener("submit", function (e) {
        let isValid = true;

        confirmPasswordError.textContent = "";

        if (fullname.value.trim() === "") {
            alert("Full name is required.");
            isValid = false;
        }
        else if (roll.value.trim() === "") {
            alert("Roll number is required.");
            isValid = false;
        }
        else if (email.value.trim() === "") {
            alert("Email is required.");
            isValid = false;
        }
        else if (!email.value.includes("@stud.kuet.ac.bd")) {
            alert("You must give your student email to register.");
            isValid = false;
        }
        else if (password.value.trim() === "") {
            alert("Password is required.");
            isValid = false;
        }
        else if (password.value.trim().length < 6) {
            alert("Password must be at least 6 characters.");
            isValid = false;
        }
        else if (confirmPassword.value.trim() === "") {
            confirmPasswordError.textContent = "Confirm password is required.";
            isValid = false;
        }
        else if (password.value !== confirmPassword.value) {
            confirmPasswordError.textContent = "Password and Confirm Password do not match.";
            isValid = false;
        }

        if (!isValid) {
            e.preventDefault();
        }
    });

    confirmPassword.addEventListener("input", function () {
        if (password.value !== confirmPassword.value) {
            confirmPasswordError.textContent = "Password and Confirm Password do not match.";
        } else {
            confirmPasswordError.textContent = "";
        }
    });

    password.addEventListener("input", function () {
        if (confirmPassword.value !== "" && password.value !== confirmPassword.value) {
            confirmPasswordError.textContent = "Password and Confirm Password do not match.";
        } else {
            confirmPasswordError.textContent = "";
        }
    });
});
