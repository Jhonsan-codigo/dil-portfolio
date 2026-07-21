document.addEventListener("DOMContentLoaded", function () {
    const menuBtn = document.getElementById("menuBtn");
    const mainNav = document.getElementById("mainNav");

    if (menuBtn && mainNav) {
        menuBtn.addEventListener("click", () => mainNav.classList.toggle("open"));
    }

    const revealElements = document.querySelectorAll(".reveal");
    const observer = new IntersectionObserver((entries) => {
        entries.forEach((entry) => {
            if (entry.isIntersecting) entry.target.classList.add("active");
        });
    }, { threshold: 0.12 });

    revealElements.forEach((el, index) => {
        el.style.transitionDelay = (index % 8) * 55 + "ms";
        observer.observe(el);
    });

    document.querySelectorAll(".js-file-form").forEach((form) => {
        form.addEventListener("submit", function (e) {
            const input = form.querySelector("input[type='file']");
            const base64 = form.querySelector("input[name='archivoBase64']");
            const nombre = form.querySelector("input[name='archivoNombre']");
            const tipo = form.querySelector("input[name='archivoTipo']");

            if (!input || !input.files || input.files.length === 0 || !base64) {
                return;
            }

            if (base64.value) {
                return;
            }

            e.preventDefault();

            const file = input.files[0];
            const reader = new FileReader();

            reader.onload = function () {
                base64.value = reader.result;
                if (nombre) nombre.value = file.name;
                if (tipo) tipo.value = file.type || "application/octet-stream";
                form.submit();
            };

            reader.readAsDataURL(file);
        });
    });
});
