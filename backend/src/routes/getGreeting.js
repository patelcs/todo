const GREETING = 'Hello to my world!';

module.exports = async (req, res) => {
    res.send({
        greeting: GREETING,
    });
};
