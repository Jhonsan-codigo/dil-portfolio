document.addEventListener("DOMContentLoaded", function () {
    const canvas = document.getElementById("ai-bg");
    if (!canvas) return;

    const ctx = canvas.getContext("2d");
    let particles = [];
    let width, height;

    function resize() {
        width = canvas.width = window.innerWidth;
        height = canvas.height = window.innerHeight;
        createParticles();
    }

    function createParticles() {
        const total = Math.floor((width * height) / 15000);
        particles = [];
        for (let i = 0; i < total; i++) {
            particles.push({
                x: Math.random() * width,
                y: Math.random() * height,
                vx: (Math.random() - 0.5) * 0.33,
                vy: (Math.random() - 0.5) * 0.33,
                r: Math.random() * 2 + .8
            });
        }
    }

    function draw() {
        ctx.clearRect(0, 0, width, height);

        for (let i = 0; i < particles.length; i++) {
            const p = particles[i];
            p.x += p.vx;
            p.y += p.vy;

            if (p.x < 0 || p.x > width) p.vx *= -1;
            if (p.y < 0 || p.y > height) p.vy *= -1;

            ctx.beginPath();
            ctx.arc(p.x, p.y, p.r, 0, Math.PI * 2);
            ctx.fillStyle = "rgba(255, 56, 95, 0.50)";
            ctx.fill();

            for (let j = i + 1; j < particles.length; j++) {
                const p2 = particles[j];
                const dx = p.x - p2.x;
                const dy = p.y - p2.y;
                const dist = Math.sqrt(dx * dx + dy * dy);

                if (dist < 140) {
                    ctx.beginPath();
                    ctx.moveTo(p.x, p.y);
                    ctx.lineTo(p2.x, p2.y);
                    ctx.strokeStyle = `rgba(255, 244, 246, ${0.14 * (1 - dist / 140)})`;
                    ctx.lineWidth = 1;
                    ctx.stroke();
                }
            }
        }

        requestAnimationFrame(draw);
    }

    window.addEventListener("resize", resize);
    resize();
    draw();
});
