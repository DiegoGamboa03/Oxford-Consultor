const { Router } = require('express');
const router = new Router();
const conn = require('../Config/DatabaseConfig');

router.get('/', (req, res) => {
    const sql = 'SELECT * FROM PhoneNumbers';

conn.query(sql, (error, results) => {
    if (error){
        res.send(error.message);
        return;
    }
    if (results.length > 0) {
      res.json(results);
    }else{
      res.statusCode = 202;
      res.send('No rules found');
      return;
    }
    });
});

router.get('/availablePhoneNumbers', (req, res) => {
    const sql = 'SELECT phone_number FROM available_phone_numbers';

conn.query(sql, (error, results) => {
    if (error){
        res.send(error.message);
        return;
    }
    if (results.length > 0) {
      res.json(results);
    }else{
      res.statusCode = 202;
      res.send('No rules found');
      return;
    }
    });
});

router.post('/create', (req, res) => {
    const sql = `CALL create_phone_number(${req.body.phone_number})`;
    
    conn.query(sql, error => {
        if (error){
          if(error.errno == 1054) {
            res.statusCode = 202; 
            res.send('No rule found');
            return;
          }
          res.statusCode = 500;
          res.send(error.sqlMessage);
          return;
        }
        res.send('Phone number created!');
    });
});

router.put('/updateObservation', (req, res) => {
    const sql = `CALL update_observation(${req.body.phone_number},${req.body.observation})`;
    
    conn.query(sql, error => {
        if (error){
          if(error.errno == 1054) {
            res.statusCode = 202; 
            res.send('No rule found');
            return;
          }
          res.statusCode = 500;
          res.send(error.sqlMessage);
          return;
        }
        res.send('Phone number created!');
    });
});



module.exports = router;