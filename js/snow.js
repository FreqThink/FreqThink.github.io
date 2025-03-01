// snow.js - 雪花特效的实现
(function() {
    var snowflakes = []; // 存储雪花的数组

    // 雪花的构造函数
    function Snowflake() {
        this.x = Math.random() * window.innerWidth;  // 雪花的横坐标
        this.y = -Math.random() * window.innerHeight; // 雪花的纵坐标
        this.size = Math.random() * 5 + 2;  // 雪花的大小
        this.speed = Math.random() * 3 + 1;  // 雪花下落的速度
        this.opacity = Math.random() * 0.5 + 0.3;  // 雪花的透明度
    }

    // 绘制雪花
    function drawSnowflakes() {
        var canvas = document.getElementById("snowCanvas");
        var ctx = canvas.getContext("2d");

        // 清空画布
        ctx.clearRect(0, 0, canvas.width, canvas.height);

        // 绘制每一颗雪花
        snowflakes.forEach(function(snowflake) {
            ctx.beginPath();
            ctx.arc(snowflake.x, snowflake.y, snowflake.size, 0, Math.PI * 2);
            ctx.fillStyle = "rgba(255, 255, 255, " + snowflake.opacity + ")";
            ctx.fill();
        });

        // 更新雪花位置
        snowflakes.forEach(function(snowflake, index) {
            snowflake.y += snowflake.speed;
            if (snowflake.y > canvas.height) {
                snowflakes[index] = new Snowflake();  // 如果雪花下落到屏幕底部，重新生成一个雪花
            }
        });

        requestAnimationFrame(drawSnowflakes);  // 继续下一帧动画
    }

    // 初始化雪花
    function initSnow() {
        var canvas = document.createElement("canvas");
        canvas.id = "snowCanvas";
        canvas.style.position = "fixed";
        canvas.style.top = "0";
        canvas.style.left = "0";
        canvas.style.pointerEvents = "none";  // 不阻挡点击事件
        canvas.style.zIndex = "9999";  // 置于最上层
        document.body.appendChild(canvas);

        // 设置画布大小
        canvas.width = window.innerWidth;
        canvas.height = window.innerHeight;

        // 创建雪花
        for (var i = 0; i < 100; i++) {
            snowflakes.push(new Snowflake());
        }

        // 开始绘制雪花
        drawSnowflakes();
    }

    // 调用初始化函数
    initSnow();
})();
