const redis = require("redis");

const keys = require("./keys");

const redisClient = redis.createClient({
    host: keys.redisHost,
    port: keys.redisPort,
    retry_strategy: () => 1000,
});

const sub = redisClient.duplicate();

function fib(index) {
    if (index < 2) return 1;
    return fib(index - 1) + fib(index - 2);
}

sub.on("message", (channel, message) => {
    const calculated = fib(parseInt(message));
    console.log(message, calculated);
    redisClient.hset("values", message, calculated);
});
sub.subscribe("insert");
