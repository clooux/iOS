const express = require('express');
const bodyParser = require('body-parser');

const app = express();
const port = 3000;

app.use(bodyParser.json());
const users = [];

app.post('/login', (req, res) => {
  const { username, password } = req.body;

  const user = users.find(user => user.username === username);

  if (!user || user.password !== password) {
    return res.status(401).json({ success: false, message: 'Error loggining in' });
  }

  res.json({ success: true, message: 'Logged in', user });
});

app.post('/register', (req, res) => {
  const { username, password } = req.body;

  const newUser = { id: users.length + 1, username, password };
  users.push(newUser);

  res.json({ success: true, message: 'Registered', user: newUser });
});

app.listen(port, () => {
  console.log(`Server listening on port ${port}`);
});