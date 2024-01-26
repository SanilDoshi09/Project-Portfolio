require('dotenv').config(); // Load environment variables
const express = require('express');
const helmet = require('helmet'); // Security middleware
const morgan = require('morgan'); // Logging middleware

const app = express(); // Create Express app
const PORT = process.env.PORT || 8000; // Use port from environment variables or default to 3000
const portfolioRoutes = require('./routes/portfolioRoutes'); // Import routes

// Middleware
app.use(helmet()); // Use helmet
app.use(morgan('combined')); // Use morgan

app.use(express.json()); // Parse JSON bodies (as sent by API clients)

// Root Route
app.get('/', (req, res) => {
    res.send('Welcome!');
  });
  

// Routes imported from another file
app.use('/portfolio', portfolioRoutes);

// Catch-all route for handling 404 errors
app.use((req, res) => {
    res.status(404).send('Page not found');
});

// Global error handler
app.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(500).send('Something broke!');
});

// Start server
app.listen(PORT, () => {
  console.log(`Server listening on port ${PORT}`);
});