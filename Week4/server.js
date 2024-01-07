const express = require('express');
const app = express();
const port = 3000;

const products = [
  { id: 1, name: 'Product 1' },
  { id: 2, name: 'Product 2' },
  { id: 3, name: 'Product 3' }
];

const categories = [
  { id: 1, name: 'Category 1' },
  { id: 2, name: 'Category 2' },
  { id: 3, name: 'Category 3' }
];

app.get('/products', (req, res) => {
  res.json(products);
});

app.get('/categories', (req, res) => {
  res.json(categories);
});

app.listen(port, () => {
  console.log(`Server listening on port ${port}`);
});
