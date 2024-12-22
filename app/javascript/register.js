document.addEventListener('DOMContentLoaded', function () {
    const form = document.getElementById('register-form');
    const successMessage = document.getElementById('success-message');
    const errorMessage = document.getElementById('error-message');
    const errorList = document.getElementById('error-list');
    const userIdElement = document.getElementById('users-id');
    const userUsernameElement = document.getElementById('users-username');

    form.addEventListener('submit', function (event) {
        event.preventDefault(); // Предотвращаем стандартное поведение формы

        const formData = new FormData(form);
        const data = {
            username: formData.get('username'),
            password: formData.get('password'),
            weight: formData.get('weight'),
            height: formData.get('height'),
            birth_day: formData.get('birth_day'),
            goal: formData.get('goal'),
            sex: formData.get('sex')
        };

        fetch('/users/register', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(data),
        })
            .then(response => response.json())
            .then(data => {
                if (data.id) {

                    successMessage.style.display = 'block';
                    userIdElement.textContent = data.id;
                    userUsernameElement.textContent = data.username;

                    // Скрываем ошибки (если были)
                    errorMessage.style.display = 'none';
                } else {
                    errorMessage.style.display = 'block';
                    errorList.innerHTML = ''; // Очистить список ошибок
                    data.errors.forEach(error => {
                        const li = document.createElement('li');
                        li.textContent = error;
                        errorList.appendChild(li);
                    });

                    successMessage.style.display = 'none';
                }
            })
            .catch(error => {
                console.error('Ошибка при регистрации:', error);
                errorMessage.style.display = 'block';
                errorList.innerHTML = '<li>Произошла ошибка при регистрации.</li>';
            });
    });
});
