document.querySelectorAll('.nav-links a').forEach(link => {
    link.addEventListener('click', function () {
        document.querySelectorAll('.nav-links a').forEach(nav => nav.classList.remove('active'));
        this.classList.add('active');
    });
});
