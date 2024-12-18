Here is a basic starter code for your web application using Node.js and Express. This code includes basic functionality for browsing products and adding them to a shopping cart. 

```javascript
const express = require('express');
const app = express();
const port = 3000;

let products = [
    {id: 1, name: 'Product 1', price: 100},
    {id: 2, name: 'Product 2', price: 200},
    {id: 3, name: 'Product 3', price: 300}
];

let cart = [];

app.get('/products', (req, res) => {
    res.json(products);
});

app.get('/cart', (req, res) => {
    res.json(cart);
});

app.post('/cart/:productId', (req, res) => {
    let productId = req.params.productId;
    let product = products.find(p => p.id == productId);

    if (product) {
        cart.push(product);
        res.json({message: 'Product added to cart'});
    } else {
        res.status(404).json({message: 'Product not found'});
    }
});

app.listen(port, () => {
    console.log(`App listening at http://localhost:${port}`);
});
```

To deploy this code to GitHub, you would need to initialize a new Git repository in your project directory, add your files to the repository, commit your changes, and then push your commit to a new repository on GitHub. Here are the commands you would use:

```bash
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/yourusername/yourrepository.git
git push -u origin master
```

Please replace "yourusername" and "yourrepository" with your actual GitHub username and the name of your repository. 

This is a very basic implementation and does not include any persistence or user authentication. You would need to integrate with Azure SQL Database for persistence and Azure Active Directory for user authentication. You would also need to add error handling and validation code for a production-ready application.