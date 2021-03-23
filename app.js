const express = require('express');
const app = express();
const PORT = 3000;

const winston = require('winston');

const logger = winston.createLogger({
    level: 'info',
    format: winston.format.json(),
    defaultMeta: { service: 'devops' },
    transports: [
      //
      // - Write all logs with level `error` and below to `error.log`
      // - Write all logs with level `info` and below to `combined.log`
      //
      new winston.transports.File({ filename: 'error.log', level: 'error' }),
      new winston.transports.File({ filename: 'combined.log' }),
    ],
  });

app.get('/', function (req, res) {

    logger.log({
        level: 'error',
        message: 'Hello distributed log files!'
    });

    logger.log({
        level: 'info',
        message: 'This log won\'t be saved'
    });

    return res.status(200).json({
        hello: 'world'
    });
});

app.listen(PORT, () => {
    console.log(`Server listening on port ${PORT}`)
});