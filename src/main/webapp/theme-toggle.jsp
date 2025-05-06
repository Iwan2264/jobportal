<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Theme Toggle</title>
    <style>
        .theme-toggle {
            background: none;
            border: none;
            cursor: pointer;
            font-size: 1.5rem;
            padding: 0.5rem;
            position: fixed;
            bottom: 20px;
            right: 20px;
            z-index: 1000;
            transition: transform 0.3s;
        }
        .theme-toggle:hover {
            transform: scale(1.2);
        }
    </style>
</head>
<body>

<button onclick="toggleTheme()" class="theme-toggle" aria-label="Toggle theme">
    <span id="theme-icon">🌙</span>
</button>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        const savedTheme = localStorage.getItem('theme') || 'light';
        document.documentElement.classList.add(savedTheme);
        document.getElementById('theme-icon').textContent = 
            savedTheme === 'dark' ? '🌞' : '🌙';
    });

    function toggleTheme() {
        const html = document.documentElement;
        const currentTheme = html.classList.contains('dark') ? 'dark' : 'light';
        const newTheme = currentTheme === 'dark' ? 'light' : 'dark';

        html.classList.remove(currentTheme);
        html.classList.add(newTheme);
        document.getElementById('theme-icon').textContent = 
            newTheme === 'dark' ? '🌞' : '🌙';

        localStorage.setItem('theme', newTheme);

        // Optional: Save to server session via AJAX
        fetch('set-theme', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: 'theme=' + encodeURIComponent(newTheme)
        });
    }
</script>

</body>
</html>
