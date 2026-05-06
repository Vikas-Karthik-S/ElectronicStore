function validateRegisterForm() {
    const password = document.getElementById('password').value;
    const confirm = document.getElementById('confirmPassword').value;

    if (password !== confirm) {
        alert('Passwords do not match');
        return false;
    }
    return true;
}

function checkUsernameAvailability(username) {
    // Optional: Real-time username check via fetch
}